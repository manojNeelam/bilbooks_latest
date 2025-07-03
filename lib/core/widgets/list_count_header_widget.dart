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

  int getLastDayFrom(int year, int month) {
    var date = DateTime(year, month, 0);
    return date.day;
  }

  String getStartDate(int month, int year) {
    return ("$year-$month-01");
  }

  String getEndDateForQuater(int month, int year) {
    return ("$year-$month-01");
  }

//MAY, 2024
  String getEndDateFrom(int month, int currentYear) {
    var nextMonth = month + 1; //13
    var calYear = currentYear;
    var calMonth = nextMonth;
    if (nextMonth > 12) {
      calYear = currentYear + 1;
      calMonth = 1;
    } //2025
    var lastDay = getLastDayFrom(calYear, calMonth); //31
    return "$currentYear-$month-$lastDay";
  }

  (String, String, String) get displayName {
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
    // var now = DateTime.now();
    // final currentMonth = now.month;
    // final currentYear = now.year;
    // var date = DateTime(currentYear, currentMonth - 1, 0);
    // var lastDay = date.day;
    // debugPrint("Last day: $lastDay");

    var now = DateTime.now();
    final currentMonth = now.month;
    final currentYear = now.year;
    final lastYear = now.year - 1;

    switch (this) {
      case EnumAllTimes.all:
        return ("", "", "All Time");
      case EnumAllTimes.thisMonth:

        //var lastDay = getDate(currentMonth, currentYear, lastYear)
        // var lastDay = getLastDayFrom(currentYear, currentMonth + 1);
        // debugPrint("lastDay: $lastDay");
        var endDateStr = getEndDateFrom(currentMonth, currentYear);
        var startDateStr = getStartDate(currentMonth, currentYear);

        debugPrint("This Month Start Date: $startDateStr");
        debugPrint("This Month End Date: $endDateStr");

        var startDate = "$currentYear-$currentMonth";
        //debugPrint("endDate:$endDate");
        debugPrint("startDate:$startDate");

        return (
          startDateStr,
          endDateStr,
          "${months[currentMonth - 1]} $currentYear"
        );
      case EnumAllTimes.lastMonth:
        var lastDay = getLastDayFrom(currentYear, currentMonth);
        var endDate = "$currentYear-$currentMonth-$lastDay";
        var startDate = "$currentYear-$currentMonth-1";
        debugPrint("endDate:$endDate");
        debugPrint("startDate:$startDate");

        var endDateStr = getEndDateFrom(currentMonth - 1, currentYear);
        var startDateStr = getStartDate(currentMonth - 1, currentYear);

        debugPrint("Last Month Start Date: $startDateStr");
        debugPrint("Last Month End Date: $endDateStr");

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
        return (
          startDateStr,
          endDateStr,
          "$lastMonth $year",
        );
      case EnumAllTimes.thisQuater:
        var firstMonthIndex = currentMonth - 3;
        var lastMonthIndex = currentMonth - 1;

        var startMonthIndex = currentMonth - 2;
        var calMonth = startMonthIndex;
        var calYear = currentYear;
        if (firstMonthIndex < 0) {
          final positiveVal = 12 + startMonthIndex;
          calMonth = positiveVal;
          calYear = currentYear - 1;
        }

        var startDateStr = getStartDate(calMonth, calYear);
        var endDateStr = getEndDateFrom(currentMonth, currentYear);

        debugPrint("This Quater Start Date: $startDateStr");
        debugPrint("This Quater End Date: $endDateStr");

        final lastQuater = getQuater(
            firstMonthIndex: firstMonthIndex,
            lastMonthIndex: lastMonthIndex,
            currentYear: currentYear,
            months: months,
            lastYear: lastYear);
        return (
          startDateStr,
          endDateStr,
          lastQuater,
        );

      case EnumAllTimes.lastQuater:
        var firstMonthIndex = currentMonth - 6;
        var lastMonthIndex = currentMonth - 4;

        var startMonthIndex = currentMonth - 5;
        var endMonthIndex = currentMonth - 3;
        var calStartMonth = startMonthIndex;
        var calEndMonth = endMonthIndex;
        var calStartYear = currentYear;
        var calEndYear = currentYear;

        if (startMonthIndex < 0) {
          final positiveVal = 12 + startMonthIndex;
          calStartMonth = positiveVal;
          calStartYear = currentYear - 1;
        }

        if (endMonthIndex < 0) {
          final positiveVal = 12 + endMonthIndex;
          calEndMonth = positiveVal;
          calEndYear = currentYear - 1;
        }

        var startDateStr = getStartDate(calStartMonth, calStartYear);
        var endDateStr = getEndDateFrom(calEndMonth, calEndYear);

        debugPrint("End Quater Start Date: $startDateStr");
        debugPrint("End Quater End Date: $endDateStr");

        final lastQuater = getQuater(
            firstMonthIndex: firstMonthIndex,
            lastMonthIndex: lastMonthIndex,
            currentYear: currentYear,
            months: months,
            lastYear: lastYear);
        return (
          startDateStr,
          endDateStr,
          lastQuater,
        );
      case EnumAllTimes.thisYear:
        debugPrint("$currentYear-12-31");
        return (
          "$currentYear-01-01",
          "$currentYear-12-31",
          "Jan $currentYear - Dec $currentYear",
        );
      case EnumAllTimes.lastYear:
        debugPrint("$lastYear-12-31");
        return (
          "$lastYear-01-01",
          "$lastYear-12-31",
          "Jan $lastYear - Dec $lastYear",
        );
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
  final Function(EnumAllTimes, String, String startDate, String endDate)
      onSelectedMenuItem;
  final Function()? dismissKeyboard;
  final bool isShowAllTime;

  const ListCountHeader({
    super.key,
    this.selectedMenuItem,
    required this.controller,
    required this.hintText,
    required this.capsuleText,
    required this.onSubmitted,
    required this.onSelectedMenuItem,
    required this.dismissKeyboard,
    this.isShowAllTime = true,
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
          if (widget.isShowAllTime)
            Column(
              children: [
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
                            debugPrint("Formatted Date: ${val.displayName.$3}");
                            selectedItem = val;
                            widget.onSelectedMenuItem(
                              val,
                              val.displayName.$3,
                              val.displayName.$1,
                              val.displayName.$2,
                            );
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
                            selectedItem.displayName.$3,
                            style: AppFonts.regularStyle(
                                color: AppPallete.blueColor),
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
            )
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
