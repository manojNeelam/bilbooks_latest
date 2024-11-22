// To parse this JSON data, do
//
//     final authInfoMainResModel = authInfoMainResModelFromJson(jsonString);

import 'dart:convert';

import '../../domain/entity/authinfo_entity.dart';

AuthInfoMainResModel authInfoMainResModelFromJson(String str) =>
    AuthInfoMainResModel.fromJson(json.decode(str));

class AuthInfoMainResModel extends AuthInfoMainResEntity {
  AuthInfoMainResModel({
    int? success,
    AuthInfoMainDataModel? data,
  }) : super(success: success, data: data);

  factory AuthInfoMainResModel.fromJson(Map<String, dynamic> json) =>
      AuthInfoMainResModel(
        success: json["success"],
        data: json["data"] == null
            ? null
            : AuthInfoMainDataModel.fromJson(json["data"]),
      );
}

class AuthInfoMainDataModel extends AuthInfoMainDataEntity {
  AuthInfoMainDataModel({
    bool? success,
    String? message,
    SessionDataModel? sessionData,
  }) : super(success: success, message: message, sessionData: sessionData);

  factory AuthInfoMainDataModel.fromJson(Map<String, dynamic> json) =>
      AuthInfoMainDataModel(
        success: json["success"],
        message: json["message"],
        sessionData: json["sessionData"] == null
            ? null
            : SessionDataModel.fromJson(json["sessionData"]),
      );
}

class SessionDataModel extends SessionDataEntity {
  SessionDataModel({
    UserAuthModel? user,
    OrganizationAuthModel? organization,
    List<CompanyModel>? companies,
  }) : super(user: user, organization: organization, companies: companies);

  factory SessionDataModel.fromJson(Map<String, dynamic> json) =>
      SessionDataModel(
        user:
            json["user"] == null ? null : UserAuthModel.fromJson(json["user"]),
        organization: json["organization"] == null
            ? null
            : OrganizationAuthModel.fromJson(json["organization"]),
        companies: json["companies"] == null
            ? []
            : List<CompanyModel>.from(
                json["companies"]!.map((x) => CompanyModel.fromJson(x))),
      );
}

class CompanyModel extends CompanyEntity {
  CompanyModel({
    String? id,
    String? name,
    String? plan,
    String? logo,
    bool? selected,
    bool? companyDefault,
    bool? planIsexpired,
    String? planStatus,
    String? planDays,
  }) : super(
            plan: plan,
            planDays: planDays,
            planIsexpired: planIsexpired,
            planStatus: planStatus,
            id: id,
            name: name,
            selected: selected,
            companyDefault: companyDefault,
            logo: logo);

  factory CompanyModel.fromJson(Map<String, dynamic> json) => CompanyModel(
        id: json["id"],
        name: json["name"],
        plan: json["plan"],
        logo: json["logo"],
        selected: json["selected"],
        companyDefault: json["default"],
        planIsexpired: json["plan_isexpired"],
        planStatus: json["plan_status"],
        planDays: json["plan_days"],
      );
}

class OrganizationAuthModel extends OrganizationAuthEntity {
  OrganizationAuthModel({
    String? id,
    String? name,
    String? countryId,
    String? country,
    String? language,
    String? paymentTerms,
    String? currency,
    String? currencySymbol,
    String? currencyCode,
    String? fiscalYear,
    String? dateFormat,
    String? numberFormat,
    String? estimateHeading,
    String? invoiceHeading,
    String? timezoneId,
    String? themes,
    String? logo,
    PlanModel? plan,
    ColumnSettingsModel? columnSettings,
  }) : super(
            columnSettings: columnSettings,
            country: country,
            countryId: countryId,
            currencyCode: currencyCode,
            currency: currency,
            currencySymbol: currencySymbol,
            logo: logo,
            language: language,
            id: id,
            timezoneId: timezoneId,
            themes: themes,
            paymentTerms: paymentTerms,
            plan: plan,
            fiscalYear: fiscalYear,
            dateFormat: dateFormat,
            name: name,
            numberFormat: numberFormat);

  factory OrganizationAuthModel.fromJson(Map<String, dynamic> json) =>
      OrganizationAuthModel(
        id: json["id"],
        name: json["name"],
        countryId: json["country_id"],
        country: json["country"],
        language: json["language"],
        paymentTerms: json["payment_terms"],
        currency: json["currency"],
        currencySymbol: json["currency_symbol"],
        currencyCode: json["currency_code"],
        fiscalYear: json["fiscal_year"],
        dateFormat: json["date_format"],
        numberFormat: json["number_format"],
        estimateHeading: json["estimate_heading"],
        invoiceHeading: json["invoice_heading"],
        timezoneId: json["timezone_id"],
        themes: json["themes"],
        logo: json["logo"],
        plan: json["plan"] == null ? null : PlanModel.fromJson(json["plan"]),
        columnSettings: json["column_settings"] == null
            ? null
            : ColumnSettingsModel.fromJson(json["column_settings"]),
      );
}

class ColumnSettingsModel extends ColumnSettingsEntity {
  ColumnSettingsModel({
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
  }) : super(
            hideColumnAmount: hideColumnAmount,
            hideColumnQty: hideColumnQty,
            hideColumnRate: hideColumnRate,
            columnAmountTitle: columnAmountTitle,
            columnCustom: columnCustom,
            columnCustomTitle: columnCustomTitle,
            columnDate: columnDate,
            columnItemsTitle: columnItemsTitle,
            columnRateTitle: columnRateTitle,
            columnTime: columnTime,
            columnUnitsTitle: columnUnitsTitle);

  factory ColumnSettingsModel.fromJson(Map<String, dynamic> json) =>
      ColumnSettingsModel(
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
      );
}

class PlanModel extends PlanEntity {
  PlanModel({
    String? id,
    String? name,
    String? frequency,
    String? startdate,
    String? enddate,
    String? amount,
    String? days,
    bool? isExpired,
    String? status,
    String? maxClients,
    String? maxItems,
    String? maxExpenses,
    String? maxUsers,
    String? maxInvoices,
    String? maxEstimates,
    String? multipleOrganization,
  }) : super(
          amount: amount,
          multipleOrganization: multipleOrganization,
          maxClients: maxClients,
          maxEstimates: maxEstimates,
          maxExpenses: maxExpenses,
          maxInvoices: maxInvoices,
          maxItems: maxItems,
          maxUsers: maxUsers,
          isExpired: isExpired,
          startdate: startdate,
          status: status,
          days: days,
          enddate: enddate,
          frequency: frequency,
          id: id,
          name: name,
        );

  factory PlanModel.fromJson(Map<String, dynamic> json) => PlanModel(
        id: json["id"],
        name: json["name"],
        frequency: json["frequency"],
        startdate: json["startdate"],
        enddate: json["enddate"],
        amount: json["amount"],
        days: json["days"],
        isExpired: json["is_expired"],
        status: json["status"],
        maxClients: json["max_clients"],
        maxItems: json["max_items"],
        maxExpenses: json["max_expenses"],
        maxUsers: json["max_users"],
        maxInvoices: json["max_invoices"],
        maxEstimates: json["max_estimates"],
        multipleOrganization: json["multiple_organization"],
      );
}

class UserAuthModel extends UserAuthEntity {
  UserAuthModel({
    String? id,
    String? name,
    String? firstname,
    String? email,
    bool? isPrimary,
  }) : super(
          id: id,
          email: email,
          name: name,
          firstname: firstname,
          isPrimary: isPrimary,
        );

  factory UserAuthModel.fromJson(Map<String, dynamic> json) => UserAuthModel(
        id: json["id"],
        name: json["name"],
        firstname: json["firstname"],
        email: json["email"],
        isPrimary: json["is_primary"],
      );
}
