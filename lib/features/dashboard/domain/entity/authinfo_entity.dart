class AuthInfoMainResEntity {
  int? success;
  AuthInfoMainDataEntity? data;

  AuthInfoMainResEntity({
    this.success,
    this.data,
  });
}

class AuthInfoMainDataEntity {
  bool? success;
  String? message;
  SessionDataEntity? sessionData;

  AuthInfoMainDataEntity({
    this.success,
    this.message,
    this.sessionData,
  });
}

class SessionDataEntity {
  UserAuthEntity? user;
  OrganizationAuthEntity? organization;
  List<CompanyEntity>? companies;

  SessionDataEntity({
    this.user,
    this.organization,
    this.companies,
  });
}

class CompanyEntity {
  String? id;
  String? name;
  String? plan;
  String? logo;
  bool? selected;
  bool? companyDefault;
  bool? planIsexpired;
  String? planStatus;
  String? planDays;

  CompanyEntity({
    this.id,
    this.name,
    this.plan,
    this.logo,
    this.selected,
    this.companyDefault,
    this.planIsexpired,
    this.planStatus,
    this.planDays,
  });
}

class OrganizationAuthEntity {
  String? id;
  String? name;
  String? countryId;
  String? country;
  String? language;
  String? paymentTerms;
  String? currency;
  String? currencySymbol;
  String? currencyCode;
  String? fiscalYear;
  String? dateFormat;
  String? numberFormat;
  String? estimateHeading;
  String? invoiceHeading;
  String? timezoneId;
  String? themes;
  String? logo;
  PlanEntity? plan;
  ColumnSettingsEntity? columnSettings;

  OrganizationAuthEntity({
    this.id,
    this.name,
    this.countryId,
    this.country,
    this.language,
    this.paymentTerms,
    this.currency,
    this.currencySymbol,
    this.currencyCode,
    this.fiscalYear,
    this.dateFormat,
    this.numberFormat,
    this.estimateHeading,
    this.invoiceHeading,
    this.timezoneId,
    this.themes,
    this.logo,
    this.plan,
    this.columnSettings,
  });
}

class ColumnSettingsEntity {
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

  ColumnSettingsEntity({
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
  });
}

class PlanEntity {
  String? id;
  String? name;
  String? frequency;
  String? startdate;
  String? enddate;
  String? amount;
  String? days;
  bool? isExpired;
  String? status;
  String? maxClients;
  String? maxItems;
  String? maxExpenses;
  String? maxUsers;
  String? maxInvoices;
  String? maxEstimates;
  String? multipleOrganization;

  PlanEntity({
    this.id,
    this.name,
    this.frequency,
    this.startdate,
    this.enddate,
    this.amount,
    this.days,
    this.isExpired,
    this.status,
    this.maxClients,
    this.maxItems,
    this.maxExpenses,
    this.maxUsers,
    this.maxInvoices,
    this.maxEstimates,
    this.multipleOrganization,
  });
}

class UserAuthEntity {
  String? id;
  String? name;
  String? firstname;
  String? email;
  bool? isPrimary;

  UserAuthEntity({
    this.id,
    this.name,
    this.firstname,
    this.email,
    this.isPrimary,
  });
}
