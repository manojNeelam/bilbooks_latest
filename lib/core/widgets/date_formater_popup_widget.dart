import 'package:billbooks_app/features/more/settings/domain/entity/date_formater.dart';
import 'package:flutter/material.dart';

import '../app_constants.dart';
import '../theme/app_fonts.dart';
import '../theme/app_pallete.dart';
import 'app_single_selection_popup.dart';
import 'item_separator.dart';

class DateFormaterPopupWidget extends StatefulWidget {
  final List<DateFormatEntity> dateFormaterList;
  final DateFormatEntity? defaultDateFormater;
  final Function(DateFormatEntity?) callBack;
  const DateFormaterPopupWidget(
      {super.key,
      required this.dateFormaterList,
      required this.callBack,
      this.defaultDateFormater});

  @override
  State<DateFormaterPopupWidget> createState() =>
      _DateFormaterPopupWidgetState();
}

class _DateFormaterPopupWidgetState extends State<DateFormaterPopupWidget> {
  DateFormatEntity? selectedDateFormater;

  @override
  void initState() {
    selectedDateFormater = widget.defaultDateFormater;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppSingleSelectionPopupWidget(
        data: widget.dateFormaterList,
        defaultSelectedItem: selectedDateFormater,
        itemBuilder: (item, seletedItem) {
          selectedDateFormater = seletedItem;
          return Container(
            padding: AppConstants.horizotal16,
            child: Column(
              children: [
                Padding(
                  padding: AppConstants.verticalPadding10,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          item.format ?? "",
                          style: AppFonts.regularStyle(
                              color: item.format == selectedDateFormater?.format
                                  ? AppPallete.blueColor
                                  : AppPallete.textColor),
                        ),
                      ),
                      AppConstants.sizeBoxWidth10,
                      if (item.format == selectedDateFormater?.format)
                        const Icon(
                          Icons.check,
                          color: AppPallete.blueColor,
                        )
                    ],
                  ),
                ),
                const ItemSeparator()
              ],
            ),
          );
        },
        selectedOk: (currency) {
          widget.callBack(currency);
        },
        title: "Date Formatter");
  }
}
