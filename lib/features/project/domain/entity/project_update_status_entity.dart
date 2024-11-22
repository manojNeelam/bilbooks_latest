// To parse this JSON data, do
//
//     final projectStatusUpdateMainResEntity = projectStatusUpdateMainResEntityFromJson(jsonString);

class ProjectStatusUpdateMainResEntity {
  int? success;
  ProjectStatusUpdateDataEntity? data;

  ProjectStatusUpdateMainResEntity({
    this.success,
    this.data,
  });
}

class ProjectStatusUpdateDataEntity {
  bool? success;
  String? message;

  ProjectStatusUpdateDataEntity({
    this.success,
    this.message,
  });
}
