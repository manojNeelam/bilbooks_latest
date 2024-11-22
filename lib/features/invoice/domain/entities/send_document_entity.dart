class SendDocumentMainResEntity {
  int? success;
  SendDocumentDataEntity? data;

  SendDocumentMainResEntity({
    this.success,
    this.data,
  });
}

class SendDocumentDataEntity {
  bool? success;
  String? message;
  SendDocumentDataEntity({
    this.success,
    this.message,
  });
}
