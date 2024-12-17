// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SessionDataEntityAdapter extends TypeAdapter<SessionDataEntity> {
  @override
  final int typeId = 0;

  @override
  SessionDataEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SessionDataEntity(
      user: fields[0] as UserAuthEntity?,
      organization: fields[1] as OrganizationAuthEntity?,
      companies: (fields[2] as List?)?.cast<CompanyEntity>(),
    );
  }

  @override
  void write(BinaryWriter writer, SessionDataEntity obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.user)
      ..writeByte(1)
      ..write(obj.organization)
      ..writeByte(2)
      ..write(obj.companies);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SessionDataEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
