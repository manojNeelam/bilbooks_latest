import 'package:hive_flutter/hive_flutter.dart';
part 'company_data.g.dart';

@HiveType(typeId: 3)
class CompanyEntity {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? plan;
  @HiveField(3)
  String? logo;
  @HiveField(4)
  bool? selected;
  @HiveField(5)
  bool? companyDefault;
  @HiveField(6)
  bool? planIsexpired;
  @HiveField(7)
  String? planStatus;
  @HiveField(8)
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
