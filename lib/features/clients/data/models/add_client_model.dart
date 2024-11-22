// To parse this JSON data, do
//
//     final clientDetailsMainResModel = clientDetailsMainResModelFromJson(jsonString);

import 'dart:convert';

import '../../domain/entities/add_client_entity.dart';

ClientAddMainResModel clientAddMainResModelFromJson(String str) =>
    ClientAddMainResModel.fromJson(json.decode(str));

class ClientAddMainResModel extends ClientAddMainResEntity {
  ClientAddMainResModel({
    int? success,
    ClientAddDataModel? data,
  }) : super(
          data: data,
          success: success,
        );

  factory ClientAddMainResModel.fromJson(Map<String, dynamic> json) =>
      ClientAddMainResModel(
        success: json["success"],
        data: json["data"] == null
            ? null
            : ClientAddDataModel.fromJson(json["data"]),
      );
}

class ClientAddDataModel extends ClientAddDataEntity {
  ClientAddDataModel({
    bool? success,
    String? message,
  }) : super(
          success: success,
          message: message,
        );

  factory ClientAddDataModel.fromJson(Map<String, dynamic> json) =>
      ClientAddDataModel(
        success: json["success"],
        message: json["message"],
      );
}
