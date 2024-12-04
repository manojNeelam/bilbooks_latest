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
    var now = DateTime.now();
    final currentMonth = now.month;
    final currentYear = now.year;
    final lastYear = now.year - 1;

    switch (this) {
      case EnumSummaryTypes.last30Days:
        return ("", "", "Last 30 Days");
      case EnumSummaryTypes.thisMonth:
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

      case EnumSummaryTypes.lastMonth:
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
      case EnumSummaryTypes.thisQuater:
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

      case EnumSummaryTypes.lastQuater:
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
      case EnumSummaryTypes.thisYear:
        debugPrint("$currentYear-12-31");
        return (
          "$currentYear-01-01",
          "$currentYear-12-31",
          "Jan $currentYear - Dec $currentYear",
        );
      case EnumSummaryTypes.lastYear:
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
