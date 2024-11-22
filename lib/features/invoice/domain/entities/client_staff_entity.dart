// To parse this JSON data, do
//
//     final clientStaffMainResEntity = clientStaffMainResEntityFromJson(jsonString);

import '../../../clients/domain/entities/client_list_entity.dart';

class ClientStaffMainResEntity {
  int? success;
  ClientStaffDataEntity? data;

  ClientStaffMainResEntity({
    this.success,
    this.data,
  });
}

class ClientStaffDataEntity {
  bool? success;
  List<PersonEntity>? staffs;
  String? message;

  ClientStaffDataEntity({
    this.success,
    this.staffs,
    this.message,
  });
}
