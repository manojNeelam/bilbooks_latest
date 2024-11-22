class InvoiceMarksendMainResEntity {
  int? success;
  InvoiceMarksendDataEntity? data;

  InvoiceMarksendMainResEntity({
    this.success,
    this.data,
  });
}

class InvoiceMarksendDataEntity {
  bool? success;
  String? message;

  InvoiceMarksendDataEntity({
    this.success,
    this.message,
  });
}
