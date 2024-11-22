class AddInvoiceMainResEntity {
  int? success;
  AddInvoiceDataEntity? data;

  AddInvoiceMainResEntity({
    this.success,
    this.data,
  });
}

class AddInvoiceDataEntity {
  bool? success;
  String? message;
  int? estimateId;
  AddInvoiceDataEntity({
    this.success,
    this.message,
    this.estimateId,
  });
}
