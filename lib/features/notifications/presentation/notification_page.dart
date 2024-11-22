import 'package:auto_route/auto_route.dart';
import 'package:billbooks_app/core/app_constants.dart';
import 'package:billbooks_app/core/theme/app_fonts.dart';
import 'package:billbooks_app/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

@RoutePage()
class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
        bottom: AppConstants.getAppBarDivider,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.notifications_off_rounded,
              color: AppPallete.borderColor,
              size: 30,
            ),
            AppConstants.sizeBoxHeight10,
            Text(
              "No Records",
              style: AppFonts.regularStyle(),
            ),
          ],
        ),
      ),
    );
  }
}
