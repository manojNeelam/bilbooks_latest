// To parse this JSON data, do
//
//     final projectMainResEntity = projectMainResEntityFromJson(jsonString);

import 'package:billbooks_app/features/item/domain/entities/item_list_entity.dart';

import '../../../clients/domain/entities/client_list_entity.dart';

class ProjectMainResEntity {
  int? success;
  ProjectListEntity? data;

  ProjectMainResEntity({
    this.success,
    this.data,
  });
}

class ProjectListEntity {
  bool? success;
  List<StatusCountEntity>? statusCount;
  Paging? paging;
  List<ProjectEntity>? projects;
  String? message;

  ProjectListEntity({
    this.success,
    this.statusCount,
    this.paging,
    this.projects,
    this.message,
  });
}

class ProjectEntity {
  String? id;
  String? organizationId;
  String? name;
  String? description;
  String? clientId;
  String? clientName;
  String? status;
  DateTime? dateCreated;
  DateTime? dateModified;
  int? invoicecount;
  int? estimatecount;
  int? expensescount;

  ProjectEntity({
    this.id,
    this.organizationId,
    this.name,
    this.description,
    this.clientId,
    this.clientName,
    this.status,
    this.dateCreated,
    this.dateModified,
    this.invoicecount,
    this.estimatecount,
    this.expensescount,
  });
}
