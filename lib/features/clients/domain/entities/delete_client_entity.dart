class DeleteClientMainResEntity {
  int? success;
  DeleteClientEntity? data;

  DeleteClientMainResEntity({
    this.success,
    this.data,
  });
}

class DeleteClientEntity {
  bool? success;
  String? message;

  DeleteClientEntity({
    this.success,
    this.message,
  });
}
