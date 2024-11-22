// To parse this JSON data, do
//
//     final deleteItemMainResEntity = deleteItemMainResEntityFromJson(jsonString);

class DeleteItemMainResEntity {
  int? success;
  DeleteItemDataEntity? data;

  DeleteItemMainResEntity({
    this.success,
    this.data,
  });
}

class DeleteItemDataEntity {
  bool? success;
  String? message;

  DeleteItemDataEntity({
    this.success,
    this.message,
  });
}
