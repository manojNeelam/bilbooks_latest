class ForgotPasswordReqResEntity {
  int? success;
  ForgotPasswordReqDataEntity? data;

  ForgotPasswordReqResEntity({
    this.success,
    this.data,
  });
}

class ForgotPasswordReqDataEntity {
  bool? success;
  String? message;
  String? hashkey;

  ForgotPasswordReqDataEntity({
    this.success,
    this.message,
    this.hashkey,
  });
}
