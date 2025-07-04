// To parse this JSON data, do
//
//     final creditNoteDeleteMainResModel = creditNoteDeleteMainResModelFromJson(jsonString);

import 'dart:convert';

import '../../domain/entity/credit_note_delete_entity.dart';

CreditNoteDeleteMainResModel creditNoteDeleteMainResModelFromJson(String str) =>
    CreditNoteDeleteMainResModel.fromJson(json.decode(str));

class CreditNoteDeleteMainResModel extends CreditNoteDeleteMainResEntity {
  CreditNoteDeleteMainResModel({
    int? success,
    CreditNoteDeleteMainData? data,
  }) : super(data: data, success: success);

  factory CreditNoteDeleteMainResModel.fromJson(Map<String, dynamic> json) =>
      CreditNoteDeleteMainResModel(
        success: json["success"],
        data: json["data"] == null
            ? null
            : CreditNoteDeleteMainData.fromJson(json["data"]),
      );
}

class CreditNoteDeleteMainData extends CreditNoteDataEntity {
  CreditNoteDeleteMainData({
    bool? success,
    String? message,
  }) : super(
          success: success,
          message: message,
        );

  factory CreditNoteDeleteMainData.fromJson(Map<String, dynamic> json) =>
      CreditNoteDeleteMainData(
        success: json["success"],
        message: json["message"],
      );
}
