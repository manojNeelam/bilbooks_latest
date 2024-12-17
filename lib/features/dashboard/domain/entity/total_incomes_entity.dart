class TotalIncomesMainResEntity {
  int? success;
  TotalIncomesDataEntity? data;

  TotalIncomesMainResEntity({
    this.success,
    this.data,
  });
}

class TotalIncomesDataEntity {
  bool? success;
  List<TotalIncomesMainDataEntity>? data;
  String? message;

  TotalIncomesDataEntity({
    this.success,
    this.data,
    this.message,
  });
}

class TotalIncomesMainDataEntity {
  String? currency;
  TotalIncomesEntity? details;
  TotalIncomesMainDataEntity({this.currency, this.details});
}

class TotalIncomesEntity {
  String? today;
  String? thisWeek;
  String? thisMonth;
  String? thisQuarter;
  String? thisFiscalYear;

  TotalIncomesEntity({
    this.today,
    this.thisWeek,
    this.thisMonth,
    this.thisQuarter,
    this.thisFiscalYear,
  });
}
