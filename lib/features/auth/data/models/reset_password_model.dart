// To parse this JSON data, do
//
//     final resetPasswordResModel = resetPasswordResModelFromJson(jsonString);

import 'dart:convert';

import '../../domain/entities/reset_password_entity.dart';

ResetPasswordResModel resetPasswordResModelFromJson(String str) =>
    ResetPasswordResModel.fromJson(json.decode(str));

class ResetPasswordResModel extends ResetPasswordResEntity {
  ResetPasswordResModel({
    int? success,
    ResetPasswordDataModel? data,
  }) : super(success: success, data: data);

  factory ResetPasswordResModel.fromJson(Map<String, dynamic> json) =>
      ResetPasswordResModel(
        success: json["success"],
        data: json["data"] == null
            ? null
            : ResetPasswordDataModel.fromJson(json["data"]),
      );
}

class ResetPasswordDataModel extends ResetPasswordDataEntity {
  ResetPasswordDataModel({
    bool? success,
    String? message,
  }) : super(success: success, message: message);

  factory ResetPasswordDataModel.fromJson(Map<String, dynamic> json) =>
      ResetPasswordDataModel(
        success: json["success"],
        message: json["message"],
      );
}
