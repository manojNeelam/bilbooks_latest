import 'package:billbooks_app/features/clients/domain/entities/client_list_entity.dart';

class CreditNoteListMainResponseEntity {
  int? success;
  CreditNoteListDataEntity? data;

  CreditNoteListMainResponseEntity({
    this.success,
    this.data,
  });
}

class CreditNoteListDataEntity {
  bool? success;
  List<CreditNoteStatusCountEntity>? statusCount;
  List<CreditNoteGrandtotalEntity>? grandtotal;
  Paging? paging;
  List<CreditNoteEntity>? creditnotes;
  String? message;

  CreditNoteListDataEntity({
    this.success,
    this.statusCount,
    this.grandtotal,
    this.paging,
    this.creditnotes,
    this.message,
  });
}

class CreditNoteEntity {
  String? creditNoteId;
  String? creditnoteDate;
  String? creditnoteNo;
  String? invoiceNo;
  String? clientName;
  String? projectName;
  String? status;
  String? expiryDate;
  String? formatedAmount;
  String? currency;

  CreditNoteEntity({
    this.creditNoteId,
    this.creditnoteDate,
    this.creditnoteNo,
    this.invoiceNo,
    this.clientName,
    this.projectName,
    this.status,
    this.expiryDate,
    this.formatedAmount,
    this.currency,
  });
}

class CreditNoteStatusCountEntity {
  String? allcount;
  String? unused;
  String? applied;
  String? statusCountVoid;

  CreditNoteStatusCountEntity({
    this.allcount,
    this.unused,
    this.applied,
    this.statusCountVoid,
  });
}

class CreditNoteGrandtotalEntity {
  String? currency;
  String? amount;
  String? formatedAmount;

  CreditNoteGrandtotalEntity({
    this.currency,
    this.amount,
    this.formatedAmount,
  });
}
