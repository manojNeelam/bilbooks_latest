import 'package:hive_flutter/hive_flutter.dart';
part 'column_settings_data.g.dart';

@HiveType(typeId: 4)
class ColumnSettingsEntity {
  @HiveField(0)
  String? columnItemsTitle;
  @HiveField(1)
  String? columnUnitsTitle;
  @HiveField(2)
  String? columnRateTitle;
  @HiveField(3)
  String? columnAmountTitle;
  @HiveField(4)
  bool? columnDate;
  @HiveField(5)
  bool? columnTime;
  @HiveField(6)
  bool? columnCustom;
  @HiveField(7)
  String? columnCustomTitle;
  @HiveField(8)
  bool? hideColumnQty;
  @HiveField(9)
  bool? hideColumnRate;
  @HiveField(10)
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
