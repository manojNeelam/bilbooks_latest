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

  EmailtemplatesEntity({
    this.emailSubjectSendinvoice,
    this.emailMessageSendinvoice,
    this.emailSubjectSendestimate,
    this.emailMessageSendestimate,
    this.emailSubjectPaymentreminder,
    this.emailMessagePaymentreminder,
    this.emailSubjectPaymentthankyou,
    this.emailMessagePaymentthankyou,
  });
}
