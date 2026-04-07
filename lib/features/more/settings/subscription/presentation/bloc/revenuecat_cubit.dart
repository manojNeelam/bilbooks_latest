import 'package:billbooks_app/core/constants/revenuecat_config.dart';
import 'package:billbooks_app/core/utils/hive_functions.dart';
import 'package:billbooks_app/features/more/settings/subscription/data/service/revenuecat_service.dart';
import 'package:billbooks_app/features/more/settings/subscription/domain/entity/revenuecat_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'revenuecat_state.dart';

class RevenueCatCubit extends Cubit<RevenueCatState> {
  final RevenueCatService revenueCatService;

  RevenueCatCubit({required this.revenueCatService})
      : super(
          RevenueCatState(
            isSupportedPlatform: revenueCatService.isSupportedPlatform,
            isConfigured: revenueCatService.canUseNativePurchases,
          ),
        );

  Future<void> initialize({String? appUserId}) async {
    final resolvedAppUserId = await _resolveAppUserId(appUserId);

    emit(state.copyWith(
      isLoading: true,
      isSupportedPlatform: revenueCatService.isSupportedPlatform,
      isConfigured: revenueCatService.canUseNativePurchases,
      clearFeedback: true,
    ));

    try {
      await revenueCatService.initialize(appUserId: resolvedAppUserId);
      if (!revenueCatService.canUseNativePurchases) {
        emit(state.copyWith(
          isLoading: false,
          isSupportedPlatform: revenueCatService.isSupportedPlatform,
          isConfigured: false,
          products: const [],
        ));
        return;
      }

      final products = await revenueCatService.fetchProducts();
      final customer = await revenueCatService.getCustomerInfo();

      emit(state.copyWith(
        isLoading: false,
        isSupportedPlatform: revenueCatService.isSupportedPlatform,
        isConfigured: true,
        products: products,
        customer: customer,
      ));
    } catch (error) {
      emit(state.copyWith(
        isLoading: false,
        isConfigured: false,
        errorMessage: _message(error),
      ));
    }
  }

  Future<void> refresh() async {
    await initialize();
  }

  Future<void> logOut() async {
    try {
      await revenueCatService.logOut();
    } catch (_) {
      // Keep logout resilient even if store identity reset fails.
    }

    emit(state.copyWith(
      customer: const RevenueCatCustomerEntity(
        appUserId: '',
        originalAppUserId: '',
        entitlements: [],
      ),
      clearFeedback: true,
    ));
  }

  Future<void> purchasePlan({
    required String planName,
    required RevenueCatBillingCycle cycle,
  }) async {
    if (!state.isConfigured) {
      emit(state.copyWith(
        errorMessage:
            'RevenueCat is not configured for this platform. Add your store API key first.',
      ));
      return;
    }

    final product = _findMatchingProduct(planName: planName, cycle: cycle);
    if (product == null) {
      emit(state.copyWith(
        errorMessage:
            'No RevenueCat product matched "$planName" for ${cycle == RevenueCatBillingCycle.yearly ? 'yearly' : 'monthly'} billing.',
      ));
      return;
    }

    emit(state.copyWith(isPurchaseInProgress: true, clearFeedback: true));

    try {
      final result = await revenueCatService.purchaseProduct(product);
      emit(state.copyWith(
        isPurchaseInProgress: false,
        customer: result.customer,
        successMessage: result.customer.hasActiveEntitlements
            ? 'Purchase completed and entitlements are active.'
            : 'Purchase completed. Waiting for entitlement activation.',
      ));
    } catch (error) {
      emit(state.copyWith(
        isPurchaseInProgress: false,
        errorMessage: _message(error),
      ));
    }
  }

  Future<void> restorePurchases() async {
    if (!state.isConfigured) {
      emit(state.copyWith(
        errorMessage:
            'RevenueCat is not configured for this platform. Add your store API key first.',
      ));
      return;
    }

    emit(state.copyWith(isPurchaseInProgress: true, clearFeedback: true));

    try {
      final customer = await revenueCatService.restorePurchases();
      emit(state.copyWith(
        isPurchaseInProgress: false,
        customer: customer,
        successMessage: customer.hasActiveEntitlements
            ? 'Purchases restored successfully.'
            : 'No active purchase was found to restore.',
      ));
    } catch (error) {
      emit(state.copyWith(
        isPurchaseInProgress: false,
        errorMessage: _message(error),
      ));
    }
  }

  Future<bool> validateEntitlement({String? entitlementId}) async {
    final entitlementToCheck =
        (entitlementId ?? RevenueCatConfig.defaultEntitlementIdentifier).trim();

    try {
      final customer = await revenueCatService.getCustomerInfo();
      emit(state.copyWith(customer: customer));

      if (entitlementToCheck.isEmpty) {
        return customer.hasActiveEntitlements;
      }

      return customer.hasEntitlement(entitlementToCheck);
    } catch (error) {
      emit(state.copyWith(errorMessage: _message(error)));
      return false;
    }
  }

  void clearFeedback() {
    emit(state.copyWith(clearFeedback: true));
  }

  RevenueCatProductEntity? _findMatchingProduct({
    required String planName,
    required RevenueCatBillingCycle cycle,
  }) {
    for (final product in state.products) {
      if (product.matchesPlan(planName: planName, cycle: cycle)) {
        return product;
      }
    }
    return null;
  }

  String _message(Object error) {
    return error.toString().replaceFirst('Exception: ', '').trim();
  }

  Future<String?> _resolveAppUserId(String? appUserId) async {
    final normalizedUserId = appUserId?.trim() ?? '';
    if (normalizedUserId.isNotEmpty) {
      return normalizedUserId;
    }

    final session = await HiveFunctions.getUserSessionData();
    final persistedUserId = session?.user?.id?.trim() ?? '';
    if (persistedUserId.isEmpty) {
      return null;
    }

    return persistedUserId;
  }
}
