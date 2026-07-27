// To parse this JSON data, do
//
//     final emailTemplateMainResponseEntity = emailTemplateMainResponseEntityFromJson(jsonString);

class EmailTemplateMainResponseEntity {
  int? success;
  EmailTemplateDataEntity? data;

  EmailTemplateMainResponseEntity({
    this.success,
    this.data,
  });
}

class EmailTemplateDataEntity {
  bool? success;
  EmailtemplatesEntity? emailtemplates;

  EmailTemplateDataEntity({
    this.success,
    this.emailtemplates,
  });
}

class EmailtemplatesEntity {
  String? emailSubjectSendinvoice;
  String? emailMessageSendinvoice;
  String? emailSubjectSendestimate;
  String? emailMessageSendestimate;
  String? emailSubjectPaymentreminder;
  String? emailMessagePaymentreminder;
  String? emailSubjectPaymentthankyou;
  String? emailMessagePaymentthankyou;
  String? emailSubjectFollowupestimate1;
  String? emailMessageFollowupestimate1;
  String? emailSubjectFollowupestimate2;
  String? emailMessageFollowupestimate2;
  String? emailSubjectFollowupestimate3;
  String? emailMessageFollowupestimate3;

  EmailtemplatesEntity({
    this.emailSubjectSendinvoice,
    this.emailMessageSendinvoice,
    this.emailSubjectSendestimate,
    this.emailMessageSendestimate,
    this.emailSubjectPaymentreminder,
    this.emailMessagePaymentreminder,
    this.emailSubjectPaymentthankyou,
    this.emailMessagePaymentthankyou,
    this.emailSubjectFollowupestimate1,
    this.emailMessageFollowupestimate1,
    this.emailSubjectFollowupestimate2,
    this.emailMessageFollowupestimate2,
    this.emailSubjectFollowupestimate3,
    this.emailMessageFollowupestimate3,
  });
}
