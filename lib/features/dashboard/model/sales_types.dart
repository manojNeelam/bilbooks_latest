import 'package:flutter/foundation.dart';

enum EnumSummaryTypes {
  last30Days,
  thisMonth,
  lastMonth,
  thisQuater,
  lastQuater,
  thisYear,
  lastYear
}

extension EnumSummaryTypesExtension on EnumSummaryTypes {
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
      case EnumSummaryTypes.last30Days:
        return "Last 30 Days";
      case EnumSummaryTypes.thisMonth:
        return "${months[currentMonth - 1]} $currentYear";
      case EnumSummaryTypes.lastMonth:
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
      case EnumSummaryTypes.thisQuater:
        var firstMonthIndex = currentMonth - 3;
        var lastMonthIndex = currentMonth - 1;
        final lastQuater = getQuater(
            firstMonthIndex: firstMonthIndex,
            lastMonthIndex: lastMonthIndex,
            currentYear: currentYear,
            months: months,
            lastYear: lastYear);
        return lastQuater;

      case EnumSummaryTypes.lastQuater:
        var firstMonthIndex = currentMonth - 6;
        var lastMonthIndex = currentMonth - 4;
        final lastQuater = getQuater(
            firstMonthIndex: firstMonthIndex,
            lastMonthIndex: lastMonthIndex,
            currentYear: currentYear,
            months: months,
            lastYear: lastYear);
        return lastQuater;
      case EnumSummaryTypes.thisYear:
        return "Jan $currentYear - Dec $currentYear";
      case EnumSummaryTypes.lastYear:
        return "Jan $lastYear - Dec $lastYear";
    }
  }

  get title {
    switch (this) {
      case EnumSummaryTypes.last30Days:
        return "Last 30 Days";
      case EnumSummaryTypes.thisMonth:
        return "This Month";
      case EnumSummaryTypes.lastMonth:
        return "Last Month";
      case EnumSummaryTypes.thisQuater:
        return "This Quater";
      case EnumSummaryTypes.lastQuater:
        return "Last Quater";
      case EnumSummaryTypes.thisYear:
        return "This Fiscal Year";
      case EnumSummaryTypes.lastYear:
        return "Last Fiscal Year";
    }
  }
}
