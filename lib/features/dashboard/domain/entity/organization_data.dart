import 'package:hive_flutter/hive_flutter.dart';

import 'column_settings_data.dart';
import 'plan_data.dart';
part 'organization_data.g.dart';

@HiveType(typeId: 2)
class OrganizationAuthEntity {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? countryId;
  @HiveField(3)
  String? country;
  @HiveField(4)
  String? language;
  @HiveField(5)
  String? paymentTerms;
  @HiveField(6)
  String? currency;
  @HiveField(7)
  String? currencySymbol;
  @HiveField(8)
  String? currencyCode;
  @HiveField(9)
  String? fiscalYear;
  @HiveField(10)
  String? dateFormat;
  @HiveField(11)
  String? numberFormat;
  @HiveField(12)
  String? estimateHeading;
  @HiveField(13)
  String? invoiceHeading;
  @HiveField(14)
  String? timezoneId;
  @HiveField(15)
  String? themes;
  @HiveField(16)
  String? logo;
  @HiveField(17)
  PlanEntity? plan;
  @HiveField(18)
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
