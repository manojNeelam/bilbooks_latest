import 'package:billbooks_app/features/more/settings/subscription/domain/entity/revenuecat_entity.dart';

class RevenueCatState {
  final bool isLoading;
  final bool isPurchaseInProgress;
  final bool isSupportedPlatform;
  final bool isConfigured;
  final List<RevenueCatProductEntity> products;
  final RevenueCatCustomerEntity? customer;
  final String? errorMessage;
  final String? successMessage;

  const RevenueCatState({
    this.isLoading = false,
    this.isPurchaseInProgress = false,
    this.isSupportedPlatform = false,
    this.isConfigured = false,
    this.products = const [],
    this.customer,
    this.errorMessage,
    this.successMessage,
  });

  bool get hasActiveEntitlements => customer?.hasActiveEntitlements ?? false;

  RevenueCatState copyWith({
    bool? isLoading,
    bool? isPurchaseInProgress,
    bool? isSupportedPlatform,
    bool? isConfigured,
    List<RevenueCatProductEntity>? products,
    RevenueCatCustomerEntity? customer,
    String? errorMessage,
    String? successMessage,
    bool clearFeedback = false,
  }) {
    return RevenueCatState(
      isLoading: isLoading ?? this.isLoading,
      isPurchaseInProgress: isPurchaseInProgress ?? this.isPurchaseInProgress,
      isSupportedPlatform: isSupportedPlatform ?? this.isSupportedPlatform,
      isConfigured: isConfigured ?? this.isConfigured,
      products: products ?? this.products,
      customer: customer ?? this.customer,
      errorMessage: clearFeedback ? null : (errorMessage ?? this.errorMessage),
      successMessage:
          clearFeedback ? null : (successMessage ?? this.successMessage),
    );
  }
}
