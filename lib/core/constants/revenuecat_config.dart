import 'package:flutter/foundation.dart';

class RevenueCatConfig {
  const RevenueCatConfig._();

  static const String iosApiKey =
      String.fromEnvironment('REVENUECAT_IOS_API_KEY', defaultValue: '');
  static const String androidApiKey =
      String.fromEnvironment('REVENUECAT_ANDROID_API_KEY', defaultValue: '');
  static const String defaultOfferingIdentifier =
      String.fromEnvironment('REVENUECAT_OFFERING_ID', defaultValue: '');
  static const String defaultEntitlementIdentifier =
      String.fromEnvironment('REVENUECAT_ENTITLEMENT_ID', defaultValue: '');
  static const String webBillingUrl = String.fromEnvironment(
    'REVENUECAT_WEB_BILLING_URL',
    defaultValue: 'https://app.billbooks.com/subscriptions',
  );

  static bool get supportsNativePurchases {
    if (kIsWeb) {
      return false;
    }
    return defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.android;
  }

  static String get currentApiKey {
    if (kIsWeb) {
      return '';
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
        return iosApiKey;
      case TargetPlatform.android:
        return androidApiKey;
      default:
        return '';
    }
  }

  static bool get hasCurrentPlatformApiKey => currentApiKey.trim().isNotEmpty;
}
