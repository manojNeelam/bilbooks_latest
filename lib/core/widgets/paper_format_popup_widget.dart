import 'package:billbooks_app/features/more/settings/domain/entity/paper_format_entity.dart';
import 'package:flutter/material.dart';

import '../app_constants.dart';
import '../theme/app_fonts.dart';
import '../theme/app_pallete.dart';
import 'app_single_selection_popup.dart';
import 'item_separator.dart';

class PaperFormatPopupWidget extends StatefulWidget {
  final List<PaperFormatEntity> paperFormatters;
  final PaperFormatEntity? defaultPaperFormat;
  final Function(PaperFormatEntity?) callBack;

  const PaperFormatPopupWidget({
    super.key,
    required this.paperFormatters,
    this.defaultPaperFormat,
    required this.callBack,
  });

  @override
  State<PaperFormatPopupWidget> createState() => _PaperFormatPopupWidgetState();
}

class _PaperFormatPopupWidgetState extends State<PaperFormatPopupWidget> {
  PaperFormatEntity? selectedPaperFormatter;

  @override
  void initState() {
    selectedPaperFormatter = widget.defaultPaperFormat;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppSingleSelectionPopupWidget(
        data: widget.paperFormatters,
        defaultSelectedItem: selectedPaperFormatter,
        itemBuilder: (item, seletedItem) {
          selectedPaperFormatter = seletedItem;
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
                              color:
                                  item.format == selectedPaperFormatter?.format
                                      ? AppPallete.blueColor
                                      : AppPallete.textColor),
                        ),
                      ),
                      AppConstants.sizeBoxWidth10,
                      if (item.format == selectedPaperFormatter?.format)
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
        title: "Paper Formatter");
  }
}
