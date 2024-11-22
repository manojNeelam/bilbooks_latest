import 'package:flutter/material.dart';

import '../app_constants.dart';
import '../theme/app_fonts.dart';
import '../theme/app_pallete.dart';

class TitleSubtitleHeaderWidget extends StatelessWidget {
  final String leadingTitle;
  final String trailingTitle;

  const TitleSubtitleHeaderWidget(
      {super.key, required this.leadingTitle, required this.trailingTitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppPallete.kF2F2F2,
      padding: AppConstants.horizontalVerticalPadding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            leadingTitle,
            style: AppFonts.regularStyle(),
          ),
          Text(
            trailingTitle,
            style: AppFonts.regularStyle(),
          )
        ],
      ),
    );
  }
}
