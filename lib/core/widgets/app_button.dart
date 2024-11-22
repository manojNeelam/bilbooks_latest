import 'package:billbooks_app/core/theme/app_fonts.dart';
import 'package:billbooks_app/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final VoidCallback callback;
  final bool isEnabled;
  final String title;
  const AppButton({
    super.key,
    required this.callback,
    required this.isEnabled,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 32,
      height: 45,
      child: TextButton(
        onPressed: isEnabled ? callback : null,
        style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10), // <-- Radius
            ),
            backgroundColor:
                isEnabled ? AppPallete.blueColor : AppPallete.blueColor50,
            foregroundColor: AppPallete.white,
            textStyle: AppFonts.mediumStyle(size: 16, color: AppPallete.white)),
        child: Text(
          title,
          style: AppFonts.regularStyle(color: AppPallete.white),
        ),
      ),
    );
  }
}
