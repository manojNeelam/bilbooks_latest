class PreferenceMainResEntity {
  int? success;
  PreferenceDataEntity? data;

  PreferenceMainResEntity({
    this.success,
    this.data,
  });
}

class PreferenceDataEntity {
  bool? success;
  PreferencesEntity? preferences;

  PreferenceDataEntity({
    this.success,
    this.preferences,
  });
}

class PreferencesEntity {
  String? portalName;
  String? fiscalYear;
  String? currency;
  String? language;
  String? dateFormat;
  String? numberFormat;
  String? paperSize;
  bool? attachPdf;
  String? paymentTerms;
  String? invoiceNo;
  String? invoiceHeading;
  String? invoiceTemplate;
  String? invoiceTemplateUrl;
  String? invoiceTerms;
  String? invoiceNotes;
  String? estimateNo;
  String? estimateHeading;
  String? estimateTemplate;
  String? estimateTemplateUrl;
  String? estimateTerms;
  String? estimateNotes;
  bool? billbooksBranding;
  String? themes;
  String? columnLayout;
  String? columnItemsTitle;
  String? columnUnitsTitle;
  String? columnRateTitle;
  String? columnAmountTitle;
  bool? columnDate;
  bool? columnTime;
  bool? columnCustom;
  String? columnCustomTitle;
  bool? hideColumnQty;
  bool? hideColumnRate;
  bool? hideColumnAmount;
  bool? notifiedViewedInvoicesEstimates;
  bool? notifiedApprovedDeclinedEstimates;
  bool? notifiedPayonline;

  PreferencesEntity({
    this.portalName,
    this.fiscalYear,
    this.currency,
    this.language,
    this.dateFormat,
    this.numberFormat,
    this.paperSize,
    this.attachPdf,
    this.paymentTerms,
    this.invoiceNo,
    this.invoiceHeading,
    this.invoiceTemplate,
    this.invoiceTemplateUrl,
    this.invoiceTerms,
    this.invoiceNotes,
    this.estimateNo,
    this.estimateHeading,
    this.estimateTemplate,
    this.estimateTemplateUrl,
    this.estimateTerms,
    this.estimateNotes,
    this.billbooksBranding,
    this.themes,
    this.columnLayout,
    this.columnItemsTitle,
    this.columnUnitsTitle,
    this.columnRateTitle,
    this.columnAmountTitle,
    this.columnDate,
    this.columnTime,
    this.columnCustom,
    this.columnCustomTitle,
    this.hideColumnQty,
    this.hideColumnRate,
    this.hideColumnAmount,
    this.notifiedViewedInvoicesEstimates,
    this.notifiedApprovedDeclinedEstimates,
    this.notifiedPayonline,
  });
}
