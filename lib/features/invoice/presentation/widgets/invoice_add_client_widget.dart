import 'package:billbooks_app/core/app_constants.dart';
import 'package:billbooks_app/core/theme/app_fonts.dart';
import 'package:billbooks_app/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class InvoiceAddClientWidget extends StatelessWidget {
  final Function()? onPress;

  const InvoiceAddClientWidget({super.key, this.onPress});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
      decoration: const BoxDecoration(color: AppPallete.white),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: onPress,
        child: Row(
          children: [
            const Icon(
              Icons.people,
              color: AppPallete.blueColor,
            ),
            AppConstants.sizeBoxWidth10,
            Text(
              "Select Client",
              style:
                  AppFonts.mediumStyle(color: AppPallete.blueColor, size: 16),
            ),
            const Spacer(),
            const Icon(
              Icons.chevron_right_sharp,
              color: AppPallete.borderColor,
            ),
          ],
        ),
      ),
    );
  }
}
