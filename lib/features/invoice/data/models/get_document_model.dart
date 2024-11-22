// To parse this JSON data, do
//
//     final getDocumentMainResModel = getDocumentMainResModelFromJson(jsonString);

import 'dart:convert';

import 'package:billbooks_app/features/invoice/domain/entities/get_document_entity.dart';

GetDocumentMainResModel getDocumentMainResModelFromJson(String str) =>
    GetDocumentMainResModel.fromJson(json.decode(str));

class GetDocumentMainResModel extends GetDocumentMainResEntity {
  GetDocumentMainResModel({
    int? success,
    GetDocumentMainDataModel? data,
  }) : super(success: success, data: data);

  factory GetDocumentMainResModel.fromJson(Map<String, dynamic> json) =>
      GetDocumentMainResModel(
        success: json["success"],
        data: json["data"] == null
            ? null
            : GetDocumentMainDataModel.fromJson(json["data"]),
      );
}

class GetDocumentMainDataModel extends GetDocumentMainDataEntity {
  GetDocumentMainDataModel({
    bool? success,
    String? message,
    GetDocumentDataModel? data,
  }) : super(success: success, message: message, data: data);

  factory GetDocumentMainDataModel.fromJson(Map<String, dynamic> json) =>
      GetDocumentMainDataModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : GetDocumentDataModel.fromJson(json["data"]),
      );
}

class GetDocumentDataModel extends GetDocumentData {
  GetDocumentDataModel({
    int? id,
    String? no,
    String? date,
    String? name,
    String? amount,
    String? status,
    String? from,
    String? fromName,
    List<ContactModel>? fromContacts,
    List<ContactModel>? sendtoContacts,
    List<ContactModel>? bccContacts,
    List<String>? sendtoMails,
    List<String>? bccMails,
    String? subject,
    String? message,
    bool? attachPdf,
  }) : super(
          id: id,
          no: no,
          date: date,
          name: name,
          amount: amount,
          status: status,
          from: from,
          fromName: fromName,
          fromContacts: fromContacts,
          sendtoContacts: sendtoContacts,
          bccContacts: bccContacts,
          sendtoMails: sendtoMails,
          subject: subject,
          message: message,
          attachPdf: attachPdf,
        );

  factory GetDocumentDataModel.fromJson(Map<String, dynamic> json) =>
      GetDocumentDataModel(
        id: json["id"],
        no: json["no"],
        date: json["date"],
        name: json["name"],
        amount: json["amount"],
        status: json["status"],
        from: json["from"],
        fromName: json["from_name"],
        fromContacts: json["from_contacts"] == null
            ? []
            : List<ContactModel>.from(
                json["from_contacts"]!.map((x) => ContactModel.fromJson(x))),
        sendtoContacts: json["sendto_contacts"] == null
            ? []
            : List<ContactModel>.from(
                json["sendto_contacts"]!.map((x) => ContactModel.fromJson(x))),
        bccContacts: json["bcc_contacts"] == null
            ? []
            : List<ContactModel>.from(
                json["bcc_contacts"]!.map((x) => ContactModel.fromJson(x))),
        sendtoMails: json["sendto_mails"] == null
            ? []
            : List<String>.from(json["sendto_mails"]!.map((x) => x)),
        bccMails: json["bcc_mails"] == null
            ? []
            : List<String>.from(json["bcc_mails"]!.map((x) => x)),
        subject: json["subject"],
        message: json["message"],
        attachPdf: json["attach_pdf"],
      );
}

class ContactModel extends ContactEntity {
  ContactModel({
    String? id,
    String? name,
    String? email,
  }) : super(
          id: id,
          name: name,
          email: email,
        );

  factory ContactModel.fromJson(Map<String, dynamic> json) => ContactModel(
        id: json["id"],
        name: json["name"],
        email: json["email"],
      );
}
