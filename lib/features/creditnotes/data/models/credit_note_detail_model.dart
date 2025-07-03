// To parse this JSON data, do
//
//     final creditNoteDetailsMainResModel = creditNoteDetailsMainResModelFromJson(jsonString);

import 'dart:convert';

import 'package:billbooks_app/features/creditnotes/domain/entity/credit_note_details_entity.dart';

CreditNoteDetailsMainResModel creditNoteDetailsMainResModelFromJson(
        String str) =>
    CreditNoteDetailsMainResModel.fromJson(json.decode(str));

class CreditNoteDetailsMainResModel extends CreditNoteDetailsMainResEntity {
  int? success;
  Data? data;

  CreditNoteDetailsMainResModel({
    this.success,
    this.data,
  });

  factory CreditNoteDetailsMainResModel.fromJson(Map<String, dynamic> json) =>
      CreditNoteDetailsMainResModel(
        success: json["success"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );
}

class CreditNoteDetailDataModel extends CreditNoteDetailDataEntity {
  bool? success;
  String? message;
  CreditNotesDetailModel? creditNotes;

  CreditNoteDetailDataModel({
    this.success,
    this.message,
    this.creditNotes,
  });

  factory CreditNoteDetailDataModel.fromJson(Map<String, dynamic> json) =>
      CreditNoteDetailDataModel(
        success: json["success"],
        message: json["message"],
        creditNotes: json["credit notes"] == null
            ? null
            : CreditNotesDetailModel.fromJson(json["credit notes"]),
      );
}

class CreditNotesDetailModel extends CreditNotesDetailEntity {
  CreditNotesDetailModel({
    String? creditNoteId,
    String? organizationId,
    String? noteNo,
    String? invoiceId,
    String? clientId,
    String? currency,
    String? projectId,
    String? description,
    String? amount,
    String? status,
    DateTime? expiryDate,
    String? createdBy,
    DateTime? dateCreated,
    String? modifiedBy,
    dynamic dateModified,
    dynamic no,
    String? clientName,
    String? projectName,
    String? days,
  }) : super(
          creditNoteId: creditNoteId,
          organizationId: organizationId,
        );

  factory CreditNotesDetailModel.fromJson(Map<String, dynamic> json) =>
      CreditNotesDetailModel(
        creditNoteId: json["credit_note_id"],
        organizationId: json["organization_id"],
        noteNo: json["note_no"],
        invoiceId: json["invoice_id"],
        clientId: json["client_id"],
        currency: json["currency"],
        projectId: json["project_id"],
        description: json["description"],
        amount: json["amount"],
        status: json["status"],
        expiryDate: json["expiry_date"] == null
            ? null
            : DateTime.parse(json["expiry_date"]),
        createdBy: json["created_by"],
        dateCreated: json["date_created"] == null
            ? null
            : DateTime.parse(json["date_created"]),
        modifiedBy: json["modified_by"],
        dateModified: json["date_modified"],
        no: json["no"],
        clientName: json["client_name"],
        projectName: json["project_name"],
        days: json["days"],
      );
}
