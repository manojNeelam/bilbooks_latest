import 'package:flutter/material.dart';
import '../../../../../core/app_constants.dart';
import '../../../../../core/theme/app_fonts.dart';
import '../../../../../core/theme/app_pallete.dart';
import '../../../../../core/widgets/item_separator.dart';
import 'expenses_list_page.dart';

class ExpensesTypeHeaderWidget extends StatelessWidget {
  final EnumExpensesType selectedType;
  final Function(EnumExpensesType) callBack;
  const ExpensesTypeHeaderWidget(
      {super.key, required this.selectedType, required this.callBack});

  @override
  Widget build(BuildContext context) {
    const EnumExpensesType all = EnumExpensesType.all;
    const EnumExpensesType unbilled = EnumExpensesType.unbilled;
    const EnumExpensesType recurring = EnumExpensesType.recurring;

    Color getColorFor(EnumExpensesType type) {
      return type == selectedType ? AppPallete.blueColor : AppPallete.clear;
    }

    TextStyle getStyleFor(EnumExpensesType type) {
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
                        callBack(unbilled);
                      },
                      child: Text(unbilled.title, style: getStyleFor(unbilled)),
                    ),
                    Container(
                      height: 2,
                      color: getColorFor(unbilled),
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
                          callBack(recurring);
                        },
                        child: Text(recurring.title,
                            style: getStyleFor(recurring))),
                    Container(
                      height: 2,
                      color: getColorFor(recurring),
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
