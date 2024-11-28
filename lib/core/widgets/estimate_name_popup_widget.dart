import 'package:billbooks_app/features/more/settings/domain/entity/estimate_name_entity.dart';
import 'package:flutter/material.dart';

import '../app_constants.dart';
import '../theme/app_fonts.dart';
import '../theme/app_pallete.dart';
import 'app_single_selection_popup.dart';
import 'item_separator.dart';

class EstimateNamePopupWidget extends StatefulWidget {
  final List<EstimateName> estimateNameList;
  final EstimateName? defaultEstimateName;
  final Function(EstimateName?) callBack;
  const EstimateNamePopupWidget(
      {super.key,
      required this.estimateNameList,
      required this.callBack,
      this.defaultEstimateName});

  @override
  State<EstimateNamePopupWidget> createState() =>
      _EstimateNamePopupWidgetState();
}

class _EstimateNamePopupWidgetState extends State<EstimateNamePopupWidget> {
  EstimateName? selectedEstimateName;

  @override
  void initState() {
    selectedEstimateName = widget.defaultEstimateName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppSingleSelectionPopupWidget(
        data: widget.estimateNameList,
        defaultSelectedItem: selectedEstimateName,
        itemBuilder: (item, seletedItem) {
          selectedEstimateName = seletedItem;
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
                          item.name ?? "",
                          style: AppFonts.regularStyle(
                              color: item.name == selectedEstimateName?.name
                                  ? AppPallete.blueColor
                                  : AppPallete.textColor),
                        ),
                      ),
                      AppConstants.sizeBoxWidth10,
                      if (item.name == selectedEstimateName?.name)
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
        title: "Estimate Name");
  }
}
