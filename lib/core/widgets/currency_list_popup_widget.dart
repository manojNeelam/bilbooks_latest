import 'package:billbooks_app/core/widgets/app_single_selection_popup.dart';
import 'package:billbooks_app/core/widgets/item_separator.dart';
import 'package:billbooks_app/features/clients/presentation/Models/client_currencies.dart';
import 'package:flutter/material.dart';

import '../app_constants.dart';
import '../theme/app_fonts.dart';
import '../theme/app_pallete.dart';

class CurrencyListPopupWidget extends StatefulWidget {
  final List<CurrencyModel> currencies;
  final CurrencyModel? defaultCurrency;
  final Function(CurrencyModel?) callBack;
  const CurrencyListPopupWidget(
      {super.key,
      required this.currencies,
      this.defaultCurrency,
      required this.callBack});

  @override
  State<CurrencyListPopupWidget> createState() =>
      _CurrencyListPopupWidgetState();
}

class _CurrencyListPopupWidgetState extends State<CurrencyListPopupWidget> {
  CurrencyModel? selectedCurrency;

  @override
  void initState() {
    selectedCurrency = widget.defaultCurrency;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppSingleSelectionPopupWidget(
        data: widget.currencies,
        defaultSelectedItem: selectedCurrency,
        itemBuilder: (item, seletedItem) {
          selectedCurrency = seletedItem;
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
                          "${item.code} - ${item.name}",
                          style: AppFonts.regularStyle(
                              color: item.currencyId ==
                                      selectedCurrency?.currencyId
                                  ? AppPallete.blueColor
                                  : AppPallete.textColor),
                        ),
                      ),
                      AppConstants.sizeBoxWidth10,
                      if (item.currencyId == selectedCurrency?.currencyId)
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
        title: "Currency");
  }
}
