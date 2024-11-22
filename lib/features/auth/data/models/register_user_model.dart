// To parse this JSON data, do
//
//     final registerUserResModel = registerUserResModelFromJson(jsonString);

import 'dart:convert';

import 'package:billbooks_app/features/auth/domain/entities/register_user_entity.dart';

RegisterUserResModel registerUserResModelFromJson(String str) =>
    RegisterUserResModel.fromJson(json.decode(str));

class RegisterUserResModel extends RegisterUserResEntity {
  RegisterUserResModel({
    int? success,
    RegisterUserDataModel? data,
  }) : super(success: success, data: data);

  factory RegisterUserResModel.fromJson(Map<String, dynamic> json) =>
      RegisterUserResModel(
        success: json["success"],
        data: json["data"] == null
            ? null
            : RegisterUserDataModel.fromJson(json["data"]),
      );
}

class RegisterUserDataModel extends RegisterUserDataEntity {
  RegisterUserDataModel({
    bool? success,
    String? message,
  }) : super(message: message, success: success);

  factory RegisterUserDataModel.fromJson(Map<String, dynamic> json) =>
      RegisterUserDataModel(
        success: json["success"],
        message: json["message"],
      );
}
