class UpdateCreditNoteMainResponseEntity {
  int? success;
  UpdateCreditNoteDataEntity? data;

  UpdateCreditNoteMainResponseEntity({
    this.success,
    this.data,
  });
}

class UpdateCreditNoteDataEntity {
  bool? success;
  String? message;

  UpdateCreditNoteDataEntity({
    this.success,
    this.message,
  });
}
