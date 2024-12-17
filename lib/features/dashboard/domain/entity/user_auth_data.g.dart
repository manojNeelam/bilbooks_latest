// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_auth_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAuthEntityAdapter extends TypeAdapter<UserAuthEntity> {
  @override
  final int typeId = 1;

  @override
  UserAuthEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserAuthEntity(
      id: fields[0] as String?,
      name: fields[1] as String?,
      firstname: fields[2] as String?,
      email: fields[3] as String?,
      isPrimary: fields[4] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, UserAuthEntity obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.firstname)
      ..writeByte(3)
      ..write(obj.email)
      ..writeByte(4)
      ..write(obj.isPrimary);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAuthEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
