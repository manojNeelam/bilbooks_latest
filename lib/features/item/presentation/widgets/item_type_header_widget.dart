import 'package:billbooks_app/features/item/presentation/item_list.dart';
import 'package:flutter/material.dart';

import '../../../../core/app_constants.dart';
import '../../../../core/theme/app_fonts.dart';
import '../../../../core/theme/app_pallete.dart';
import '../../../../core/widgets/item_separator.dart';

class ItemTypeHeaderWidget extends StatelessWidget {
  final EnumItemType selectedType;
  final Function(EnumItemType) callBack;
  const ItemTypeHeaderWidget(
      {super.key, required this.selectedType, required this.callBack});

  @override
  Widget build(BuildContext context) {
    const EnumItemType all = EnumItemType.all;
    const EnumItemType services = EnumItemType.services;
    const EnumItemType goods = EnumItemType.goods;

    Color getColorFor(EnumItemType type) {
      return type == selectedType ? AppPallete.blueColor : AppPallete.clear;
    }

    TextStyle getStyleFor(EnumItemType type) {
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
                flex: 1,
                child: Column(
                  children: [
                    TextButton(
                      onPressed: () {
                        callBack(services);
                      },
                      child: Text(services.title, style: getStyleFor(services)),
                    ),
                    Container(
                      height: 2,
                      color: getColorFor(services),
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
                          callBack(goods);
                        },
                        child: Text(goods.title, style: getStyleFor(goods))),
                    Container(
                      height: 2,
                      color: getColorFor(goods),
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
