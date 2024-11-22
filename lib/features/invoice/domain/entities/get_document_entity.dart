class GetDocumentMainResEntity {
  int? success;
  GetDocumentMainDataEntity? data;

  GetDocumentMainResEntity({
    this.success,
    this.data,
  });
}

class GetDocumentMainDataEntity {
  bool? success;
  String? message;
  GetDocumentData? data;

  GetDocumentMainDataEntity({
    this.success,
    this.message,
    this.data,
  });
}

class GetDocumentData {
  int? id;
  String? no;
  String? date;
  String? name;
  String? amount;
  String? status;
  String? from;
  String? fromName;
  List<ContactEntity>? fromContacts;
  List<ContactEntity>? sendtoContacts;
  List<ContactEntity>? bccContacts;
  List<String>? sendtoMails;
  List<String>? bccMails;
  String? subject;
  String? message;
  bool? attachPdf;

  GetDocumentData({
    this.id,
    this.no,
    this.date,
    this.name,
    this.amount,
    this.status,
    this.from,
    this.fromName,
    this.fromContacts,
    this.sendtoContacts,
    this.bccContacts,
    this.sendtoMails,
    this.bccMails,
    this.subject,
    this.message,
    this.attachPdf,
  });
}

class ContactEntity {
  String? id;
  String? name;
  String? email;

  ContactEntity({
    this.id,
    this.name,
    this.email,
  });
}
