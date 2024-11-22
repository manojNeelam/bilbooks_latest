import 'package:billbooks_app/features/more/settings/data/model/organization_details_model.dart';
import 'package:billbooks_app/features/more/settings/data/model/preference_details_model.dart';
import 'package:billbooks_app/features/more/settings/data/model/preference_update_model.dart';
import 'package:billbooks_app/features/more/settings/domain/usecase/organization_list_usecase.dart';
import 'package:billbooks_app/features/more/settings/domain/usecase/preference_details_usecase.dart';
import 'package:billbooks_app/features/more/settings/domain/usecase/preference_update_usecase.dart';
import 'package:billbooks_app/features/more/settings/domain/usecase/update_organization_usecase.dart';
import 'package:billbooks_app/features/more/settings/domain/usecase/update_pref_general_usecase.dart';
import 'package:billbooks_app/features/more/settings/domain/usecase/update_pref_invoice_usecase.dart';
import 'package:billbooks_app/features/more/settings/domain/usecase/update_preference_column_usecase.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../../../core/api/api_client.dart';
import '../../../../../core/api/api_endpoint_urls.dart';
import '../../../../../core/api/api_exception.dart';
import '../../domain/usecase/update_preference_estimate_usecase.dart';
import '../model/update_organization_model.dart';

abstract interface class OrganizationRemoteDatasource {
  Future<OrganizationDetailsMainResModel> getOrganizationDetails(
      OrganizationReqParams params);
  Future<UpdateOrganizationMainResModel> updateOrganizationDetails(
      UpdateOrganizationReqParams params);
  Future<PreferenceUpdateMainResModel> updatePreferenceDetails(
      PreferenceUpdateReqParams params);
  Future<PreferenceMainResModel> getPreferenceDetails(
      PreferenceDetailsReqParams params);

  //Update Preference Estimate Settings
  Future<PreferenceUpdateMainResModel> updateEstimateSettingss(
      UpdatePreferenceEstimateReqParams params);

//Update Preference Column Settings
  Future<PreferenceUpdateMainResModel> updateColumnSettingss(
      UpdatePreferenceColumnReqParams params);

  //Update Preference Column Settings
  Future<PreferenceUpdateMainResModel> updateInvoiceSettingss(
      UpdatePrefInvoiceReqParams params);

  //Update Preference Column Settings
  Future<PreferenceUpdateMainResModel> updateGeneralSettingss(
      UpdatePrefGeneralReqParams params);
}

class OrganizationRemoteDatasourceImpl implements OrganizationRemoteDatasource {
  final APIClient apiClient;
  OrganizationRemoteDatasourceImpl({required this.apiClient});

  @override
  Future<OrganizationDetailsMainResModel> getOrganizationDetails(
      OrganizationReqParams params) async {
    try {
      final response = await apiClient.getRequest(
        ApiEndPoints.organization,
      );
      debugPrint("OrganizationDetailsMainResModel ");
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200) {
        final resModel = organizationDetailsMainResModelFromJson(response.data);
        if (resModel.data?.success != true) {
          throw ApiException(
              message:
                  resModel.data?.message ?? "Request failed please try again!");
        }
        return resModel;
      } else {
        throw ApiException(
            message: 'Invalid status code : ${response.statusCode}');
      }
    } catch (e) {
      debugPrint(e.toString());
      debugPrint("OrganizationDetailsMainResModel error");
      throw ApiException(message: e.toString());
    }
  }

  @override
  Future<UpdateOrganizationMainResModel> updateOrganizationDetails(
      UpdateOrganizationReqParams params) async {
    try {
      Map<String, String> map = {
        "action": "",
        "name": params.name,
        "address": params.address,
        "city": params.city,
        "state": params.state,
        "zipcode": params.zipcode,
        "country": params.country,
        "timezone": params.timezone,
        "registration_no": params.registrationNo,
        "phone": params.phone,
        "fax": params.fax,
        "website": params.website,
        "fiscal_year": params.fiscalYear,
        "currency": params.currency,
        "language": params.language,
        "primarycontact_name": params.primarycontactName,
        "primarycontact_email": params.primarycontactEmail,
      };
      FormData formData = FormData.fromMap(map);
      final response = await apiClient.postRequest(
          path: ApiEndPoints.organization, body: formData);
      debugPrint("UpdateOrganizationMainResEntity ");
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200) {
        final resModel = updateOrganizationMainResModelFromJson(response.data);
        if (resModel.data?.success != true) {
          throw ApiException(
              message:
                  resModel.data?.message ?? "Request failed please try again!");
        }
        return resModel;
      } else {
        throw ApiException(
            message: 'Invalid status code : ${response.statusCode}');
      }
    } catch (e) {
      debugPrint(e.toString());
      debugPrint("OrganizationDetailsMainResModel error");
      throw ApiException(message: e.toString());
    }
  }

  @override
  Future<PreferenceUpdateMainResModel> updatePreferenceDetails(
      PreferenceUpdateReqParams params) async {
    try {
      Map<String, String> map = {};
      FormData formData = FormData.fromMap(map);
      final response = await apiClient.postRequest(
          path: ApiEndPoints.preferences, body: formData);
      debugPrint("PreferenceUpdateMainResModel ");
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200) {
        final resModel = preferenceUpdateMainResModelFromJson(response.data);
        if (resModel.data?.success != true) {
          throw ApiException(
              message:
                  resModel.data?.message ?? "Request failed please try again!");
        }
        return resModel;
      } else {
        throw ApiException(
            message: 'Invalid status code : ${response.statusCode}');
      }
    } catch (e) {
      debugPrint(e.toString());
      debugPrint("PreferenceUpdateMainResModel error");
      throw ApiException(message: e.toString());
    }
  }

  @override
  Future<PreferenceMainResModel> getPreferenceDetails(
      PreferenceDetailsReqParams params) async {
    try {
      final response = await apiClient.getRequest(
        ApiEndPoints.preferences,
      );
      debugPrint("PreferenceMainResModel ");
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200) {
        final resModel = preferenceMainResModelFromJson(response.data);
        if (resModel.data?.success != true) {
          throw ApiException(message: "Request failed please try again!");
        }
        return resModel;
      } else {
        throw ApiException(
            message: 'Invalid status code : ${response.statusCode}');
      }
    } catch (e) {
      debugPrint(e.toString());
      debugPrint("PreferenceMainResModel error");
      throw ApiException(message: e.toString());
    }
  }

  @override
  Future<PreferenceUpdateMainResModel> updateColumnSettingss(
      UpdatePreferenceColumnReqParams params) async {
    try {
      Map<String, dynamic> map = {
        "type": "column",
        "hide_column_amount": params.hideColumnAmount,
        "hide_column_rate": params.hideColumnRate,
        "hide_column_qty": params.hideColumnQty,
        "column_custom_title": "",
        "column_custom": params.columnCustom,
        "column_time": params.columnTime,
        "column_date": params.columnDate,
        "column_amount_other": params.columnAmountOther,
        "column_amount_title": params.columnAmountTitle,
        "column_rate_other": params.columnRateOther,
        "column_rate_title": params.columnRateTitle,
        "column_units_other": params.columnUnitsOther,
        "column_units_title": params.columnUnitsTitle,
        "column_items_other": params.columnItemsOther,
        "column_items_title": params.columnItemsTitle,
      };
      FormData formData = FormData.fromMap(map);
      final response = await apiClient.postRequest(
          path: ApiEndPoints.preferences, body: formData);
      debugPrint("PreferenceUpdateMainResModel Column");
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200) {
        final resModel = preferenceUpdateMainResModelFromJson(response.data);
        if (resModel.data?.success != true) {
          throw ApiException(
              message:
                  resModel.data?.message ?? "Request failed please try again!");
        }
        return resModel;
      } else {
        throw ApiException(
            message: 'Invalid status code : ${response.statusCode}');
      }
    } catch (e) {
      debugPrint(e.toString());
      debugPrint("PreferenceUpdateMainResModel Column error");
      throw ApiException(message: e.toString());
    }
  }

/*
estimate_heading:
estimate_no:
estimate_template:
estimate_terms:
estimate_notes:
*/
  @override
  Future<PreferenceUpdateMainResModel> updateEstimateSettingss(
      UpdatePreferenceEstimateReqParams params) async {
    try {
      Map<String, dynamic> map = {
        "type": "estimate",
        "estimate_heading": params.estimateName,
        "estimate_no": params.estimateNo,
        "estimate_template": "",
        "estimate_terms": params.estimateTerms,
        "estimate_notes": params.estimateNotes,
      };
      FormData formData = FormData.fromMap(map);
      final response = await apiClient.postRequest(
          path: ApiEndPoints.preferences, body: formData);
      debugPrint("PreferenceUpdateMainResModel Estimate");
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200) {
        final resModel = preferenceUpdateMainResModelFromJson(response.data);
        if (resModel.data?.success != true) {
          throw ApiException(
              message:
                  resModel.data?.message ?? "Request failed please try again!");
        }
        return resModel;
      } else {
        throw ApiException(
            message: 'Invalid status code : ${response.statusCode}');
      }
    } catch (e) {
      debugPrint(e.toString());
      debugPrint("PreferenceUpdateMainResModel Column error");
      throw ApiException(message: e.toString());
    }
  }

  @override
  Future<PreferenceUpdateMainResModel> updateGeneralSettingss(
      UpdatePrefGeneralReqParams params) async {
    try {
      Map<String, dynamic> map = {
        "type": "general",
        "portal_name": "my webwingz",
        "fiscal_year": params.fiscalYear,
        "currency": params.currency,
        "language": params.language,
        "date_format": params.dateFormat,
        "number_format": params.numberFormat,
        "paper_size": params.paperSize,
        "attach_pdf": params.attachPdf,
        "notified_viewed_invoices_estimates": params.notifyInvoiceViewed,
        "notified_approved_declined_estimates": params.notifyApproveDeclined,
        "notified_payonline": params.notifyPayOnline,
      };
      FormData formData = FormData.fromMap(map);
      final response = await apiClient.postRequest(
          path: ApiEndPoints.preferences, body: formData);
      debugPrint("PreferenceUpdateMainResModel general");
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200) {
        final resModel = preferenceUpdateMainResModelFromJson(response.data);
        if (resModel.data?.success != true) {
          throw ApiException(
              message:
                  resModel.data?.message ?? "Request failed please try again!");
        }
        return resModel;
      } else {
        throw ApiException(
            message: 'Invalid status code : ${response.statusCode}');
      }
    } catch (e) {
      debugPrint(e.toString());
      debugPrint("PreferenceUpdateMainResModel general error");
      throw ApiException(message: e.toString());
    }
  }

  @override
  Future<PreferenceUpdateMainResModel> updateInvoiceSettingss(
      UpdatePrefInvoiceReqParams params) async {
    try {
      Map<String, dynamic> map = {
        "type": "invoice",
        "invoice_heading": params.heading,
        "invoice_no": params.number,
        "invoice_template": params.template,
        "invoice_terms": params.terms,
        "invoice_notes": params.notes,
        "payment_terms": params.paymentTerms,
      };
      FormData formData = FormData.fromMap(map);
      final response = await apiClient.postRequest(
          path: ApiEndPoints.preferences, body: formData);
      debugPrint("PreferenceUpdateMainResModel General");
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200) {
        final resModel = preferenceUpdateMainResModelFromJson(response.data);
        if (resModel.data?.success != true) {
          throw ApiException(
              message:
                  resModel.data?.message ?? "Request failed please try again!");
        }
        return resModel;
      } else {
        throw ApiException(
            message: 'Invalid status code : ${response.statusCode}');
      }
    } catch (e) {
      debugPrint(e.toString());
      debugPrint("PreferenceUpdateMainResModel General error");
      throw ApiException(message: e.toString());
    }
  }
}
