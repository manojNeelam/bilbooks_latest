import '../../../dashboard/domain/entity/authinfo_entity.dart';

class UserEntity {
  int? success;
  DataEntity? data;

  UserEntity({
    this.success,
    this.data,
  });
}

class DataEntity {
  bool? success;
  String? sessionToken;
  SessionDataEntity? sessionData;
  String? message;

  DataEntity({
    this.success,
    this.sessionToken,
    this.sessionData,
    this.message,
  });
}

// class SessionDataEntity {
//   UserClass? user;
//   Organization? organization;
//   List<Company>? companies;

//   SessionDataEntity({
//     this.user,
//     this.organization,
//     this.companies,
//   });
// }

// class CompanyEntity {
//   String? id;
//   String? name;
//   String? plan;
//   String? logo;
//   bool? selected;
//   bool? companyDefault;
//   bool? planIsexpired;
//   String? planStatus;
//   String? planDays;

//   CompanyEntity({
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
// }

// class OrganizationEntity {
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

//   OrganizationEntity({
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
// }

// class ColumnSettingsEntity {
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

//   ColumnSettingsEntity({
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
// }

// class PlanEntity {
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

//   PlanEntity({
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
// }

// class UserClassEntity {
//   String? id;
//   String? name;
//   String? firstname;
//   String? email;
//   bool? isPrimary;

//   UserClassEntity({
//     this.id,
//     this.name,
//     this.firstname,
//     this.email,
//     this.isPrimary,
//   });
// }
