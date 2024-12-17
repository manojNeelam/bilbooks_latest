import 'package:hive_flutter/hive_flutter.dart';
part 'plan_data.g.dart';

@HiveType(typeId: 5)
class PlanEntity {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? frequency;
  @HiveField(3)
  String? startdate;
  @HiveField(4)
  String? enddate;
  @HiveField(5)
  String? amount;
  @HiveField(6)
  String? days;
  @HiveField(7)
  bool? isExpired;
  @HiveField(8)
  String? status;
  @HiveField(9)
  String? maxClients;
  @HiveField(10)
  String? maxItems;
  @HiveField(11)
  String? maxExpenses;
  @HiveField(12)
  String? maxUsers;
  @HiveField(13)
  String? maxInvoices;
  @HiveField(14)
  String? maxEstimates;
  @HiveField(15)
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
