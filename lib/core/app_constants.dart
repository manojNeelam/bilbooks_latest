import 'package:billbooks_app/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'widgets/item_separator.dart';

class AppConstants {
  static const horizotal16 = EdgeInsets.symmetric(horizontal: 16);

  static const horizontalVerticalPadding =
      EdgeInsets.symmetric(vertical: 15, horizontal: 16);

  static const horizonta16lVerticalPadding10 =
      EdgeInsets.symmetric(vertical: 10, horizontal: 16);

  static const EdgeInsetsGeometry contentViewPadding =
      EdgeInsets.symmetric(horizontal: 0, vertical: 15);

  static const verticalPadding13 = EdgeInsets.symmetric(vertical: 13);
  static const verticalPadding10 = EdgeInsets.symmetric(vertical: 10);
  static const verticalPadding5 = EdgeInsets.symmetric(vertical: 10);

  static const verticalPadding = EdgeInsets.symmetric(vertical: 15);
  static const sepSizeBox5 = SizedBox(
    height: 5,
  );

  static const sizeBoxHeight10 = SizedBox(
    height: 10,
  );

  static const sizeBoxWidth10 = SizedBox(
    width: 10,
  );

  static const sizeBoxWidth15 = SizedBox(
    width: 15,
  );

  static const sizeBoxWidth5 = SizedBox(
    width: 5,
  );

  static const sizeBoxHeight15 = SizedBox(
    height: 15,
  );

  static const dashBoardItemSadow = [
    BoxShadow(
      color: AppPallete.shadowColor,
      spreadRadius: 1,
      blurRadius: 1,
      offset: Offset(0, 1),
    ),
  ];

  static const getAppBarDivider = PreferredSize(
    preferredSize: Size.fromHeight(1),
    child: ItemSeparator(),
  );
}

extension AppDateString on DateTime {
  String getDateString({String format = "dd MMM yyyy"}) {
    debugPrint("Date :$this");
    final dateFormat = DateFormat(format);
    String formatted = dateFormat.format(this);
    return formatted;
  }
}
