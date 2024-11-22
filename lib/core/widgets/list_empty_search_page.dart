import 'package:billbooks_app/core/app_constants.dart';
import 'package:billbooks_app/core/theme/app_fonts.dart';
import 'package:billbooks_app/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class ListEmptySearchPage extends StatelessWidget {
  final String buttonTitle;
  final String noDataText;
  final String searchText;
  final IconData iconName;
  final Function() callBack;
  const ListEmptySearchPage(
      {super.key,
      this.buttonTitle = "Refresh",
      this.noDataText = "No results for keyword",
      required this.searchText,
      this.iconName = Icons.shopping_bag_outlined,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  noDataText,
                  style: AppFonts.regularStyle(
                      size: 14, color: AppPallete.k666666),
                ),
                AppConstants.sizeBoxWidth5,
                Text(
                  searchText,
                  style: AppFonts.mediumStyle(size: 16),
                ),
              ],
            ),
            AppConstants.sizeBoxHeight10,
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
