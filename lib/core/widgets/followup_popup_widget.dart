import 'package:flutter/material.dart';

import '../app_constants.dart';
import '../theme/app_fonts.dart';
import '../theme/app_pallete.dart';
import 'app_single_selection_popup.dart';
import 'item_separator.dart';

class FollowupPopupWidget extends StatefulWidget {
  final List<FollowUpModel> followUpList;
  final FollowUpModel? defaultFollowUp;
  final Function(FollowUpModel?) callBack;

  const FollowupPopupWidget(
      {super.key,
      required this.followUpList,
      this.defaultFollowUp,
      required this.callBack});

  @override
  State<FollowupPopupWidget> createState() => _FollowupPopupWidgetState();
}

class _FollowupPopupWidgetState extends State<FollowupPopupWidget> {
  FollowUpModel? selectedFollowUp;

  @override
  void initState() {
    selectedFollowUp = widget.defaultFollowUp;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppSingleSelectionPopupWidget(
        data: widget.followUpList,
        defaultSelectedItem: selectedFollowUp,
        itemBuilder: (item, seletedItem) {
          selectedFollowUp = seletedItem;
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
                          item.label,
                          style: AppFonts.regularStyle(
                              color: item.value == selectedFollowUp?.value
                                  ? AppPallete.blueColor
                                  : AppPallete.textColor),
                        ),
                      ),
                      AppConstants.sizeBoxWidth10,
                      if (item.value == selectedFollowUp?.value)
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
        title: "Select Follow Up");
  }
}

class FollowUpModel {
  final String label;
  final String value;

  FollowUpModel({required this.label, required this.value});
}
