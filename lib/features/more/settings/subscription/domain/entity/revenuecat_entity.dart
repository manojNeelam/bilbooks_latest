enum RevenueCatBillingCycle { monthly, yearly, unknown }

class RevenueCatProductEntity {
  final String lookupKey;
  final String packageIdentifier;
  final String productIdentifier;
  final String offeringIdentifier;
  final String title;
  final String description;
  final String priceString;
  final String packageType;
  final RevenueCatBillingCycle billingCycle;

  const RevenueCatProductEntity({
    required this.lookupKey,
    required this.packageIdentifier,
    required this.productIdentifier,
    required this.offeringIdentifier,
    required this.title,
    required this.description,
    required this.priceString,
    required this.packageType,
    required this.billingCycle,
  });

  bool matchesPlan({
    required String planName,
    required RevenueCatBillingCycle cycle,
  }) {
    final normalizedPlan = _normalize(planName);
    final normalizedFields = [
      title,
      description,
      packageIdentifier,
      productIdentifier,
      offeringIdentifier,
      packageType,
    ].map(_normalize).toList();

    final hasPlanMatch = normalizedPlan.isEmpty ||
        normalizedFields.any((field) => field.contains(normalizedPlan));
    final hasCycleMatch = billingCycle == cycle ||
        normalizedFields.any((field) => _containsCycleToken(field, cycle));

    return hasPlanMatch && hasCycleMatch;
  }

  static bool _containsCycleToken(
    String value,
    RevenueCatBillingCycle cycle,
  ) {
    switch (cycle) {
      case RevenueCatBillingCycle.monthly:
        return value.contains('month');
      case RevenueCatBillingCycle.yearly:
        return value.contains('year') || value.contains('annual');
      case RevenueCatBillingCycle.unknown:
        return false;
    }
  }

  static String _normalize(String value) {
    return value.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]+'), ' ').trim();
  }
}

class RevenueCatEntitlementEntity {
  final String identifier;
  final String productIdentifier;
  final bool isActive;
  final bool willRenew;
  final String? latestPurchaseDate;
  final String? expirationDate;

  const RevenueCatEntitlementEntity({
    required this.identifier,
    required this.productIdentifier,
    required this.isActive,
    required this.willRenew,
    required this.latestPurchaseDate,
    required this.expirationDate,
  });
}

class RevenueCatCustomerEntity {
  final String appUserId;
  final String originalAppUserId;
  final List<RevenueCatEntitlementEntity> entitlements;

  const RevenueCatCustomerEntity({
    required this.appUserId,
    required this.originalAppUserId,
    required this.entitlements,
  });

  bool hasEntitlement(String entitlementId) {
    return entitlements.any(
      (entitlement) =>
          entitlement.identifier == entitlementId && entitlement.isActive,
    );
  }

  bool get hasActiveEntitlements {
    return entitlements.any((entitlement) => entitlement.isActive);
  }

  List<String> get activeEntitlementIds {
    return entitlements
        .where((entitlement) => entitlement.isActive)
        .map((entitlement) => entitlement.identifier)
        .toList();
  }
}

class RevenueCatPurchaseResultEntity {
  final RevenueCatProductEntity product;
  final RevenueCatCustomerEntity customer;

  const RevenueCatPurchaseResultEntity({
    required this.product,
    required this.customer,
  });
}
