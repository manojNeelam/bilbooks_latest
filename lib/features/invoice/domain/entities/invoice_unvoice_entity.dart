class InvoiceUnVoidMainResEntity {
  int? success;
  InvoiceUnVoidDataEntity? data;

  InvoiceUnVoidMainResEntity({
    this.success,
    this.data,
  });
}

class InvoiceUnVoidDataEntity {
  bool? success;
  String? message;

  InvoiceUnVoidDataEntity({
    this.success,
    this.message,
  });
}
