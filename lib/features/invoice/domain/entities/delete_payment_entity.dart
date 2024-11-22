// To parse this JSON data, do
//
//     final deletePaymentMethodMainResEntity = deletePaymentMethodMainResEntityFromJson(jsonString);

class DeletePaymentMethodMainResEntity {
  int? success;
  DeletePaymentMethodDataEntity? data;

  DeletePaymentMethodMainResEntity({
    this.success,
    this.data,
  });
}

class DeletePaymentMethodDataEntity {
  bool? success;
  dynamic balance;
  String? message;

  DeletePaymentMethodDataEntity({
    this.success,
    this.balance,
    this.message,
  });
}
