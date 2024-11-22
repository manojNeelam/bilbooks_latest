// To parse this JSON data, do
//
//     final projectDeleteMainDataModel = projectDeleteMainDataModelFromJson(jsonString);

import 'dart:convert';

import 'package:billbooks_app/features/project/domain/entity/project_delete_entity.dart';

ProjectDeleteMainDataModel projectDeleteMainDataModelFromJson(String str) =>
    ProjectDeleteMainDataModel.fromJson(json.decode(str));

class ProjectDeleteMainDataModel extends ProjectDeleteMainResEntity {
  ProjectDeleteMainDataModel({
    int? success,
    ProjectDeleteDataModel? data,
  }) : super(data: data, success: success);

  factory ProjectDeleteMainDataModel.fromJson(Map<String, dynamic> json) =>
      ProjectDeleteMainDataModel(
        success: json["success"],
        data: json["data"] == null
            ? null
            : ProjectDeleteDataModel.fromJson(json["data"]),
      );
}

class ProjectDeleteDataModel extends ProjectDeleteEntity {
  ProjectDeleteDataModel({
    bool? success,
    String? message,
  }) : super(success: success, message: message);

  factory ProjectDeleteDataModel.fromJson(Map<String, dynamic> json) =>
      ProjectDeleteDataModel(
        success: json["success"],
        message: json["message"],
      );
}
