import 'package:billbooks_app/features/invoice/domain/entities/repeat_every_model.dart';
import 'package:flutter/material.dart';

import '../app_constants.dart';
import '../theme/app_fonts.dart';
import '../theme/app_pallete.dart';
import 'app_single_selection_popup.dart';
import 'item_separator.dart';

class RepeatEveryPopupWidget extends StatefulWidget {
  final List<RepeatEvery> repeatEvery;
  final RepeatEvery? defaultRepeatEvery;
  final Function(RepeatEvery?) callBack;
  const RepeatEveryPopupWidget(
      {super.key,
      required this.repeatEvery,
      this.defaultRepeatEvery,
      required this.callBack});

  @override
  State<RepeatEveryPopupWidget> createState() => _RepeatEveryPopupWidgetState();
}

class _RepeatEveryPopupWidgetState extends State<RepeatEveryPopupWidget> {
  RepeatEvery? selectedRepeatEvery;

  @override
  void initState() {
    selectedRepeatEvery = widget.defaultRepeatEvery;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("BuildContext");
    return AppSingleSelectionPopupWidget(
        data: widget.repeatEvery,
        defaultSelectedItem: selectedRepeatEvery,
        itemBuilder: (item, seletedItem) {
          selectedRepeatEvery = seletedItem;
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
                          item.label ?? "",
                          style: AppFonts.regularStyle(
                              color: item.value == selectedRepeatEvery?.value
                                  ? AppPallete.blueColor
                                  : AppPallete.textColor),
                        ),
                      ),
                      AppConstants.sizeBoxWidth10,
                      if (item.value == selectedRepeatEvery?.value)
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
        selectedOk: (country) {
          widget.callBack(country);
        },
        title: "Repeat Every");
  }
}
