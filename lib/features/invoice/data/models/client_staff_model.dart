// To parse this JSON data, do
//
//     final clientStaffMainResModel = clientStaffMainResModelFromJson(jsonString);

import 'dart:convert';

import 'package:billbooks_app/features/clients/data/models/client_list_model.dart';

import '../../domain/entities/client_staff_entity.dart';

ClientStaffMainResModel clientStaffMainResModelFromJson(String str) =>
    ClientStaffMainResModel.fromJson(json.decode(str));

class ClientStaffMainResModel extends ClientStaffMainResEntity {
  ClientStaffMainResModel({
    int? success,
    ClientStaffDataModel? data,
  }) : super(
          data: data,
          success: success,
        );

  factory ClientStaffMainResModel.fromJson(Map<String, dynamic> json) =>
      ClientStaffMainResModel(
        success: json["success"],
        data: json["data"] == null
            ? null
            : ClientStaffDataModel.fromJson(json["data"]),
      );
}

class ClientStaffDataModel extends ClientStaffDataEntity {
  ClientStaffDataModel({
    bool? success,
    List<PersonModel>? staffs,
    String? message,
  }) : super(
          message: message,
          success: success,
          staffs: staffs,
        );

  factory ClientStaffDataModel.fromJson(Map<String, dynamic> json) =>
      ClientStaffDataModel(
        success: json["success"],
        staffs: json["staffs"] == null
            ? []
            : List<PersonModel>.from(
                json["staffs"]!.map((x) => PersonModel.fromJson(x))),
        message: json["message"],
      );
}
