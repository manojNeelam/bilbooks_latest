import 'package:billbooks_app/core/constants/revenuecat_config.dart';
import 'package:billbooks_app/features/more/settings/subscription/domain/entity/revenuecat_entity.dart';
import 'package:flutter/foundation.dart';
import 'package:purchases_flutter/purchases_flutter.dart' as purchases;

abstract class RevenueCatService {
  bool get isSupportedPlatform;
  bool get hasApiKey;
  bool get canUseNativePurchases;

  Future<void> initialize({String? appUserId});
  Future<List<RevenueCatProductEntity>> fetchProducts({String? offeringId});
  Future<RevenueCatCustomerEntity> getCustomerInfo();
  Future<RevenueCatPurchaseResultEntity> purchaseProduct(
      RevenueCatProductEntity product);
  Future<RevenueCatCustomerEntity> restorePurchases();
  Future<bool> validateEntitlement(String entitlementId);
  Future<void> logIn(String appUserId);
  Future<void> logOut();
}

class RevenueCatServiceImpl implements RevenueCatService {
  final Map<String, purchases.Package> _packagesByLookupKey = {};
  bool _initialized = false;

  @override
  bool get isSupportedPlatform => RevenueCatConfig.supportsNativePurchases;

  @override
  bool get hasApiKey => RevenueCatConfig.hasCurrentPlatformApiKey;

  @override
  bool get canUseNativePurchases => isSupportedPlatform && hasApiKey;

  @override
  Future<void> initialize({String? appUserId}) async {
    if (!canUseNativePurchases) {
      return;
    }

    if (_initialized || await purchases.Purchases.isConfigured) {
      _initialized = true;
      if ((appUserId ?? '').trim().isNotEmpty) {
        await purchases.Purchases.logIn(appUserId!.trim());
      }
      return;
    }

    await purchases.Purchases.setLogLevel(
      kDebugMode ? purchases.LogLevel.debug : purchases.LogLevel.info,
    );

    final configuration =
        purchases.PurchasesConfiguration(RevenueCatConfig.currentApiKey);
    if ((appUserId ?? '').trim().isNotEmpty) {
      configuration.appUserID = appUserId!.trim();
    }

    await purchases.Purchases.configure(configuration);
    _initialized = true;
  }

  @override
  Future<List<RevenueCatProductEntity>> fetchProducts(
      {String? offeringId}) async {
    await initialize();
    if (!canUseNativePurchases) {
      return const [];
    }

    final offerings = await purchases.Purchases.getOfferings();
    final offering = _resolveOffering(offerings, offeringId);
    if (offering == null) {
      _packagesByLookupKey.clear();
      return const [];
    }

    _packagesByLookupKey
      ..clear()
      ..addEntries(
        offering.availablePackages.map(
          (package) =>
              MapEntry(_lookupKey(offering.identifier, package), package),
        ),
      );

    return offering.availablePackages
        .map((package) => _mapProduct(offering.identifier, package))
        .toList();
  }

  @override
  Future<RevenueCatCustomerEntity> getCustomerInfo() async {
    await initialize();
    if (!canUseNativePurchases) {
      return const RevenueCatCustomerEntity(
        appUserId: '',
        originalAppUserId: '',
        entitlements: [],
      );
    }

    final customerInfo = await purchases.Purchases.getCustomerInfo();
    final appUserId = await purchases.Purchases.appUserID;

    return _mapCustomerInfo(
      customerInfo,
      appUserId: appUserId,
    );
  }

  @override
  Future<RevenueCatPurchaseResultEntity> purchaseProduct(
    RevenueCatProductEntity product,
  ) async {
    await initialize();
    final package = _packagesByLookupKey[product.lookupKey];
    if (package == null) {
      throw StateError(
        'No RevenueCat package matched ${product.productIdentifier}.',
      );
    }

    final purchaseResult = await purchases.Purchases.purchasePackage(package);
    final appUserId = await purchases.Purchases.appUserID;

    return RevenueCatPurchaseResultEntity(
      product: product,
      customer: _mapCustomerInfo(
        purchaseResult.customerInfo,
        appUserId: appUserId,
      ),
    );
  }

  @override
  Future<RevenueCatCustomerEntity> restorePurchases() async {
    await initialize();
    if (!canUseNativePurchases) {
      return const RevenueCatCustomerEntity(
        appUserId: '',
        originalAppUserId: '',
        entitlements: [],
      );
    }

    final customerInfo = await purchases.Purchases.restorePurchases();
    final appUserId = await purchases.Purchases.appUserID;

    return _mapCustomerInfo(
      customerInfo,
      appUserId: appUserId,
    );
  }

  @override
  Future<bool> validateEntitlement(String entitlementId) async {
    final customer = await getCustomerInfo();
    return customer.hasEntitlement(entitlementId);
  }

  @override
  Future<void> logIn(String appUserId) async {
    await initialize();
    if (!canUseNativePurchases || appUserId.trim().isEmpty) {
      return;
    }
    await purchases.Purchases.logIn(appUserId.trim());
  }

  @override
  Future<void> logOut() async {
    if (!canUseNativePurchases) {
      return;
    }
    await purchases.Purchases.logOut();
  }

  purchases.Offering? _resolveOffering(
    purchases.Offerings offerings,
    String? offeringId,
  ) {
    final preferredOfferingId =
        (offeringId ?? RevenueCatConfig.defaultOfferingIdentifier).trim();
    if (preferredOfferingId.isNotEmpty) {
      final preferredOffering = offerings.all[preferredOfferingId];
      if (preferredOffering != null) {
        return preferredOffering;
      }
    }

    if (offerings.current != null) {
      return offerings.current;
    }

    if (offerings.all.isEmpty) {
      return null;
    }

    return offerings.all.values.first;
  }

  RevenueCatProductEntity _mapProduct(
    String offeringIdentifier,
    purchases.Package package,
  ) {
    final packageType = _enumName(package.packageType);
    return RevenueCatProductEntity(
      lookupKey: _lookupKey(offeringIdentifier, package),
      packageIdentifier: package.identifier,
      productIdentifier: package.storeProduct.identifier,
      offeringIdentifier: offeringIdentifier,
      title: package.storeProduct.title,
      description: package.storeProduct.description,
      priceString: package.storeProduct.priceString,
      packageType: packageType,
      billingCycle: _resolveBillingCycle(packageType),
    );
  }

  RevenueCatCustomerEntity _mapCustomerInfo(
    purchases.CustomerInfo customerInfo, {
    required String appUserId,
  }) {
    return RevenueCatCustomerEntity(
      appUserId: appUserId,
      originalAppUserId: customerInfo.originalAppUserId,
      entitlements: customerInfo.entitlements.all.values
          .map(
            (entitlement) => RevenueCatEntitlementEntity(
              identifier: entitlement.identifier,
              productIdentifier: entitlement.productIdentifier,
              isActive: entitlement.isActive,
              willRenew: entitlement.willRenew,
              latestPurchaseDate: entitlement.latestPurchaseDate,
              expirationDate: entitlement.expirationDate,
            ),
          )
          .toList(),
    );
  }

  RevenueCatBillingCycle _resolveBillingCycle(String value) {
    final normalized = value.toLowerCase();
    if (normalized.contains('month')) {
      return RevenueCatBillingCycle.monthly;
    }
    if (normalized.contains('year') || normalized.contains('annual')) {
      return RevenueCatBillingCycle.yearly;
    }
    return RevenueCatBillingCycle.unknown;
  }

  String _lookupKey(String offeringIdentifier, purchases.Package package) {
    return '$offeringIdentifier::${package.identifier}::${package.storeProduct.identifier}';
  }

  String _enumName(Object value) {
    return value.toString().split('.').last;
  }
}
