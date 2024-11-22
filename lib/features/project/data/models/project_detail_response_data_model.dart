// To parse this JSON data, do
//
//     final projectDetailMainResDataModel = projectDetailMainResDataModelFromJson(jsonString);

import 'dart:convert';

import 'package:billbooks_app/features/project/data/models/project_list_data.dart';
import 'package:billbooks_app/features/project/domain/entity/project_details_entity.dart';

ProjectDetailMainResDataModel projectDetailMainResDataModelFromJson(
        String str) =>
    ProjectDetailMainResDataModel.fromJson(json.decode(str));

class ProjectDetailMainResDataModel extends ProjectDetailMainResEntity {
  ProjectDetailMainResDataModel({
    int? success,
    ProjectDetailDataModel? data,
  }) : super(success: success, data: data);

  factory ProjectDetailMainResDataModel.fromJson(Map<String, dynamic> json) =>
      ProjectDetailMainResDataModel(
        success: json["success"],
        data: json["data"] == null
            ? null
            : ProjectDetailDataModel.fromJson(json["data"]),
      );
}

class ProjectDetailDataModel extends ProjectDetailDataEntity {
  ProjectDetailDataModel({
    bool? success,
    ProjectData? project,
    String? message,
  }) : super(success: success, project: project, message: message);

  factory ProjectDetailDataModel.fromJson(Map<String, dynamic> json) =>
      ProjectDetailDataModel(
        success: json["success"],
        project: json["project"] == null
            ? null
            : ProjectData.fromJson(json["project"]),
        message: json["message"],
      );
}
