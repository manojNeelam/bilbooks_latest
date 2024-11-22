import 'package:billbooks_app/core/models/country_model.dart';
import 'package:flutter/material.dart';
import '../app_constants.dart';
import '../theme/app_fonts.dart';
import '../theme/app_pallete.dart';
import 'app_single_selection_popup.dart';
import 'item_separator.dart';

class CountryListPopupWidget extends StatefulWidget {
  final List<CountryModel> countries;
  final CountryModel? defaultCountry;
  final Function(CountryModel?) callBack;
  const CountryListPopupWidget(
      {super.key,
      required this.countries,
      this.defaultCountry,
      required this.callBack});

  @override
  State<CountryListPopupWidget> createState() => _CountryListPopupWidgetState();
}

class _CountryListPopupWidgetState extends State<CountryListPopupWidget> {
  CountryModel? selectedCountry;

  @override
  void initState() {
    selectedCountry = widget.defaultCountry;
    debugPrint(selectedCountry?.name ?? "---");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("BuildContext");
    return AppSingleSelectionPopupWidget(
        data: widget.countries,
        defaultSelectedItem: selectedCountry,
        itemBuilder: (item, seletedItem) {
          debugPrint(seletedItem?.name);
          selectedCountry = seletedItem;
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
                              color:
                                  item.countryId == selectedCountry?.countryId
                                      ? AppPallete.blueColor
                                      : AppPallete.textColor),
                        ),
                      ),
                      AppConstants.sizeBoxWidth10,
                      if (item.countryId == selectedCountry?.countryId)
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
        title: "Country");
  }
}
