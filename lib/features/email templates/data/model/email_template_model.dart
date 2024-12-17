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
  }) : super(
            emailMessagePaymentreminder: emailMessagePaymentreminder,
            emailMessageSendinvoice: emailMessageSendinvoice,
            emailSubjectSendestimate: emailSubjectSendestimate,
            emailMessageSendestimate: emailMessageSendestimate,
            emailSubjectPaymentreminder: emailSubjectPaymentreminder,
            emailMessagePaymentthankyou: emailMessagePaymentthankyou,
            emailSubjectPaymentthankyou: emailSubjectPaymentthankyou,
            emailSubjectSendinvoice: emailSubjectSendinvoice);

  factory Emailtemplates.fromJson(Map<String, dynamic> json) => Emailtemplates(
        emailSubjectSendinvoice: json["email_subject_sendinvoice"],
        emailMessageSendinvoice: json["email_message_sendinvoice"],
        emailSubjectSendestimate: json["email_subject_sendestimate"],
        emailMessageSendestimate: json["email_message_sendestimate"],
        emailSubjectPaymentreminder: json["email_subject_paymentreminder"],
        emailMessagePaymentreminder: json["email_message_paymentreminder"],
        emailSubjectPaymentthankyou: json["email_subject_paymentthankyou"],
        emailMessagePaymentthankyou: json["email_message_paymentthankyou"],
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
      };
}
