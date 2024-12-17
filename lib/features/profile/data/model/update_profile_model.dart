// To parse this JSON data, do
//
//     final updateMyProfileModel = updateMyProfileModelFromJson(jsonString);

import 'dart:convert';

import 'package:billbooks_app/features/profile/domain/entity/profile_entity.dart';

UpdateMyProfileModel updateMyProfileModelFromJson(String str) =>
    UpdateMyProfileModel.fromJson(json.decode(str));

class UpdateMyProfileModel extends UpdateMyProfileResponseEntity {
  UpdateMyProfileModel({
    int? success,
    UpdateMyProfileDataModel? data,
  }) : super(data: data, success: success);

  factory UpdateMyProfileModel.fromJson(Map<String, dynamic> json) =>
      UpdateMyProfileModel(
        success: json["success"],
        data: json["data"] == null
            ? null
            : UpdateMyProfileDataModel.fromJson(json["data"]),
      );
}

class UpdateMyProfileDataModel extends UpdateMyProfileDataEntity {
  UpdateMyProfileDataModel({bool? success, String? message})
      : super(
          success: success,
          message: message,
        );

  factory UpdateMyProfileDataModel.fromJson(Map<String, dynamic> json) =>
      UpdateMyProfileDataModel(
        success: json["success"],
        message: json["message"],
      );
}
