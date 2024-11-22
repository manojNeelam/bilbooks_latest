import 'package:auto_route/auto_route.dart';
import 'package:billbooks_app/core/app_constants.dart';
import 'package:billbooks_app/core/theme/app_fonts.dart';
import 'package:flutter/material.dart';

@RoutePage()
class TermsConditionPage extends StatelessWidget {
  const TermsConditionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Terms & Condition"),
        bottom: AppConstants.getAppBarDivider,
      ),
      body: Center(
        child: Text(
          "Terms and Condition comes here",
          style: AppFonts.regularStyle(),
        ),
      ),
    );
  }
}
