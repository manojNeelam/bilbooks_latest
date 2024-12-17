// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CompanyEntityAdapter extends TypeAdapter<CompanyEntity> {
  @override
  final int typeId = 3;

  @override
  CompanyEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CompanyEntity(
      id: fields[0] as String?,
      name: fields[1] as String?,
      plan: fields[2] as String?,
      logo: fields[3] as String?,
      selected: fields[4] as bool?,
      companyDefault: fields[5] as bool?,
      planIsexpired: fields[6] as bool?,
      planStatus: fields[7] as String?,
      planDays: fields[8] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CompanyEntity obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.plan)
      ..writeByte(3)
      ..write(obj.logo)
      ..writeByte(4)
      ..write(obj.selected)
      ..writeByte(5)
      ..write(obj.companyDefault)
      ..writeByte(6)
      ..write(obj.planIsexpired)
      ..writeByte(7)
      ..write(obj.planStatus)
      ..writeByte(8)
      ..write(obj.planDays);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CompanyEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
