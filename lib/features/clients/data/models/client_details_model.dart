// To parse this JSON data, do
//
//     final clientDetailsMainResModel = clientDetailsMainResModelFromJson(jsonString);

import 'dart:convert';

import 'package:billbooks_app/features/clients/data/models/client_list_model.dart';
import 'package:billbooks_app/features/clients/domain/entities/client_details_entity.dart';

ClientDetailsMainResModel clientDetailsMainResModelFromJson(String str) =>
    ClientDetailsMainResModel.fromJson(json.decode(str));

class ClientDetailsMainResModel extends ClientDetailsMainResEntity {
  ClientDetailsMainResModel({
    int? success,
    ClientDetailsDataModel? data,
  }) : super(
          data: data,
          success: success,
        );

  factory ClientDetailsMainResModel.fromJson(Map<String, dynamic> json) =>
      ClientDetailsMainResModel(
        success: json["success"],
        data: json["data"] == null
            ? null
            : ClientDetailsDataModel.fromJson(json["data"]),
      );
}

class ClientDetailsDataModel extends ClientDetailsDataEntity {
  ClientDetailsDataModel({
    bool? success,
    ClientModel? client,
    String? message,
  }) : super(
          success: success,
          client: client,
          message: message,
        );

  factory ClientDetailsDataModel.fromJson(Map<String, dynamic> json) =>
      ClientDetailsDataModel(
        success: json["success"],
        client: json["client"] == null
            ? null
            : ClientModel.fromJson(json["client"]),
        message: json["message"],
      );
}
