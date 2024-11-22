import 'dart:convert';
import '../../../dashboard/data/model/authinfo_model.dart';
import '../../domain/entities/user.dart';

UserModel userFromJson(String str) => UserModel.fromJson(json.decode(str));

class UserModel extends UserEntity {
  UserModel({
    int? success,
    DataModel? data,
  }) : super(success: success, data: data);

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        success: json["success"],
        data: json["data"] == null ? null : DataModel.fromJson(json["data"]),
      );
}

class DataModel extends DataEntity {
  DataModel({
    bool? success,
    String? sessionToken,
    String? message,
    SessionDataModel? sessionData,
  }) : super(
          success: success,
          sessionToken: sessionToken,
          message: message,
          sessionData: sessionData,
        );

  factory DataModel.fromJson(Map<String, dynamic> json) => DataModel(
        success: json["success"],
        sessionToken: json["sessionToken"],
        message: json["message"],
        sessionData: json["sessionData"] == null
            ? null
            : SessionDataModel.fromJson(json["sessionData"]),
      );
}

// class SessionData extends SessionDataEntity {
//   SessionData(
//       {UserClass? user, Organization? organization, List<Company>? companies})
//       : super(user: user, organization: organization, companies: companies);

//   factory SessionData.fromJson(Map<String, dynamic> json) => SessionData(
//         user: json["user"] == null ? null : UserClass.fromJson(json["user"]),
//         organization: json["organization"] == null
//             ? null
//             : Organization.fromJson(json["organization"]),
//         companies: json["companies"] == null
//             ? []
//             : List<Company>.from(
//                 json["companies"]!.map((x) => Company.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "user": user?.toJson(),
//         "organization": organization?.toJson(),
//         "companies": companies == null
//             ? []
//             : List<dynamic>.from(companies!.map((x) => x.toJson())),
//       };
// }

// class Company {
//   String? id;
//   String? name;
//   String? plan;
//   String? logo;
//   bool? selected;
//   bool? companyDefault;
//   bool? planIsexpired;
//   String? planStatus;
//   String? planDays;

//   Company({
//     this.id,
//     this.name,
//     this.plan,
//     this.logo,
//     this.selected,
//     this.companyDefault,
//     this.planIsexpired,
//     this.planStatus,
//     this.planDays,
//   });

//   factory Company.fromJson(Map<String, dynamic> json) => Company(
//         id: json["id"],
//         name: json["name"],
//         plan: json["plan"],
//         logo: json["logo"],
//         selected: json["selected"],
//         companyDefault: json["default"],
//         planIsexpired: json["plan_isexpired"],
//         planStatus: json["plan_status"],
//         planDays: json["plan_days"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "plan": plan,
//         "logo": logo,
//         "selected": selected,
//         "default": companyDefault,
//         "plan_isexpired": planIsexpired,
//         "plan_status": planStatus,
//         "plan_days": planDays,
//       };
// }

// class Organization {
//   String? id;
//   String? name;
//   String? countryId;
//   String? country;
//   String? currencySymbol;
//   String? currencyCode;
//   String? language;
//   String? paymentTerms;
//   String? currency;
//   String? fiscalYear;
//   String? dateFormat;
//   String? numberFormat;
//   String? estimateHeading;
//   String? invoiceHeading;
//   String? timezoneId;
//   String? themes;
//   String? logo;
//   Plan? plan;
//   ColumnSettings? columnSettings;

//   Organization({
//     this.id,
//     this.name,
//     this.countryId,
//     this.country,
//     this.currencySymbol,
//     this.currencyCode,
//     this.language,
//     this.paymentTerms,
//     this.currency,
//     this.fiscalYear,
//     this.dateFormat,
//     this.numberFormat,
//     this.estimateHeading,
//     this.invoiceHeading,
//     this.timezoneId,
//     this.themes,
//     this.logo,
//     this.plan,
//     this.columnSettings,
//   });

//   factory Organization.fromJson(Map<String, dynamic> json) => Organization(
//         id: json["id"],
//         name: json["name"],
//         countryId: json["country_id"],
//         country: json["country"],
//         currencySymbol: json["currency_symbol"],
//         currencyCode: json["currency_code"],
//         language: json["language"],
//         paymentTerms: json["payment_terms"],
//         currency: json["currency"],
//         fiscalYear: json["fiscal_year"],
//         dateFormat: json["date_format"],
//         numberFormat: json["number_format"],
//         estimateHeading: json["estimate_heading"],
//         invoiceHeading: json["invoice_heading"],
//         timezoneId: json["timezone_id"],
//         themes: json["themes"],
//         logo: json["logo"],
//         plan: json["plan"] == null ? null : Plan.fromJson(json["plan"]),
//         columnSettings: json["column_settings"] == null
//             ? null
//             : ColumnSettings.fromJson(json["column_settings"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "country_id": countryId,
//         "country": country,
//         "currency_symbol": currencySymbol,
//         "currency_code": currencyCode,
//         "language": language,
//         "payment_terms": paymentTerms,
//         "currency": currency,
//         "fiscal_year": fiscalYear,
//         "date_format": dateFormat,
//         "number_format": numberFormat,
//         "estimate_heading": estimateHeading,
//         "invoice_heading": invoiceHeading,
//         "timezone_id": timezoneId,
//         "themes": themes,
//         "logo": logo,
//         "plan": plan?.toJson(),
//         "column_settings": columnSettings?.toJson(),
//       };
// }

// class ColumnSettings {
//   String? columnItemsTitle;
//   String? columnUnitsTitle;
//   String? columnRateTitle;
//   String? columnAmountTitle;
//   bool? columnDate;
//   bool? columnTime;
//   bool? columnCustom;
//   String? columnCustomTitle;
//   bool? hideColumnQty;
//   bool? hideColumnRate;
//   bool? hideColumnAmount;

//   ColumnSettings({
//     this.columnItemsTitle,
//     this.columnUnitsTitle,
//     this.columnRateTitle,
//     this.columnAmountTitle,
//     this.columnDate,
//     this.columnTime,
//     this.columnCustom,
//     this.columnCustomTitle,
//     this.hideColumnQty,
//     this.hideColumnRate,
//     this.hideColumnAmount,
//   });

//   factory ColumnSettings.fromJson(Map<String, dynamic> json) => ColumnSettings(
//         columnItemsTitle: json["column_items_title"],
//         columnUnitsTitle: json["column_units_title"],
//         columnRateTitle: json["column_rate_title"],
//         columnAmountTitle: json["column_amount_title"],
//         columnDate: json["column_date"],
//         columnTime: json["column_time"],
//         columnCustom: json["column_custom"],
//         columnCustomTitle: json["column_custom_title"],
//         hideColumnQty: json["hide_column_qty"],
//         hideColumnRate: json["hide_column_rate"],
//         hideColumnAmount: json["hide_column_amount"],
//       );

//   Map<String, dynamic> toJson() => {
//         "column_items_title": columnItemsTitle,
//         "column_units_title": columnUnitsTitle,
//         "column_rate_title": columnRateTitle,
//         "column_amount_title": columnAmountTitle,
//         "column_date": columnDate,
//         "column_time": columnTime,
//         "column_custom": columnCustom,
//         "column_custom_title": columnCustomTitle,
//         "hide_column_qty": hideColumnQty,
//         "hide_column_rate": hideColumnRate,
//         "hide_column_amount": hideColumnAmount,
//       };
// }

// class Plan {
//   String? id;
//   String? name;
//   String? frequency;
//   String? startdate;
//   String? enddate;
//   String? amount;
//   String? days;
//   bool? isExpired;
//   String? status;
//   String? maxClients;
//   String? maxItems;
//   String? maxExpenses;
//   String? maxUsers;
//   String? maxInvoices;
//   String? maxEstimates;
//   String? multipleOrganization;

//   Plan({
//     this.id,
//     this.name,
//     this.frequency,
//     this.startdate,
//     this.enddate,
//     this.amount,
//     this.days,
//     this.isExpired,
//     this.status,
//     this.maxClients,
//     this.maxItems,
//     this.maxExpenses,
//     this.maxUsers,
//     this.maxInvoices,
//     this.maxEstimates,
//     this.multipleOrganization,
//   });

//   factory Plan.fromJson(Map<String, dynamic> json) => Plan(
//         id: json["id"],
//         name: json["name"],
//         frequency: json["frequency"],
//         startdate: json["startdate"],
//         enddate: json["enddate"],
//         amount: json["amount"],
//         days: json["days"],
//         isExpired: json["is_expired"],
//         status: json["status"],
//         maxClients: json["max_clients"],
//         maxItems: json["max_items"],
//         maxExpenses: json["max_expenses"],
//         maxUsers: json["max_users"],
//         maxInvoices: json["max_invoices"],
//         maxEstimates: json["max_estimates"],
//         multipleOrganization: json["multiple_organization"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "frequency": frequency,
//         "startdate": startdate,
//         "enddate": enddate,
//         "amount": amount,
//         "days": days,
//         "is_expired": isExpired,
//         "status": status,
//         "max_clients": maxClients,
//         "max_items": maxItems,
//         "max_expenses": maxExpenses,
//         "max_users": maxUsers,
//         "max_invoices": maxInvoices,
//         "max_estimates": maxEstimates,
//         "multiple_organization": multipleOrganization,
//       };
// }

// class UserClass {
//   String? id;
//   String? name;
//   String? firstname;
//   String? email;
//   bool? isPrimary;

//   UserClass({
//     this.id,
//     this.name,
//     this.firstname,
//     this.email,
//     this.isPrimary,
//   });

//   factory UserClass.fromJson(Map<String, dynamic> json) => UserClass(
//         id: json["id"],
//         name: json["name"],
//         firstname: json["firstname"],
//         email: json["email"],
//         isPrimary: json["is_primary"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "firstname": firstname,
//         "email": email,
//         "is_primary": isPrimary,
//       };
// }
