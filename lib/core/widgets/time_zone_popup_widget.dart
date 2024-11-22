import 'package:billbooks_app/features/invoice/domain/entities/time_zone_model.dart';
import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape.dart';

import '../app_constants.dart';
import '../theme/app_fonts.dart';
import '../theme/app_pallete.dart';
import 'app_single_selection_popup.dart';
import 'item_separator.dart';

class TimeZonePopupWidget extends StatefulWidget {
  final List<Timezone> timeZones;
  final Timezone? defaultTimeZone;
  final Function(Timezone?) callBack;
  const TimeZonePopupWidget(
      {super.key,
      required this.timeZones,
      this.defaultTimeZone,
      required this.callBack});

  @override
  State<TimeZonePopupWidget> createState() => _TimeZonePopupWidgetState();
}

class _TimeZonePopupWidgetState extends State<TimeZonePopupWidget> {
  Timezone? selectedTimeZone;
  var unescape = HtmlUnescape();

  @override
  void initState() {
    selectedTimeZone = widget.defaultTimeZone;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppSingleSelectionPopupWidget(
        data: widget.timeZones,
        defaultSelectedItem: selectedTimeZone,
        itemBuilder: (item, seletedItem) {
          selectedTimeZone = seletedItem;
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
                          unescape.convert(
                              "(${item.gmt ?? ""}) ${item.name ?? ""}"),
                          style: AppFonts.regularStyle(
                              color: item.timezoneId ==
                                      selectedTimeZone?.timezoneId
                                  ? AppPallete.blueColor
                                  : AppPallete.textColor),
                        ),
                      ),
                      AppConstants.sizeBoxWidth10,
                      if (item.timezoneId == selectedTimeZone?.timezoneId)
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
        title: "Timezone");
  }
}
