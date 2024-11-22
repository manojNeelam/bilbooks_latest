// To parse this JSON data, do
//
//     final projectStatusUpdateMainDataModel = projectStatusUpdateMainDataModelFromJson(jsonString);

import 'dart:convert';

import '../../domain/entity/project_update_status_entity.dart';

ProjectStatusUpdateMainDataModel projectStatusUpdateMainDataModelFromJson(
        String str) =>
    ProjectStatusUpdateMainDataModel.fromJson(json.decode(str));

class ProjectStatusUpdateMainDataModel
    extends ProjectStatusUpdateMainResEntity {
  ProjectStatusUpdateMainDataModel({
    int? success,
    ProjectStatusUpdateDataModel? data,
  }) : super(success: success, data: data);

  factory ProjectStatusUpdateMainDataModel.fromJson(
          Map<String, dynamic> json) =>
      ProjectStatusUpdateMainDataModel(
        success: json["success"],
        data: json["data"] == null
            ? null
            : ProjectStatusUpdateDataModel.fromJson(json["data"]),
      );
}

class ProjectStatusUpdateDataModel extends ProjectStatusUpdateDataEntity {
  ProjectStatusUpdateDataModel({
    bool? success,
    String? message,
  }) : super(success: success, message: message);

  factory ProjectStatusUpdateDataModel.fromJson(Map<String, dynamic> json) =>
      ProjectStatusUpdateDataModel(
        success: json["success"],
        message: json["message"],
      );
}
