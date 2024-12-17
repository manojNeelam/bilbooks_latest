// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'organization_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OrganizationAuthEntityAdapter
    extends TypeAdapter<OrganizationAuthEntity> {
  @override
  final int typeId = 2;

  @override
  OrganizationAuthEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OrganizationAuthEntity(
      id: fields[0] as String?,
      name: fields[1] as String?,
      countryId: fields[2] as String?,
      country: fields[3] as String?,
      language: fields[4] as String?,
      paymentTerms: fields[5] as String?,
      currency: fields[6] as String?,
      currencySymbol: fields[7] as String?,
      currencyCode: fields[8] as String?,
      fiscalYear: fields[9] as String?,
      dateFormat: fields[10] as String?,
      numberFormat: fields[11] as String?,
      estimateHeading: fields[12] as String?,
      invoiceHeading: fields[13] as String?,
      timezoneId: fields[14] as String?,
      themes: fields[15] as String?,
      logo: fields[16] as String?,
      plan: fields[17] as PlanEntity?,
      columnSettings: fields[18] as ColumnSettingsEntity?,
    );
  }

  @override
  void write(BinaryWriter writer, OrganizationAuthEntity obj) {
    writer
      ..writeByte(19)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.countryId)
      ..writeByte(3)
      ..write(obj.country)
      ..writeByte(4)
      ..write(obj.language)
      ..writeByte(5)
      ..write(obj.paymentTerms)
      ..writeByte(6)
      ..write(obj.currency)
      ..writeByte(7)
      ..write(obj.currencySymbol)
      ..writeByte(8)
      ..write(obj.currencyCode)
      ..writeByte(9)
      ..write(obj.fiscalYear)
      ..writeByte(10)
      ..write(obj.dateFormat)
      ..writeByte(11)
      ..write(obj.numberFormat)
      ..writeByte(12)
      ..write(obj.estimateHeading)
      ..writeByte(13)
      ..write(obj.invoiceHeading)
      ..writeByte(14)
      ..write(obj.timezoneId)
      ..writeByte(15)
      ..write(obj.themes)
      ..writeByte(16)
      ..write(obj.logo)
      ..writeByte(17)
      ..write(obj.plan)
      ..writeByte(18)
      ..write(obj.columnSettings);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrganizationAuthEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
