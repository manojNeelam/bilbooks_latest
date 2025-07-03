class CreditNoteDetailsMainResEntity {
  int? success;
  CreditNoteDetailDataEntity? data;

  CreditNoteDetailsMainResEntity({
    this.success,
    this.data,
  });
}

class CreditNoteDetailDataEntity {
  bool? success;
  String? message;
  CreditNotesDetailEntity? creditNotes;

  CreditNoteDetailDataEntity({
    this.success,
    this.message,
    this.creditNotes,
  });
}

class CreditNotesDetailEntity {
  String? creditNoteId;
  String? organizationId;
  String? noteNo;
  String? invoiceId;
  String? clientId;
  String? currency;
  String? projectId;
  String? description;
  String? amount;
  String? status;
  DateTime? expiryDate;
  String? createdBy;
  DateTime? dateCreated;
  String? modifiedBy;
  dynamic dateModified;
  dynamic no;
  String? clientName;
  String? projectName;
  String? days;

  CreditNotesDetailEntity({
    this.creditNoteId,
    this.organizationId,
    this.noteNo,
    this.invoiceId,
    this.clientId,
    this.currency,
    this.projectId,
    this.description,
    this.amount,
    this.status,
    this.expiryDate,
    this.createdBy,
    this.dateCreated,
    this.modifiedBy,
    this.dateModified,
    this.no,
    this.clientName,
    this.projectName,
    this.days,
  });
}
