class UpdateClientMainResEntity {
  int? success;
  UpdateClientEntity? data;

  UpdateClientMainResEntity({
    this.success,
    this.data,
  });
}

class UpdateClientEntity {
  bool? success;
  String? message;

  UpdateClientEntity({
    this.success,
    this.message,
  });
}
