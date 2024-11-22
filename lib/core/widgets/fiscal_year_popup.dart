import 'package:billbooks_app/features/more/settings/domain/entity/fiscal_year_entity.dart';
import 'package:flutter/material.dart';

import '../app_constants.dart';
import '../theme/app_fonts.dart';
import '../theme/app_pallete.dart';
import 'app_single_selection_popup.dart';
import 'item_separator.dart';

class FiscalYearPopupWidget extends StatefulWidget {
  final List<FiscalYearEntity> fiscalYearList;
  final FiscalYearEntity? defaultFiscalYear;
  final Function(FiscalYearEntity?) callBack;
  const FiscalYearPopupWidget(
      {super.key,
      required this.fiscalYearList,
      this.defaultFiscalYear,
      required this.callBack});

  @override
  State<FiscalYearPopupWidget> createState() => _FiscalYearPopupWidgetState();
}

class _FiscalYearPopupWidgetState extends State<FiscalYearPopupWidget> {
  FiscalYearEntity? selectedFiscalYear;

  @override
  void initState() {
    selectedFiscalYear = widget.defaultFiscalYear;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppSingleSelectionPopupWidget(
        data: widget.fiscalYearList,
        defaultSelectedItem: selectedFiscalYear,
        itemBuilder: (item, seletedItem) {
          selectedFiscalYear = seletedItem;
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
                          item.fromTo ?? "",
                          style: AppFonts.regularStyle(
                              color: item.id == selectedFiscalYear?.id
                                  ? AppPallete.blueColor
                                  : AppPallete.textColor),
                        ),
                      ),
                      AppConstants.sizeBoxWidth10,
                      if (item.id == selectedFiscalYear?.id)
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
        title: "Fiscal Year");
  }
}
