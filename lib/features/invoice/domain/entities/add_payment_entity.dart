class AddPaymentMethodMainResEntity {
  int? success;
  AddPaymentMethodDataEntity? data;

  AddPaymentMethodMainResEntity({
    this.success,
    this.data,
  });
}

class AddPaymentMethodDataEntity {
  bool? success;
  int? paymentId;
  dynamic balance;
  String? message;

  AddPaymentMethodDataEntity({
    this.success,
    this.paymentId,
    this.balance,
    this.message,
  });
}
