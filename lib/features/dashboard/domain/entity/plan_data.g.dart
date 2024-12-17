// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plan_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlanEntityAdapter extends TypeAdapter<PlanEntity> {
  @override
  final int typeId = 5;

  @override
  PlanEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PlanEntity(
      id: fields[0] as String?,
      name: fields[1] as String?,
      frequency: fields[2] as String?,
      startdate: fields[3] as String?,
      enddate: fields[4] as String?,
      amount: fields[5] as String?,
      days: fields[6] as String?,
      isExpired: fields[7] as bool?,
      status: fields[8] as String?,
      maxClients: fields[9] as String?,
      maxItems: fields[10] as String?,
      maxExpenses: fields[11] as String?,
      maxUsers: fields[12] as String?,
      maxInvoices: fields[13] as String?,
      maxEstimates: fields[14] as String?,
      multipleOrganization: fields[15] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, PlanEntity obj) {
    writer
      ..writeByte(16)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.frequency)
      ..writeByte(3)
      ..write(obj.startdate)
      ..writeByte(4)
      ..write(obj.enddate)
      ..writeByte(5)
      ..write(obj.amount)
      ..writeByte(6)
      ..write(obj.days)
      ..writeByte(7)
      ..write(obj.isExpired)
      ..writeByte(8)
      ..write(obj.status)
      ..writeByte(9)
      ..write(obj.maxClients)
      ..writeByte(10)
      ..write(obj.maxItems)
      ..writeByte(11)
      ..write(obj.maxExpenses)
      ..writeByte(12)
      ..write(obj.maxUsers)
      ..writeByte(13)
      ..write(obj.maxInvoices)
      ..writeByte(14)
      ..write(obj.maxEstimates)
      ..writeByte(15)
      ..write(obj.multipleOrganization);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlanEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
