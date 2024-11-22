// To parse this JSON data, do
//
//     final projectDeleteMainResEntity = projectDeleteMainResEntityFromJson(jsonString);

class ProjectDeleteMainResEntity {
  int? success;
  ProjectDeleteEntity? data;

  ProjectDeleteMainResEntity({
    this.success,
    this.data,
  });
}

class ProjectDeleteEntity {
  bool? success;
  String? message;

  ProjectDeleteEntity({
    this.success,
    this.message,
  });
}
