// To parse this JSON data, do
//
//     final addProjectMainResponseDataModel = addProjectMainResponseDataModelFromJson(jsonString);

import 'dart:convert';

import 'package:billbooks_app/features/project/domain/entity/add_project_main_response_entity.dart';

import '../../domain/entity/project_list_entity.dart';

AddProjectMainResponseDataModel addProjectMainResponseDataModelFromJson(
        String str) =>
    AddProjectMainResponseDataModel.fromJson(json.decode(str));

class AddProjectMainResponseDataModel extends AddProjectMainResponseEntity {
  AddProjectMainResponseDataModel({
    int? success,
    AddProjectData? data,
  }) : super(success: success, data: data);

  factory AddProjectMainResponseDataModel.fromJson(Map<String, dynamic> json) =>
      AddProjectMainResponseDataModel(
        success: json["success"],
        data:
            json["data"] == null ? null : AddProjectData.fromJson(json["data"]),
      );
}

class AddProjectData extends AddProjectEntity {
  AddProjectData({
    bool? success,
    Project? project,
    String? message,
  }) : super(success: success, project: project, message: message);

  factory AddProjectData.fromJson(Map<String, dynamic> json) => AddProjectData(
        success: json["success"],
        project:
            json["project"] == null ? null : Project.fromJson(json["project"]),
        message: json["message"],
      );
}

class Project extends ProjectEntity {
  Project({
    String? id,
    String? name,
    String? description,
    String? clientId,
    String? clientName,
    String? status,
    DateTime? dateCreated,
    dynamic dateModified,
  }) : super(
            id: id,
            name: name,
            description: description,
            clientId: clientId,
            clientName: clientName,
            status: status,
            dateCreated: dateCreated,
            dateModified: dateCreated);

  factory Project.fromJson(Map<String, dynamic> json) => Project(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        clientId: json["client_id"],
        clientName: json["client_name"],
        status: json["status"],
        dateCreated: json["date_created"] == null
            ? null
            : DateTime.parse(json["date_created"]),
        dateModified: json["date_modified"],
      );
}
