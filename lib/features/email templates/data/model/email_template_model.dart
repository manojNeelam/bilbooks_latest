// To parse this JSON data, do
//
//     final emailTemplateMainResponseModel = emailTemplateMainResponseModelFromJson(jsonString);

import 'dart:convert';

import '../../domain/entity/email_template_entity.dart';

EmailTemplateMainResponseModel emailTemplateMainResponseModelFromJson(
        String str) =>
    EmailTemplateMainResponseModel.fromJson(json.decode(str));

// String emailTemplateMainResponseModelToJson(
//         EmailTemplateMainResponseModel data) =>
//     json.encode(data.toJson());

class EmailTemplateMainResponseModel extends EmailTemplateMainResponseEntity {
  EmailTemplateMainResponseModel({
    int? success,
    EmailTemplateDataModel? data,
  }) : super(data: data, success: success);

  factory EmailTemplateMainResponseModel.fromJson(Map<String, dynamic> json) =>
      EmailTemplateMainResponseModel(
        success: json["success"],
        data: json["data"] == null
            ? null
            : EmailTemplateDataModel.fromJson(json["data"]),
      );

  // Map<String, dynamic> toJson() => {
  //       "success": success,
  //       "data": data?.toJson(),
  //     };
}

class EmailTemplateDataModel extends EmailTemplateDataEntity {
  EmailTemplateDataModel({
    bool? success,
    Emailtemplates? emailtemplates,
  }) : super(
          success: success,
          emailtemplates: emailtemplates,
        );

  factory EmailTemplateDataModel.fromJson(Map<String, dynamic> json) =>
      EmailTemplateDataModel(
        success: json["success"],
        emailtemplates: json["emailtemplates"] == null
            ? null
            : Emailtemplates.fromJson(json["emailtemplates"]),
      );

  // Map<String, dynamic> toJson() => {
  //       "success": success,
  //       "emailtemplates": emailtemplates?.toJson(),
  //     };
}

class Emailtemplates extends EmailtemplatesEntity {
  Emailtemplates({
    String? emailSubjectSendinvoice,
    String? emailMessageSendinvoice,
    String? emailSubjectSendestimate,
    String? emailMessageSendestimate,
    String? emailSubjectPaymentreminder,
    String? emailMessagePaymentreminder,
    String? emailSubjectPaymentthankyou,
    String? emailMessagePaymentthankyou,
    String? emailSubjectFollowupestimate1,
    String? emailMessageFollowupestimate1,
    String? emailSubjectFollowupestimate2,
    String? emailMessageFollowupestimate2,
    String? emailSubjectFollowupestimate3,
    String? emailMessageFollowupestimate3,
  }) : super(
            emailMessagePaymentreminder: emailMessagePaymentreminder,
            emailMessageSendinvoice: emailMessageSendinvoice,
            emailSubjectSendestimate: emailSubjectSendestimate,
            emailMessageSendestimate: emailMessageSendestimate,
            emailSubjectPaymentreminder: emailSubjectPaymentreminder,
            emailMessagePaymentthankyou: emailMessagePaymentthankyou,
            emailSubjectPaymentthankyou: emailSubjectPaymentthankyou,
            emailSubjectSendinvoice: emailSubjectSendinvoice,
            emailSubjectFollowupestimate1: emailSubjectFollowupestimate1,
            emailMessageFollowupestimate1: emailMessageFollowupestimate1,
            emailSubjectFollowupestimate2: emailSubjectFollowupestimate2,
            emailMessageFollowupestimate2: emailMessageFollowupestimate2,
            emailSubjectFollowupestimate3: emailSubjectFollowupestimate3,
            emailMessageFollowupestimate3: emailMessageFollowupestimate3);

  factory Emailtemplates.fromJson(Map<String, dynamic> json) => Emailtemplates(
        emailSubjectSendinvoice: json["email_subject_sendinvoice"],
        emailMessageSendinvoice: json["email_message_sendinvoice"],
        emailSubjectSendestimate: json["email_subject_sendestimate"],
        emailMessageSendestimate: json["email_message_sendestimate"],
        emailSubjectPaymentreminder: json["email_subject_paymentreminder"],
        emailMessagePaymentreminder: json["email_message_paymentreminder"],
        emailSubjectPaymentthankyou: json["email_subject_paymentthankyou"],
        emailMessagePaymentthankyou: json["email_message_paymentthankyou"],
        emailSubjectFollowupestimate1:
            json["email_subject_followupestimate1"] ??
                json["email_subject_follow_up_estimate1"] ??
                json["email_subject_followUpEstimate1"],
        emailMessageFollowupestimate1:
            json["email_message_followupestimate1"] ??
                json["email_message_follow_up_estimate1"] ??
                json["email_message_followUpEstimate1"],
        emailSubjectFollowupestimate2:
            json["email_subject_followupestimate2"] ??
                json["email_subject_follow_up_estimate2"] ??
                json["email_subject_followUpEstimate2"],
        emailMessageFollowupestimate2:
            json["email_message_followupestimate2"] ??
                json["email_message_follow_up_estimate2"] ??
                json["email_message_followUpEstimate2"],
        emailSubjectFollowupestimate3:
            json["email_subject_followupestimate3"] ??
                json["email_subject_follow_up_estimate3"] ??
                json["email_subject_followUpEstimate3"],
        emailMessageFollowupestimate3:
            json["email_message_followupestimate3"] ??
                json["email_message_follow_up_estimate3"] ??
                json["email_message_followUpEstimate3"],
      );

  Map<String, dynamic> toJson() => {
        "email_subject_sendinvoice": emailSubjectSendinvoice,
        "email_message_sendinvoice": emailMessageSendinvoice,
        "email_subject_sendestimate": emailSubjectSendestimate,
        "email_message_sendestimate": emailMessageSendestimate,
        "email_subject_paymentreminder": emailSubjectPaymentreminder,
        "email_message_paymentreminder": emailMessagePaymentreminder,
        "email_subject_paymentthankyou": emailSubjectPaymentthankyou,
        "email_message_paymentthankyou": emailMessagePaymentthankyou,
        "email_subject_followupestimate1": emailSubjectFollowupestimate1,
        "email_message_followupestimate1": emailMessageFollowupestimate1,
        "email_subject_followupestimate2": emailSubjectFollowupestimate2,
        "email_message_followupestimate2": emailMessageFollowupestimate2,
        "email_subject_followupestimate3": emailSubjectFollowupestimate3,
        "email_message_followupestimate3": emailMessageFollowupestimate3,
      };
}
