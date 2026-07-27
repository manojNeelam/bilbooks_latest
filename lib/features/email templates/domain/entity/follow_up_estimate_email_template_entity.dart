class FollowUpEstimateEmailTemplateResponseEntity {
  int? success;
  FollowUpEstimateEmailTemplateDataEntity? data;

  FollowUpEstimateEmailTemplateResponseEntity({
    this.success,
    this.data,
  });
}

class FollowUpEstimateEmailTemplateDataEntity {
  bool? success;
  FollowUpEstimateEmailtemplatesEntity? emailtemplates;

  FollowUpEstimateEmailTemplateDataEntity({
    this.success,
    this.emailtemplates,
  });
}

class FollowUpEstimateEmailtemplatesEntity {
  String? emailSubjectPaymentreminder;
  String? emailMessagePaymentreminder;
  String? emailSubjectFollowupestimate;
  String? emailMessageFollowupestimate;

  FollowUpEstimateEmailtemplatesEntity({
    this.emailSubjectPaymentreminder,
    this.emailMessagePaymentreminder,
    this.emailSubjectFollowupestimate,
    this.emailMessageFollowupestimate,
  });
}
