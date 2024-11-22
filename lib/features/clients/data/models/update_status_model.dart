// To parse this JSON data, do
//

import 'dart:convert';

import '../../domain/entities/update_status_entity.dart';

UpdateClientMainDataModel updateClientMainDataModelFromJson(String str) =>
    UpdateClientMainDataModel.fromJson(json.decode(str));

class UpdateClientMainDataModel extends UpdateClientMainResEntity {
  UpdateClientMainDataModel({
    int? success,
    UpdateClientEntity? data,
  }) : super(success: success, data: data);

  factory UpdateClientMainDataModel.fromJson(Map<String, dynamic> json) =>
      UpdateClientMainDataModel(
        success: json["success"],
        data: json["data"] == null
            ? null
            : UpdateClientData.fromJson(json["data"]),
      );
}

class UpdateClientData extends UpdateClientEntity {
  UpdateClientData({
    bool? success,
    String? message,
  }) : super(success: success, message: message);

  factory UpdateClientData.fromJson(Map<String, dynamic> json) =>
      UpdateClientData(
        success: json["success"],
        message: json["message"],
      );
}
