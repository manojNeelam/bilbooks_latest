import 'package:flutter/material.dart';

import '../../../../core/app_constants.dart';
import '../../../../core/theme/app_fonts.dart';
import '../../../../core/theme/app_pallete.dart';
import '../../../../core/widgets/item_separator.dart';

enum EnumFollowUpEstimateType { email1, email2, email3 }

extension EnumFollowUpEstimateTypeExtensions on EnumFollowUpEstimateType {
  String get title {
    switch (this) {
      case EnumFollowUpEstimateType.email1:
        return "Email 1";
      case EnumFollowUpEstimateType.email2:
        return "Email 2";
      case EnumFollowUpEstimateType.email3:
        return "Email 3";
    }
  }

  String get apiParams {
    switch (this) {
      case EnumFollowUpEstimateType.email1:
        return "followupestimate_1";
      case EnumFollowUpEstimateType.email2:
        return "followupestimate_2";
      case EnumFollowUpEstimateType.email3:
        return "followupestimate_3";
    }
  }
}

class FollowUpHeaderWidget extends StatelessWidget {
  final EnumFollowUpEstimateType selectedType;
  final Function(EnumFollowUpEstimateType) callBack;
  const FollowUpHeaderWidget(
      {super.key, required this.selectedType, required this.callBack});

  @override
  Widget build(BuildContext context) {
    const EnumFollowUpEstimateType email1 = EnumFollowUpEstimateType.email1;
    const EnumFollowUpEstimateType email2 = EnumFollowUpEstimateType.email2;
    const EnumFollowUpEstimateType email3 = EnumFollowUpEstimateType.email3;

    Color getColorFor(EnumFollowUpEstimateType type) {
      return type == selectedType ? AppPallete.blueColor : AppPallete.clear;
    }

    TextStyle getStyleFor(EnumFollowUpEstimateType type) {
      return type == selectedType
          ? AppFonts.mediumStyle(color: AppPallete.blueColor, size: 16)
          : AppFonts.regularStyle(color: AppPallete.textColor, size: 16);
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    TextButton(
                        onPressed: () {
                          callBack(email1);
                        },
                        child: Text(
                          email1.title,
                          style: getStyleFor(email1),
                        )),
                    Container(
                      height: 2,
                      color: getColorFor(email1),
                    )
                  ],
                ),
              ),
              AppConstants.sizeBoxWidth5,
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    TextButton(
                      onPressed: () {
                        callBack(email2);
                      },
                      child: Text(email2.title, style: getStyleFor(email2)),
                    ),
                    Container(
                      height: 2,
                      color: getColorFor(email2),
                    )
                  ],
                ),
              ),
              AppConstants.sizeBoxWidth5,
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    TextButton(
                        onPressed: () {
                          callBack(email3);
                        },
                        child: Text(email3.title, style: getStyleFor(email3))),
                    Container(
                      height: 2,
                      color: getColorFor(email3),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        const ItemSeparator()
      ],
    );
  }
}
