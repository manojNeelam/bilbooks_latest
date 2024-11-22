import 'package:billbooks_app/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

import '../theme/app_fonts.dart';

class CapsuleStatusWidget extends StatelessWidget {
  final String title;
  final Color backgroundColor;
  final Color textColor;
  final bool hasborder;
  const CapsuleStatusWidget(
      {super.key,
      required this.title,
      required this.backgroundColor,
      required this.textColor,
      this.hasborder = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          color: backgroundColor,
          shape: BoxShape.rectangle,
          border: hasborder
              ? Border.all(color: AppPallete.itemDividerColor)
              : Border.all(color: AppPallete.clear)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
        child: Text(
          title,
          style: AppFonts.regularStyle(color: textColor, size: 12),
          maxLines: 1,
        ),
      ),
    );
  }
}
