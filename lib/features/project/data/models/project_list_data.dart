// To parse this JSON data, do
//
//     final projectMainResModel = projectMainResModelFromJson(jsonString);

import 'dart:convert';

import 'package:billbooks_app/features/clients/data/models/client_list_model.dart';
import 'package:billbooks_app/features/item/data/models/item_list_data_model.dart';
import 'package:billbooks_app/features/project/domain/entity/project_list_entity.dart';
import 'package:flutter/material.dart';

ProjectMainResModel projectMainResModelFromJson(String str) =>
    ProjectMainResModel.fromJson(json.decode(str));

class ProjectMainResModel extends ProjectMainResEntity {
  ProjectMainResModel({int? success, ProjectListData? data})
      : super(data: data, success: success);

  factory ProjectMainResModel.fromJson(Map<String, dynamic> json) =>
      ProjectMainResModel(
        success: json["success"],
        data: json["data"] == null
            ? null
            : ProjectListData.fromJson(json["data"]),
      );
}

class ProjectListData extends ProjectListEntity {
  ProjectListData({
    bool? success,
    List<StatusCountDataModel>? statusCount,
    PagingModel? paging,
    List<ProjectData>? projects,
    String? message,
  }) : super(
            success: success,
            statusCount: statusCount,
            paging: paging,
            projects: projects,
            message: message);

  factory ProjectListData.fromJson(Map<String, dynamic> json) =>
      ProjectListData(
        success: json["success"],
        statusCount: json["status_count"] == null
            ? []
            : List<StatusCountDataModel>.from(json["status_count"]!
                .map((x) => StatusCountDataModel.fromJson(x))),
        paging: json["paging"] == null
            ? null
            : PagingModel.fromJson(json["paging"]),
        projects: json["projects"] == null
            ? []
            : List<ProjectData>.from(
                json["projects"]!.map((x) => ProjectData.fromJson(x))),
        message: json["message"],
      );
}

class ProjectData extends ProjectEntity {
  ProjectData({
    String? id,
    String? organizationId,
    String? name,
    String? description,
    String? clientId,
    String? clientName,
    String? status,
    DateTime? dateCreated,
    DateTime? dateModified,
    int? invoicecount,
    int? estimatecount,
    int? expensescount,
  }) : super(
            clientId: clientId,
            id: id,
            organizationId: organizationId,
            name: name,
            description: description,
            clientName: clientName,
            status: status,
            dateCreated: dateCreated,
            dateModified: dateModified,
            invoicecount: invoicecount,
            expensescount: expensescount,
            estimatecount: estimatecount);

  factory ProjectData.fromJson(Map<String, dynamic> json) {
    debugPrint("Project JSON: $json");
    final ll = ProjectData(
      id: json["id"],
      organizationId: json["organization_id"],
      name: json["name"],
      description: json["description"],
      clientId: json["client_id"],
      clientName: json["client_name"],
      status: json["status"],
      dateCreated: json["date_created"] == null
          ? null
          : DateTime.parse(json["date_created"]),
      dateModified: json["date_modified"] == null
          ? null
          : DateTime.parse(json["date_modified"]),
      invoicecount: json["invoicecount"],
      estimatecount: json["estimatecount"],
      expensescount: json["expensescount"],
    );
    return ll;
  }
}
