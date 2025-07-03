import '../../domain/entity/update_credit_note_eitity.dart';

import 'dart:convert';

UpdateCreditNoteMainResponseModel updateCreditNoteMainResponseModelFromJson(
        String str) =>
    UpdateCreditNoteMainResponseModel.fromJson(json.decode(str));

class UpdateCreditNoteMainResponseModel
    extends UpdateCreditNoteMainResponseEntity {
  UpdateCreditNoteMainResponseModel({
    int? success,
    UpdateCreditNoteDataModel? data,
  }) : super(
          success: success,
          data: data,
        );

  factory UpdateCreditNoteMainResponseModel.fromJson(
          Map<String, dynamic> json) =>
      UpdateCreditNoteMainResponseModel(
        success: json["success"],
        data: json["data"] == null
            ? null
            : UpdateCreditNoteDataModel.fromJson(json["data"]),
      );
}

class UpdateCreditNoteDataModel extends UpdateCreditNoteDataEntity {
  UpdateCreditNoteDataModel({
    bool? success,
    String? message,
  }) : super(
          success: success,
          message: message,
        );

  factory UpdateCreditNoteDataModel.fromJson(Map<String, dynamic> json) =>
      UpdateCreditNoteDataModel(
        success: json["success"],
        message: json["message"],
      );
}
