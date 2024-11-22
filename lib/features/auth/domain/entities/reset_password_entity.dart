class ResetPasswordResEntity {
  int? success;
  ResetPasswordDataEntity? data;

  ResetPasswordResEntity({
    this.success,
    this.data,
  });
}

class ResetPasswordDataEntity {
  bool? success;
  String? message;

  ResetPasswordDataEntity({
    this.success,
    this.message,
  });
}
