class InvoiceVoidMainResEntity {
  int? success;
  InvoiceVoidDataEntity? data;

  InvoiceVoidMainResEntity({
    this.success,
    this.data,
  });
}

class InvoiceVoidDataEntity {
  bool? success;
  String? message;

  InvoiceVoidDataEntity({
    this.success,
    this.message,
  });
}
