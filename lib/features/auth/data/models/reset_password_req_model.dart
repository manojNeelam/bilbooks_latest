// To parse this JSON data, do
//
//     final forgotPasswordResModel = forgotPasswordResModelFromJson(jsonString);

import 'dart:convert';

import 'package:billbooks_app/features/auth/domain/entities/reset_password_req_entity.dart';

ForgotPasswordReqResModel forgotPasswordResModelFromJson(String str) =>
    ForgotPasswordReqResModel.fromJson(json.decode(str));

class ForgotPasswordReqResModel extends ForgotPasswordReqResEntity {
  ForgotPasswordReqResModel({
    int? success,
    ForgotPasswordReqDataEntity? data,
  }) : super(data: data, success: success);

  factory ForgotPasswordReqResModel.fromJson(Map<String, dynamic> json) =>
      ForgotPasswordReqResModel(
        success: json["success"],
        data: json["data"] == null
            ? null
            : ForgotPasswordReqDataModel.fromJson(json["data"]),
      );
}

class ForgotPasswordReqDataModel extends ForgotPasswordReqDataEntity {
  ForgotPasswordReqDataModel({
    bool? success,
    String? message,
    String? hashkey,
  }) : super(hashkey: hashkey, message: message, success: success);

  factory ForgotPasswordReqDataModel.fromJson(Map<String, dynamic> json) =>
      ForgotPasswordReqDataModel(
        success: json["success"],
        message: json["message"],
        hashkey: json["hashkey"],
      );
}
