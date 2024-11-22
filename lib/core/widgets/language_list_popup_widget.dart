import 'package:billbooks_app/core/models/language_model.dart';
import 'package:flutter/material.dart';

import '../app_constants.dart';
import '../theme/app_fonts.dart';
import '../theme/app_pallete.dart';
import 'app_single_selection_popup.dart';
import 'item_separator.dart';

class LanguageListPopupWidget extends StatefulWidget {
  final List<LanguageModel> languages;
  final LanguageModel? defaultLanguage;
  final Function(LanguageModel?) callBack;
  const LanguageListPopupWidget(
      {super.key,
      required this.languages,
      this.defaultLanguage,
      required this.callBack});

  @override
  State<LanguageListPopupWidget> createState() =>
      _LanguageListPopupWidgetState();
}

class _LanguageListPopupWidgetState extends State<LanguageListPopupWidget> {
  LanguageModel? selectedLanguage;

  @override
  void initState() {
    selectedLanguage = widget.defaultLanguage;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("BuildContext");
    return AppSingleSelectionPopupWidget(
        data: widget.languages,
        defaultSelectedItem: selectedLanguage,
        itemBuilder: (item, seletedItem) {
          selectedLanguage = seletedItem;
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
                              color: item.languageId ==
                                      selectedLanguage?.languageId
                                  ? AppPallete.blueColor
                                  : AppPallete.textColor),
                        ),
                      ),
                      AppConstants.sizeBoxWidth10,
                      if (item.languageId == selectedLanguage?.languageId)
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
        selectedOk: (language) {
          widget.callBack(language);
        },
        title: "Languages");
  }
}
