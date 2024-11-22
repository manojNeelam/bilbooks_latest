// To parse this JSON data, do
//
//     final addProjectMainResponseEntity = addProjectMainResponseEntityFromJson(jsonString);

import 'project_list_entity.dart';

class AddProjectMainResponseEntity {
  int? success;
  AddProjectEntity? data;

  AddProjectMainResponseEntity({
    this.success,
    this.data,
  });
}

class AddProjectEntity {
  bool? success;
  ProjectEntity? project;
  String? message;

  AddProjectEntity({
    this.success,
    this.project,
    this.message,
  });
}

// class ProjectEntity {
//   String? id;
//   String? name;
//   String? description;
//   String? clientId;
//   String? clientName;
//   String? status;
//   DateTime? dateCreated;
//   dynamic dateModified;

//   ProjectEntity({
//     this.id,
//     this.name,
//     this.description,
//     this.clientId,
//     this.clientName,
//     this.status,
//     this.dateCreated,
//     this.dateModified,
//   });
// }
