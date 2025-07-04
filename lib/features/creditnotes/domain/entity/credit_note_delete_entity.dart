class CreditNoteDeleteMainResEntity {
  int? success;
  CreditNoteDataEntity? data;

  CreditNoteDeleteMainResEntity({
    this.success,
    this.data,
  });
}

class CreditNoteDataEntity {
  bool? success;
  String? message;

  CreditNoteDataEntity({
    this.success,
    this.message,
  });
}
