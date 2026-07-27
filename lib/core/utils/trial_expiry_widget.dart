// trial_service.dart
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../features/dashboard/presentation/widgets/trial_expired_popup.dart';
import 'utils.dart';

class TrialService {
  static Future<void> checkTrialStatus({
    required BuildContext context,
    required bool mounted,
  }) async {
    final navigator = Navigator.of(context);
    final router = AutoRouter.of(context);

    // Simulate API call
    await Future.delayed(const Duration(microseconds: 0));

    if (!mounted) return; // Widget disposed, skip

    // Schedule dialog on next frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!navigator.mounted) return;

      showDialog(
        context: navigator.context,
        builder: (BuildContext dialogContext) {
          return TrialExpiredPopup(
            onOpenUrl: (url) {
              if (router.canPop()) router.canPop();
              Utils.openLink(url);
            },
          );
        },
      );
    });
  }
}
