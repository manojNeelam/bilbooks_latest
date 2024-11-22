import 'package:billbooks_app/features/project/domain/entity/project_list_entity.dart';

class ProjectDetailMainResEntity {
  int? success;
  ProjectDetailDataEntity? data;

  ProjectDetailMainResEntity({
    this.success,
    this.data,
  });
}

class ProjectDetailDataEntity {
  bool? success;
  ProjectEntity? project;
  String? message;

  ProjectDetailDataEntity({
    this.success,
    this.project,
    this.message,
  });
}
