class RegisterUserResEntity {
  int? success;
  RegisterUserDataEntity? data;

  RegisterUserResEntity({
    this.success,
    this.data,
  });
}

class RegisterUserDataEntity {
  bool? success;
  String? message;

  RegisterUserDataEntity({
    this.success,
    this.message,
  });
}
