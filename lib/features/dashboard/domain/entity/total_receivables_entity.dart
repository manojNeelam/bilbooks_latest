class TotalReceivablesMainResEntity {
  int? success;
  TotalReceivablesDataEntity? data;

  TotalReceivablesMainResEntity({
    this.success,
    this.data,
  });
}

class TotalReceivablesDataEntity {
  bool? success;
  List<TotalReceivablesEntity>? data;
  String? message;

  TotalReceivablesDataEntity({
    this.success,
    this.data,
    this.message,
  });
}

class TotalReceivablesEntity {
  String? currency;
  dynamic today;
  dynamic the130Days;
  dynamic the3160Days;
  dynamic the6190Days;
  dynamic the90Days;

  TotalReceivablesEntity({
    this.currency,
    this.today,
    this.the130Days,
    this.the3160Days,
    this.the6190Days,
    this.the90Days,
  });
}
