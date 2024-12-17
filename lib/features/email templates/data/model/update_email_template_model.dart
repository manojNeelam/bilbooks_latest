// To parse this JSON data, do
//
//     final updateEmailTemplateMainResponseModel = updateEmailTemplateMainResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:billbooks_app/features/email%20templates/domain/entity/update_email_template_entity.dart';

UpdateEmailTemplateMainResponseModel
    updateEmailTemplateMainResponseModelFromJson(String str) =>
        UpdateEmailTemplateMainResponseModel.fromJson(json.decode(str));

// String updateEmailTemplateMainResponseModelToJson(
//         UpdateEmailTemplateMainResponseModel data) =>
//     json.encode(data.toJson());

class UpdateEmailTemplateMainResponseModel
    extends UpdateEmailTemplateMainResponseEntity {
  UpdateEmailTemplateMainResponseModel({
    int? success,
    UpdateEmailTemplateData? data,
  }) : super(success: success, data: data);

  factory UpdateEmailTemplateMainResponseModel.fromJson(
          Map<String, dynamic> json) =>
      UpdateEmailTemplateMainResponseModel(
        success: json["success"],
        data: json["data"] == null
            ? null
            : UpdateEmailTemplateData.fromJson(json["data"]),
      );

  // Map<String, dynamic> toJson() => {
  //       "success": success,
  //       "data": data?.toJson(),
  //     };
}

class UpdateEmailTemplateData extends UpdateEmailTemplateDataEntity {
  UpdateEmailTemplateData({
    bool? success,
    String? message,
  }) : super(message: message, success: success);

  factory UpdateEmailTemplateData.fromJson(Map<String, dynamic> json) =>
      UpdateEmailTemplateData(
        success: json["success"],
        message: json["message"],
      );

  // Map<String, dynamic> toJson() => {
  //       "success": success,
  //       "emailtemplates": emailtemplates?.toJson(),
  //     };
}
