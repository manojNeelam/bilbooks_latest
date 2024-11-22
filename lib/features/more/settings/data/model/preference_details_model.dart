// To parse this JSON data, do
//
//     final preferenceMainResModel = preferenceMainResModelFromJson(jsonString);

import 'dart:convert';

import 'package:billbooks_app/features/more/settings/domain/entity/preference_details_entity.dart';

PreferenceMainResModel preferenceMainResModelFromJson(String str) =>
    PreferenceMainResModel.fromJson(json.decode(str));

class PreferenceMainResModel extends PreferenceMainResEntity {
  PreferenceMainResModel({
    int? success,
    PreferenceDataModel? data,
  }) : super(data: data, success: success);

  factory PreferenceMainResModel.fromJson(Map<String, dynamic> json) =>
      PreferenceMainResModel(
        success: json["success"],
        data: json["data"] == null
            ? null
            : PreferenceDataModel.fromJson(json["data"]),
      );
}

class PreferenceDataModel extends PreferenceDataEntity {
  PreferenceDataModel({
    bool? success,
    PreferencesModel? preferences,
  }) : super(preferences: preferences, success: success);

  factory PreferenceDataModel.fromJson(Map<String, dynamic> json) =>
      PreferenceDataModel(
        success: json["success"],
        preferences: json["preferences"] == null
            ? null
            : PreferencesModel.fromJson(json["preferences"]),
      );
}

class PreferencesModel extends PreferencesEntity {
  PreferencesModel({
    String? portalName,
    String? fiscalYear,
    String? currency,
    String? language,
    String? dateFormat,
    String? numberFormat,
    String? paperSize,
    bool? attachPdf,
    String? paymentTerms,
    String? invoiceNo,
    String? invoiceHeading,
    String? invoiceTemplate,
    String? invoiceTemplateUrl,
    String? invoiceTerms,
    String? invoiceNotes,
    String? estimateNo,
    String? estimateHeading,
    String? estimateTemplate,
    String? estimateTemplateUrl,
    String? estimateTerms,
    String? estimateNotes,
    bool? billbooksBranding,
    String? themes,
    String? columnLayout,
    String? columnItemsTitle,
    String? columnUnitsTitle,
    String? columnRateTitle,
    String? columnAmountTitle,
    bool? columnDate,
    bool? columnTime,
    bool? columnCustom,
    String? columnCustomTitle,
    bool? hideColumnQty,
    bool? hideColumnRate,
    bool? hideColumnAmount,
    bool? notifiedViewedInvoicesEstimates,
    bool? notifiedApprovedDeclinedEstimates,
    bool? notifiedPayonline,
  }) : super(
            portalName: portalName,
            fiscalYear: fiscalYear,
            currency: currency,
            language: language,
            dateFormat: dateFormat,
            numberFormat: numberFormat,
            paperSize: paperSize,
            attachPdf: attachPdf,
            paymentTerms: paymentTerms,
            invoiceNo: invoiceNo,
            invoiceHeading: invoiceHeading,
            invoiceTemplate: invoiceTemplate,
            invoiceTemplateUrl: invoiceTemplateUrl,
            invoiceTerms: invoiceTerms,
            invoiceNotes: invoiceNotes,
            estimateNo: estimateNo,
            estimateHeading: estimateHeading,
            estimateTemplate: estimateTemplate,
            estimateTemplateUrl: estimateTemplateUrl,
            estimateTerms: estimateTerms,
            estimateNotes: estimateNotes,
            billbooksBranding: billbooksBranding,
            themes: themes,
            columnLayout: columnLayout,
            columnItemsTitle: columnItemsTitle,
            columnUnitsTitle: columnUnitsTitle,
            columnRateTitle: columnRateTitle,
            columnAmountTitle: columnAmountTitle,
            columnDate: columnDate,
            columnTime: columnTime,
            columnCustom: columnCustom,
            columnCustomTitle: columnCustomTitle,
            hideColumnQty: hideColumnQty,
            hideColumnRate: hideColumnRate,
            hideColumnAmount: hideColumnAmount,
            notifiedPayonline: notifiedPayonline,
            notifiedApprovedDeclinedEstimates:
                notifiedApprovedDeclinedEstimates,
            notifiedViewedInvoicesEstimates: notifiedViewedInvoicesEstimates);

  factory PreferencesModel.fromJson(Map<String, dynamic> json) =>
      PreferencesModel(
        portalName: json["portal_name"],
        fiscalYear: json["fiscal_year"],
        currency: json["currency"],
        language: json["language"],
        dateFormat: json["date_format"],
        numberFormat: json["number_format"],
        paperSize: json["paper_size"],
        attachPdf: json["attach_pdf"],
        paymentTerms: json["payment_terms"],
        invoiceNo: json["invoice_no"],
        invoiceHeading: json["invoice_heading"],
        invoiceTemplate: json["invoice_template"],
        invoiceTemplateUrl: json["invoice_template_url"],
        invoiceTerms: json["invoice_terms"],
        invoiceNotes: json["invoice_notes"],
        estimateNo: json["estimate_no"],
        estimateHeading: json["estimate_heading"],
        estimateTemplate: json["estimate_template"],
        estimateTemplateUrl: json["estimate_template_url"],
        estimateTerms: json["estimate_terms"],
        estimateNotes: json["estimate_notes"],
        billbooksBranding: json["billbooks_branding"],
        themes: json["themes"],
        columnLayout: json["column_layout"],
        columnItemsTitle: json["column_items_title"],
        columnUnitsTitle: json["column_units_title"],
        columnRateTitle: json["column_rate_title"],
        columnAmountTitle: json["column_amount_title"],
        columnDate: json["column_date"],
        columnTime: json["column_time"],
        columnCustom: json["column_custom"],
        columnCustomTitle: json["column_custom_title"],
        hideColumnQty: json["hide_column_qty"],
        hideColumnRate: json["hide_column_rate"],
        hideColumnAmount: json["hide_column_amount"],
        notifiedViewedInvoicesEstimates:
            json["notified_viewed_invoices_estimates"],
        notifiedApprovedDeclinedEstimates:
            json["notified_approved_declined_estimates"],
        notifiedPayonline: json["notified_payonline"],
      );
}
