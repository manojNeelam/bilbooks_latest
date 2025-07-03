import 'package:billbooks_app/features/creditnotes/presentation/model/credit_note_expiry_model.dart';
import 'package:flutter/material.dart';

import '../app_constants.dart';
import '../theme/app_fonts.dart';
import '../theme/app_pallete.dart';
import 'app_single_selection_popup.dart';
import 'item_separator.dart';

class CreditNoteExpiryPopupWidget extends StatefulWidget {
  final List<CreditNoteExpiryModel> expiryRanges;
  final CreditNoteExpiryModel? defaultExpiry;
  final Function(CreditNoteExpiryModel?) callBack;
  const CreditNoteExpiryPopupWidget(
      {super.key,
      required this.expiryRanges,
      this.defaultExpiry,
      required this.callBack});

  @override
  State<CreditNoteExpiryPopupWidget> createState() =>
      _CreditNoteExpiryPopupWidgetState();
}

class _CreditNoteExpiryPopupWidgetState
    extends State<CreditNoteExpiryPopupWidget> {
  CreditNoteExpiryModel? selectedExpiry;

  @override
  void initState() {
    selectedExpiry = widget.defaultExpiry;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppSingleSelectionPopupWidget(
        data: widget.expiryRanges,
        defaultSelectedItem: selectedExpiry,
        itemBuilder: (item, seletedItem) {
          selectedExpiry = seletedItem;
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
                              color: item.value == selectedExpiry?.value
                                  ? AppPallete.blueColor
                                  : AppPallete.textColor),
                        ),
                      ),
                      AppConstants.sizeBoxWidth10,
                      if (item.value == selectedExpiry?.value)
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
        title: "Select Expiry Range");
  }
}
