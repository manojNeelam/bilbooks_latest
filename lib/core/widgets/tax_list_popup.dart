import 'package:billbooks_app/features/invoice/domain/entities/invoice_details_entity.dart';
import 'package:flutter/material.dart';

import '../app_constants.dart';
import '../theme/app_fonts.dart';
import '../theme/app_pallete.dart';
import 'app_multi_selection_popup.dart';
import 'item_separator.dart';

class TaxListPopup extends StatefulWidget {
  final List<TaxEntity> taxEnties;
  final List<TaxEntity>? defaultTaxEntities;
  final Function(List<TaxEntity>?) callBack;
  const TaxListPopup(
      {super.key,
      required this.taxEnties,
      this.defaultTaxEntities,
      required this.callBack});

  @override
  State<TaxListPopup> createState() => _TaxListPopupState();
}

class _TaxListPopupState extends State<TaxListPopup> {
  List<TaxEntity>? selectedTaxes;

  @override
  void initState() {
    selectedTaxes = widget.defaultTaxEntities;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("BuildContext");
    return AppMultiSelectionPopupWidget(
        data: widget.taxEnties,
        defaultSelectedItems: selectedTaxes,
        itemBuilder: (item, seletedItem) {
          selectedTaxes = seletedItem;
          return Container(
            padding: AppConstants.horizotal16,
            child: Column(
              children: [
                Padding(
                  padding: AppConstants.verticalPadding10,
                  child: Row(
                    children: [
                      Icon(
                        checkIsItem(item)
                            ? Icons.check_circle
                            : Icons.circle_outlined,
                        color: checkIsItem(item)
                            ? AppPallete.blueColor
                            : AppPallete.borderColor,
                      ),
                      AppConstants.sizeBoxWidth10,
                      Expanded(
                        child: Text(
                          "${item.name} (${item.rate}%)",
                          style: AppFonts.regularStyle(
                              color: AppPallete.textColor),
                        ),
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
        title: "Tax");
  }

  bool checkIsItem(TaxEntity item) {
    debugPrint("Item Name: ${selectedTaxes?.length.toString()}");
    if (selectedTaxes != null && selectedTaxes!.isNotEmpty) {
      final filteredList = selectedTaxes!.where((tax) {
        return tax.id == item.id;
      });
      return filteredList.isNotEmpty;
    }
    return false;
  }
}
