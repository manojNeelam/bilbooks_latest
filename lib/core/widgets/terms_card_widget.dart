import 'package:billbooks_app/core/app_constants.dart';
import 'package:billbooks_app/core/theme/app_fonts.dart';
import 'package:billbooks_app/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class TermsCardWidget extends StatelessWidget {
  final Function()? onPress;
  const TermsCardWidget({super.key, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        color: AppPallete.white,
        padding: AppConstants.horizontalVerticalPadding,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Terms & Conditions",
              style: AppFonts.regularStyle(),
            ),
            const Icon(
              Icons.chevron_right,
              color: AppPallete.borderColor,
            )
          ],
        ),
      ),
    );
  }
}
