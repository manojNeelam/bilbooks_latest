import 'package:billbooks_app/features/estimate/presentation/estimate_list_page.dart';
import 'package:flutter/material.dart';

import '../../../../core/app_constants.dart';
import '../../../../core/theme/app_fonts.dart';
import '../../../../core/theme/app_pallete.dart';
import '../../../../core/widgets/item_separator.dart';

class EstimateTypeHeaderWidget extends StatelessWidget {
  final EnumEstimateType selectedType;
  final Function(EnumEstimateType) callBack;
  const EstimateTypeHeaderWidget(
      {super.key, required this.selectedType, required this.callBack});

  @override
  Widget build(BuildContext context) {
    const EnumEstimateType all = EnumEstimateType.all;
    const EnumEstimateType draft = EnumEstimateType.draft;
    const EnumEstimateType sent = EnumEstimateType.sent;
    const EnumEstimateType approved = EnumEstimateType.approved;

    Color getColorFor(EnumEstimateType type) {
      return type == selectedType ? AppPallete.blueColor : AppPallete.clear;
    }

    TextStyle getStyleFor(EnumEstimateType type) {
      return type == selectedType
          ? AppFonts.regularStyle(color: AppPallete.blueColor, size: 15)
          : AppFonts.regularStyle(color: AppPallete.textColor, size: 15);
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
                          callBack(all);
                        },
                        child: Text(
                          all.title,
                          style: getStyleFor(all),
                        )),
                    Container(
                      height: 2,
                      color: getColorFor(all),
                    )
                  ],
                ),
              ),
              AppConstants.sizeBoxWidth5,
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    TextButton(
                      onPressed: () {
                        callBack(draft);
                      },
                      child: Text(draft.title, style: getStyleFor(draft)),
                    ),
                    Container(
                      height: 2,
                      color: getColorFor(draft),
                    )
                  ],
                ),
              ),
              AppConstants.sizeBoxWidth5,
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    TextButton(
                        onPressed: () {
                          callBack(sent);
                        },
                        child: Text(sent.title, style: getStyleFor(sent))),
                    Container(
                      height: 2,
                      color: getColorFor(sent),
                    )
                  ],
                ),
              ),
              AppConstants.sizeBoxWidth5,
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    TextButton(
                        onPressed: () {
                          callBack(approved);
                        },
                        child: Text(
                          approved.title,
                          style: getStyleFor(approved),
                        )),
                    Container(
                      height: 2,
                      color: getColorFor(approved),
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
