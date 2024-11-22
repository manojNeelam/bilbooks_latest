// To parse this JSON data, do
//
//     final deleteClientMainDataModel = deleteClientMainDataModelFromJson(jsonString);

import 'dart:convert';

import 'package:billbooks_app/features/clients/domain/entities/delete_client_entity.dart';

DeleteClientMainDataModel deleteClientMainDataModelFromJson(String str) =>
    DeleteClientMainDataModel.fromJson(json.decode(str));

class DeleteClientMainDataModel extends DeleteClientMainResEntity {
  DeleteClientMainDataModel({
    int? success,
    DeleteClientData? data,
  }) : super(success: success, data: data);

  factory DeleteClientMainDataModel.fromJson(Map<String, dynamic> json) =>
      DeleteClientMainDataModel(
        success: json["success"],
        data: json["data"] == null
            ? null
            : DeleteClientData.fromJson(json["data"]),
      );
}

class DeleteClientData extends DeleteClientEntity {
  DeleteClientData({
    bool? success,
    String? message,
  }) : super(success: success, message: message);

  factory DeleteClientData.fromJson(Map<String, dynamic> json) =>
      DeleteClientData(
        success: json["success"],
        message: json["message"],
      );
}
