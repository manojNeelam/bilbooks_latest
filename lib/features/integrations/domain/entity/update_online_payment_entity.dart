class UpdateOnlinePaymentMainResEntity {
  int? success;
  UpdateOnlinePaymentDataEntity? data;

  UpdateOnlinePaymentMainResEntity({
    this.success,
    this.data,
  });
}

class UpdateOnlinePaymentDataEntity {
  bool? success;
  String? message;

  UpdateOnlinePaymentDataEntity({
    this.success,
    this.message,
  });
}
