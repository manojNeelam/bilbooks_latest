// To parse this JSON data, do
//
//     final creditNoteListMainResponseModel = creditNoteListMainResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:billbooks_app/features/clients/data/models/client_list_model.dart';
import '../../domain/entity/credit_notes_list_entity.dart';

CreditNoteListMainResponseModel creditNoteListMainResponseModelFromJson(
        String str) =>
    CreditNoteListMainResponseModel.fromJson(json.decode(str));

class CreditNoteListMainResponseModel extends CreditNoteListMainResponseEntity {
  CreditNoteListMainResponseModel({
    int? success,
    CreditNoteListDataModel? data,
  }) : super(
          success: success,
          data: data,
        );

  factory CreditNoteListMainResponseModel.fromJson(Map<String, dynamic> json) =>
      CreditNoteListMainResponseModel(
        success: json["success"],
        data: json["data"] == null
            ? null
            : CreditNoteListDataModel.fromJson(json["data"]),
      );
}

class CreditNoteListDataModel extends CreditNoteListDataEntity {
  CreditNoteListDataModel({
    bool? success,
    List<CreditNoteStatusCountModel>? statusCount,
    List<CreditNoteGrandtotalModel>? grandtotal,
    PagingModel? paging,
    List<CreditNoteModel>? creditnotes,
    String? message,
  }) : super(
            success: success,
            statusCount: statusCount,
            grandtotal: grandtotal,
            paging: paging,
            creditnotes: creditnotes,
            message: message);

  factory CreditNoteListDataModel.fromJson(Map<String, dynamic> json) =>
      CreditNoteListDataModel(
        success: json["success"],
        statusCount: json["status_count"] == null
            ? []
            : List<CreditNoteStatusCountModel>.from(json["status_count"]!
                .map((x) => CreditNoteStatusCountModel.fromJson(x))),
        grandtotal: json["grandtotal"] == null
            ? []
            : List<CreditNoteGrandtotalModel>.from(json["grandtotal"]!
                .map((x) => CreditNoteGrandtotalModel.fromJson(x))),
        paging: json["paging"] == null
            ? null
            : PagingModel.fromJson(json["paging"]),
        creditnotes: json["creditnotes"] == null
            ? []
            : List<CreditNoteModel>.from(
                json["creditnotes"]!.map((x) => CreditNoteModel.fromJson(x))),
        message: json["message"],
      );
}

class CreditNoteModel extends CreditNoteEntity {
  CreditNoteModel({
    String? creditNoteId,
    String? creditnoteDate,
    String? creditnoteNo,
    String? invoiceNo,
    String? clientName,
    String? projectName,
    String? status,
    String? expiryDate,
    String? formatedAmount,
    String? currency,
  }) : super(
          creditNoteId: creditNoteId,
          creditnoteDate: creditnoteDate,
          creditnoteNo: creditnoteNo,
          invoiceNo: invoiceNo,
          clientName: clientName,
          projectName: projectName,
          status: status,
          expiryDate: expiryDate,
          formatedAmount: formatedAmount,
          currency: currency,
        );

  factory CreditNoteModel.fromJson(Map<String, dynamic> json) =>
      CreditNoteModel(
        creditNoteId: json["credit_note_id"],
        creditnoteDate: json["creditnote_date"],
        creditnoteNo: json["creditnote_no"],
        invoiceNo: json["invoice_no"],
        clientName: json["client_name"],
        projectName: json["project_name"],
        status: json["status"],
        expiryDate: json["expiry_date"],
        formatedAmount: json["formated_amount"],
        currency: json["currency"],
      );
}

class CreditNoteGrandtotalModel extends CreditNoteGrandtotalEntity {
  CreditNoteGrandtotalModel({
    String? currency,
    String? amount,
    String? formatedAmount,
  }) : super(
          currency: currency,
          amount: amount,
          formatedAmount: formatedAmount,
        );

  factory CreditNoteGrandtotalModel.fromJson(Map<String, dynamic> json) =>
      CreditNoteGrandtotalModel(
        currency: json["currency"],
        amount: json["amount"],
        formatedAmount: json["formated_amount"],
      );
}

class CreditNoteStatusCountModel extends CreditNoteStatusCountEntity {
  CreditNoteStatusCountModel({
    String? allcount,
    String? unused,
    String? applied,
    String? statusCountVoid,
  }) : super(
            allcount: allcount,
            unused: unused,
            applied: applied,
            statusCountVoid: statusCountVoid);

  factory CreditNoteStatusCountModel.fromJson(Map<String, dynamic> json) =>
      CreditNoteStatusCountModel(
        allcount: json["allcount"],
        unused: json["unused"],
        applied: json["applied"],
        statusCountVoid: json["void"],
      );
}
