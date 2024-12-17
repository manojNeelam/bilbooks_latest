// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'column_settings_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ColumnSettingsEntityAdapter extends TypeAdapter<ColumnSettingsEntity> {
  @override
  final int typeId = 4;

  @override
  ColumnSettingsEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ColumnSettingsEntity(
      columnItemsTitle: fields[0] as String?,
      columnUnitsTitle: fields[1] as String?,
      columnRateTitle: fields[2] as String?,
      columnAmountTitle: fields[3] as String?,
      columnDate: fields[4] as bool?,
      columnTime: fields[5] as bool?,
      columnCustom: fields[6] as bool?,
      columnCustomTitle: fields[7] as String?,
      hideColumnQty: fields[8] as bool?,
      hideColumnRate: fields[9] as bool?,
      hideColumnAmount: fields[10] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, ColumnSettingsEntity obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.columnItemsTitle)
      ..writeByte(1)
      ..write(obj.columnUnitsTitle)
      ..writeByte(2)
      ..write(obj.columnRateTitle)
      ..writeByte(3)
      ..write(obj.columnAmountTitle)
      ..writeByte(4)
      ..write(obj.columnDate)
      ..writeByte(5)
      ..write(obj.columnTime)
      ..writeByte(6)
      ..write(obj.columnCustom)
      ..writeByte(7)
      ..write(obj.columnCustomTitle)
      ..writeByte(8)
      ..write(obj.hideColumnQty)
      ..writeByte(9)
      ..write(obj.hideColumnRate)
      ..writeByte(10)
      ..write(obj.hideColumnAmount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ColumnSettingsEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
