// To parse this JSON data, do
//
//     final creditNoteDetailsMainResModel = creditNoteDetailsMainResModelFromJson(jsonString);

import 'dart:convert';

import 'package:billbooks_app/features/creditnotes/domain/entity/credit_note_details_entity.dart';

CreditNoteDetailsMainResModel creditNoteDetailsMainResModelFromJson(
        String str) =>
    CreditNoteDetailsMainResModel.fromJson(json.decode(str));

class CreditNoteDetailsMainResModel extends CreditNoteDetailsMainResEntity {
  CreditNoteDetailsMainResModel({
    int? success,
    CreditNoteDetailDataModel? data,
  }) : super(success: success, data: data);

  factory CreditNoteDetailsMainResModel.fromJson(Map<String, dynamic> json) =>
      CreditNoteDetailsMainResModel(
        success: json["success"],
        data: json["data"] == null
            ? null
            : CreditNoteDetailDataModel.fromJson(json["data"]),
      );
}

class CreditNoteDetailDataModel extends CreditNoteDetailDataEntity {
  CreditNoteDetailDataModel({
    bool? success,
    String? message,
    CreditNotesDetailModel? creditNotes,
  }) : super(
          success: success,
          message: message,
          creditNotes: creditNotes,
        );

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
          noteNo: noteNo,
          invoiceId: invoiceId,
          clientId: clientId,
          currency: currency,
          projectId: projectId,
          description: description,
          amount: amount,
          status: status,
          expiryDate: expiryDate,
          createdBy: createdBy,
          dateCreated: dateCreated,
          modifiedBy: modifiedBy,
          dateModified: dateModified,
          no: no,
          clientName: clientName,
          projectName: projectName,
          days: days,
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
