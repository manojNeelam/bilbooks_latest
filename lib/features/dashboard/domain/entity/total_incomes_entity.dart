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
  List<TotalIncomesEntity>? data;
  String? message;

  TotalIncomesDataEntity({
    this.success,
    this.data,
    this.message,
  });
}

class TotalIncomesEntity {
  String? currency;
  String? today;
  String? thisWeek;
  String? thisMonth;
  String? thisQuarter;
  String? thisFiscalYear;

  TotalIncomesEntity({
    this.currency,
    this.today,
    this.thisWeek,
    this.thisMonth,
    this.thisQuarter,
    this.thisFiscalYear,
  });
}
