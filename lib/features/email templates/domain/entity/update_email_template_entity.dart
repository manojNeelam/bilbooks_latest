// To parse this JSON data, do
//
//     final updateEmailTemplateMainResponseEntity = updateEmailTemplateMainResponseEntityFromJson(jsonString);

class UpdateEmailTemplateMainResponseEntity {
  int? success;
  UpdateEmailTemplateDataEntity? data;

  UpdateEmailTemplateMainResponseEntity({
    this.success,
    this.data,
  });
}

class UpdateEmailTemplateDataEntity {
  bool? success;
  String? message;

  UpdateEmailTemplateDataEntity({
    this.success,
    this.message,
  });
}
