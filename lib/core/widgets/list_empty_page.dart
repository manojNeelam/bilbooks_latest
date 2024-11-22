import 'package:billbooks_app/core/app_constants.dart';
import 'package:billbooks_app/core/theme/app_fonts.dart';
import 'package:billbooks_app/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class ListEmptyPage extends StatelessWidget {
  final String buttonTitle;
  final String noDataText;
  final String noDataSubtitle;
  final IconData iconName;
  final Function() callBack;
  const ListEmptyPage(
      {super.key,
      required this.buttonTitle,
      required this.noDataText,
      required this.noDataSubtitle,
      required this.iconName,
      required this.callBack});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              size: 40,
              iconName,
              color: AppPallete.blueColor,
            ),
            AppConstants.sizeBoxHeight10,
            Text(
              noDataText,
              style: AppFonts.regularStyle(),
              textAlign: TextAlign.center,
            ),
            AppConstants.sizeBoxHeight10,
            if (noDataSubtitle.isNotEmpty)
              Text(
                noDataSubtitle,
                style:
                    AppFonts.regularStyle(size: 14, color: AppPallete.k666666),
                textAlign: TextAlign.center,
              ),
            if (noDataSubtitle.isNotEmpty) AppConstants.sizeBoxHeight10,
            ElevatedButton(
              onPressed: callBack,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppPallete.blueColor, // background
                foregroundColor: Colors.white, // foreground
              ),
              child: Text(buttonTitle),
            )
          ],
        ),
      ),
    );
  }
}
