import 'package:flutter/material.dart';

import '../../../../core/app_constants.dart';
import '../../../../core/theme/app_fonts.dart';
import '../../../../core/theme/app_pallete.dart';
import '../../../../core/widgets/item_separator.dart';
import 'preferences_page.dart';

class PreferencesTypeHeaderWidget extends StatelessWidget {
  final EnumPreferencesType selectedType;
  final Function(EnumPreferencesType) callBack;
  const PreferencesTypeHeaderWidget(
      {super.key, required this.selectedType, required this.callBack});

  @override
  Widget build(BuildContext context) {
    const EnumPreferencesType general = EnumPreferencesType.general;
    const EnumPreferencesType invioce = EnumPreferencesType.invoice;
    const EnumPreferencesType estimate = EnumPreferencesType.estimate;

    Color getColorFor(EnumPreferencesType type) {
      return type == selectedType ? AppPallete.blueColor : AppPallete.clear;
    }

    TextStyle getStyleFor(EnumPreferencesType type) {
      return type == selectedType
          ? AppFonts.regularStyle(color: AppPallete.blueColor, size: 16)
          : AppFonts.regularStyle(color: AppPallete.textColor, size: 16);
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: Column(
                  children: [
                    TextButton(
                        onPressed: () {
                          callBack(general);
                        },
                        child: Text(
                          general.title,
                          style: getStyleFor(general),
                        )),
                    Container(
                      height: 2,
                      color: getColorFor(general),
                    )
                  ],
                ),
              ),
              AppConstants.sizeBoxWidth5,
              Expanded(
                child: Column(
                  children: [
                    TextButton(
                      onPressed: () {
                        callBack(invioce);
                      },
                      child: Text(invioce.title, style: getStyleFor(invioce)),
                    ),
                    Container(
                      height: 2,
                      color: getColorFor(invioce),
                    )
                  ],
                ),
              ),
              AppConstants.sizeBoxWidth5,
              Expanded(
                child: Column(
                  children: [
                    TextButton(
                        onPressed: () {
                          callBack(estimate);
                        },
                        child:
                            Text(estimate.title, style: getStyleFor(estimate))),
                    Container(
                      height: 2,
                      color: getColorFor(estimate),
                    )
                  ],
                ),
              ),
              AppConstants.sizeBoxWidth5,
            ],
          ),
        ),
        const ItemSeparator()
      ],
    );
  }
}
