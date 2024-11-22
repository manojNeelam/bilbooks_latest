class InvoiceDeleteMainResEntity {
  int? success;
  InvoiceDeleteDataEntity? data;

  InvoiceDeleteMainResEntity({
    this.success,
    this.data,
  });
}

class InvoiceDeleteDataEntity {
  bool? success;
  String? message;

  InvoiceDeleteDataEntity({
    this.success,
    this.message,
  });
}
