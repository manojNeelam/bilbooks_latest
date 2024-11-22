// To parse this JSON data, do
//
//     final updateOrganizationMainResModel = updateOrganizationMainResModelFromJson(jsonString);

import 'dart:convert';

import 'package:billbooks_app/features/more/settings/domain/entity/update_organization_entity.dart';

UpdateOrganizationMainResModel updateOrganizationMainResModelFromJson(
        String str) =>
    UpdateOrganizationMainResModel.fromJson(json.decode(str));

class UpdateOrganizationMainResModel extends UpdateOrganizationMainResEntity {
  UpdateOrganizationMainResModel({
    int? success,
    UpdateOrganizationDataModel? data,
  }) : super(data: data, success: success);

  factory UpdateOrganizationMainResModel.fromJson(Map<String, dynamic> json) =>
      UpdateOrganizationMainResModel(
        success: json["success"],
        data: json["data"] == null
            ? null
            : UpdateOrganizationDataModel.fromJson(json["data"]),
      );
}

class UpdateOrganizationDataModel extends UpdateOrganizationDataEntity {
  UpdateOrganizationDataModel({
    bool? success,
    String? message,
  }) : super(success: success, message: message);

  factory UpdateOrganizationDataModel.fromJson(Map<String, dynamic> json) =>
      UpdateOrganizationDataModel(
        success: json["success"],
        message: json["message"],
      );
}
