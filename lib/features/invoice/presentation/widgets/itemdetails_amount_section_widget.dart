import 'package:flutter/material.dart';

import '../../../../core/theme/app_fonts.dart';
import '../../../../core/theme/app_pallete.dart';

class ItemDetailsAmountSectionWidget extends StatelessWidget {
  const ItemDetailsAmountSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: AppPallete.kF2F2F2),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Item Details".toUpperCase(),
              style:
                  AppFonts.regularStyle(size: 14, color: AppPallete.textColor),
            ),
            Text(
              "AMOUNT".toUpperCase(),
              style:
                  AppFonts.regularStyle(size: 14, color: AppPallete.textColor),
            )
          ],
        ),
      ),
    );
  }
}
