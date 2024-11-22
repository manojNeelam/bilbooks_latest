import 'package:billbooks_app/core/app_constants.dart';
import 'package:billbooks_app/core/theme/app_fonts.dart';
import 'package:billbooks_app/core/theme/app_pallete.dart';
import 'package:billbooks_app/core/widgets/cap_status_widget.dart';
import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum EnumAllTimes {
  all,
  thisMonth,
  lastMonth,
  thisQuater,
  lastQuater,
  thisYear,
  lastYear
}

extension EnumAllTimesExtension on EnumAllTimes {
  String getQuater(
      {required int firstMonthIndex,
      required int lastMonthIndex,
      required int currentYear,
      required List<String> months,
      required int lastYear}) {
    var firstMonthName = "";
    var lastMonthName = "";
    var firstYear = currentYear;
    var secondYear = currentYear;

    debugPrint("$firstMonthIndex");
    debugPrint("$lastMonthIndex");

    if (firstMonthIndex < 0) {
      final positiveVal = 12 + firstMonthIndex;
      debugPrint("$positiveVal");
      firstMonthName = months[positiveVal];
      firstYear = lastYear;
    } else {
      firstMonthName = months[firstMonthIndex];
      firstYear = currentYear;
    }

    if (lastMonthIndex < 0) {
      final positiveVal = 12 + lastMonthIndex;
      debugPrint("$positiveVal");
      lastMonthName = months[positiveVal];
      secondYear = lastYear;
    } else {
      lastMonthName = months[lastMonthIndex];
      secondYear = currentYear;
    }
    final lastQuater = "$firstMonthName $firstYear- $lastMonthName $secondYear";
    debugPrint(lastQuater);
    return lastQuater;
  }

  String get displayName {
    List<String> months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    var now = DateTime.now();
    final currentMonth = now.month;
    final currentYear = now.year;
    final lastYear = now.year - 1;

    switch (this) {
      case EnumAllTimes.all:
        return "All Time";
      case EnumAllTimes.thisMonth:
        return "${months[currentMonth - 1]} $currentYear";
      case EnumAllTimes.lastMonth:
        final lastMonthIndex = currentMonth - 2;
        var lastMonth = "";
        var year = currentYear;
        if (lastMonthIndex < 0) {
          final positiveLastMonth = 12 + lastMonthIndex;
          lastMonth = months[positiveLastMonth];
          year = lastYear;
        } else {
          lastMonth = months[lastMonthIndex];
          year = currentYear;
        }
        return "$lastMonth $year";
      case EnumAllTimes.thisQuater:
        var firstMonthIndex = currentMonth - 3;
        var lastMonthIndex = currentMonth - 1;
        final lastQuater = getQuater(
            firstMonthIndex: firstMonthIndex,
            lastMonthIndex: lastMonthIndex,
            currentYear: currentYear,
            months: months,
            lastYear: lastYear);
        return lastQuater;

      case EnumAllTimes.lastQuater:
        var firstMonthIndex = currentMonth - 6;
        var lastMonthIndex = currentMonth - 4;
        final lastQuater = getQuater(
            firstMonthIndex: firstMonthIndex,
            lastMonthIndex: lastMonthIndex,
            currentYear: currentYear,
            months: months,
            lastYear: lastYear);
        return lastQuater;
      case EnumAllTimes.thisYear:
        return "Jan $currentYear - Dec $currentYear";
      case EnumAllTimes.lastYear:
        return "Jan $lastYear - Dec $lastYear";
    }
  }

  get title {
    switch (this) {
      case EnumAllTimes.all:
        return "All Time";
      case EnumAllTimes.thisMonth:
        return "This Month";
      case EnumAllTimes.lastMonth:
        return "Last Month";
      case EnumAllTimes.thisQuater:
        return "This Quater";
      case EnumAllTimes.lastQuater:
        return "Last Quater";
      case EnumAllTimes.thisYear:
        return "This Fiscal Year";
      case EnumAllTimes.lastYear:
        return "Last Fiscal Year";
    }
  }
}

class ListCountHeader extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String capsuleText;
  final EnumAllTimes? selectedMenuItem;
  final Function(String)? onSubmitted;
  final Function(EnumAllTimes, String) onSelectedMenuItem;
  final Function()? dismissKeyboard;

  const ListCountHeader({
    super.key,
    this.selectedMenuItem,
    required this.controller,
    required this.hintText,
    required this.capsuleText,
    required this.onSubmitted,
    required this.onSelectedMenuItem,
    required this.dismissKeyboard,
  });

  @override
  State<ListCountHeader> createState() => _ListCountHeaderState();
}

class _ListCountHeaderState extends State<ListCountHeader> {
  bool isShowCancel = false;
  final CustomPopupMenuController _controller = CustomPopupMenuController();
  List<EnumAllTimes> menuItems = [
    EnumAllTimes.all,
    EnumAllTimes.thisMonth,
    EnumAllTimes.lastMonth,
    EnumAllTimes.thisQuater,
    EnumAllTimes.lastQuater,
    EnumAllTimes.thisYear,
    EnumAllTimes.lastYear,
  ];
  EnumAllTimes selectedItem = EnumAllTimes.all;

  @override
  void initState() {
    selectedItem = widget.selectedMenuItem ?? EnumAllTimes.all;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      decoration: const BoxDecoration(color: AppPallete.white),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: CupertinoSearchTextField(
                  style: AppFonts.regularStyle(),
                  onSuffixTap: () {
                    if (isShowCancel == true) {
                      isShowCancel = false;
                    }
                    widget.controller.text = "";
                    setState(() {});
                    if (widget.onSubmitted != null) {
                      widget.onSubmitted!(widget.controller.text);
                    }
                  },
                  onTap: () {
                    debugPrint("Tpaped");
                    if (isShowCancel == false) {
                      isShowCancel = true;
                      setState(() {});
                    }
                  },
                  placeholder: widget.hintText,
                  controller: widget.controller,
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  prefixInsets: const EdgeInsets.only(left: 15),
                  onSubmitted: (value) {
                    if (widget.onSubmitted != null) {
                      widget.onSubmitted!(value);
                    }
                  },
                ),
              ),
              Offstage(
                offstage: !isShowCancel,
                child: AnimatedSwitcher(
                  duration: Duration(milliseconds: 500),
                  key: Key("isShowCancel"),
                  child: isShowCancel
                      ? TextButton(
                          onPressed: () {
                            if (isShowCancel == true) {
                              isShowCancel = false;
                            }
                            if (widget.controller.text.isNotEmpty) {
                              widget.controller.text = "";
                              setState(() {});
                              if (widget.onSubmitted != null) {
                                widget.onSubmitted!(widget.controller.text);
                              }
                            } else {
                              setState(() {});
                              if (widget.dismissKeyboard != null) {
                                widget.dismissKeyboard!();
                              }
                            }
                          },
                          child: Text(
                            "Cancel",
                            style: AppFonts.regularStyle(
                                color: AppPallete.blueColor),
                          ))
                      : null,
                ),
                //child: AnimatedSwitcher(duration: Duration(milliseconds: 500)),
              )
            ],
          ),
          AppConstants.sizeBoxHeight15,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomPopupMenu(
                position: PreferredPosition.bottom,
                arrowSize: 20,
                arrowColor: AppPallete.white,
                menuBuilder: () {
                  return PopOverContentWidget(
                    menuItems: menuItems,
                    selectedItem: selectedItem,
                    onSelectItem: (val) {
                      debugPrint(val.title);
                      debugPrint("Formatted Date: ${val.displayName}");
                      selectedItem = val;
                      if (widget.onSelectedMenuItem != null) {
                        widget.onSelectedMenuItem!(val, val.displayName);
                      }
                      _controller.hideMenu();
                    },
                  );
                },
                menuOnChange: (updated) {},
                verticalMargin: -10,
                pressType: PressType.singleClick,
                controller: _controller,
                child: Row(
                  children: [
                    const Icon(
                      Icons.calendar_month,
                      color: AppPallete.blueColor,
                    ),
                    AppConstants.sizeBoxWidth10,
                    Text(
                      selectedItem.displayName,
                      style: AppFonts.regularStyle(color: AppPallete.blueColor),
                    )
                  ],
                ),
              ),
              CapsuleStatusWidget(
                  title: widget.capsuleText,
                  backgroundColor: AppPallete.kF2F2F2,
                  textColor: AppPallete.k666666)
            ],
          ),
        ],
      ),
    );
  }
}

class PopOverContentWidget extends StatelessWidget {
  const PopOverContentWidget({
    super.key,
    required this.menuItems,
    required this.selectedItem,
    required this.onSelectItem,
  });

  final List<EnumAllTimes> menuItems;
  final EnumAllTimes selectedItem;
  final Function(EnumAllTimes) onSelectItem;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        color: const Color(0xFF4C4C4C),
        child: IntrinsicWidth(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: menuItems
                .map(
                  (item) => GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      onSelectItem(item);
                    },
                    child: Container(
                      color: Colors.white,
                      height: 40,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(item.title,
                                style: AppFonts.regularStyle()),
                          ),
                          AppConstants.sizeBoxWidth10,
                          if (selectedItem == item)
                            const Icon(
                              Icons.check,
                              color: AppPallete.blueColor,
                            ),
                        ],
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
