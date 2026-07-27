// To parse this JSON data, do
//
//     final followUpEstimateEmailTemplateResponseModel = followUpEstimateEmailTemplateResponseModelFromJson(jsonString);

import 'dart:convert';

import '../../domain/entity/follow_up_estimate_email_template_entity.dart';

FollowUpEstimateEmailTemplateResponseModel
    followUpEstimateEmailTemplateResponseModelFromJson(String str) =>
        FollowUpEstimateEmailTemplateResponseModel.fromJson(json.decode(str));

class FollowUpEstimateEmailTemplateResponseModel
    extends FollowUpEstimateEmailTemplateResponseEntity {
  FollowUpEstimateEmailTemplateResponseModel({
    int? success,
    FollowUpEstimateEmailTemplateDataModel? data,
  }) : super(success: success, data: data);

  factory FollowUpEstimateEmailTemplateResponseModel.fromJson(
          Map<String, dynamic> json) =>
      FollowUpEstimateEmailTemplateResponseModel(
        success: json["success"],
        data: json["data"] == null
            ? null
            : FollowUpEstimateEmailTemplateDataModel.fromJson(json["data"]),
      );
}

class FollowUpEstimateEmailTemplateDataModel
    extends FollowUpEstimateEmailTemplateDataEntity {
  FollowUpEstimateEmailTemplateDataModel({
    bool? success,
    FollowUpEstimateEmailtemplatesModel? emailtemplates,
  }) : super(
          success: success,
          emailtemplates: emailtemplates,
        );

  factory FollowUpEstimateEmailTemplateDataModel.fromJson(
          Map<String, dynamic> json) =>
      FollowUpEstimateEmailTemplateDataModel(
        success: json["success"],
        emailtemplates: json["emailtemplates"] == null
            ? null
            : FollowUpEstimateEmailtemplatesModel.fromJson(
                json["emailtemplates"]),
      );
}

class FollowUpEstimateEmailtemplatesModel
    extends FollowUpEstimateEmailtemplatesEntity {
  FollowUpEstimateEmailtemplatesModel({
    String? emailSubjectPaymentreminder,
    String? emailMessagePaymentreminder,
    String? emailSubjectFollowupestimate,
    String? emailMessageFollowupestimate,
  }) : super(
            emailMessagePaymentreminder: emailMessagePaymentreminder,
            emailMessageFollowupestimate: emailMessageFollowupestimate,
            emailSubjectPaymentreminder: emailSubjectPaymentreminder,
            emailSubjectFollowupestimate: emailSubjectFollowupestimate);

  factory FollowUpEstimateEmailtemplatesModel.fromJson(
          Map<String, dynamic> json) =>
      FollowUpEstimateEmailtemplatesModel(
        emailSubjectPaymentreminder: json["email_subject_paymentreminder"],
        emailMessagePaymentreminder: json["email_message_paymentreminder"],
        emailSubjectFollowupestimate: json["email_subject_followupestimate"],
        emailMessageFollowupestimate: json["email_message_followupestimate"],
      );
}
