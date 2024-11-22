import 'client_list_entity.dart';

class ClientDetailsMainResEntity {
  int? success;
  ClientDetailsDataEntity? data;

  ClientDetailsMainResEntity({
    this.success,
    this.data,
  });
}

class ClientDetailsDataEntity {
  bool? success;
  ClientEntity? client;
  String? message;

  ClientDetailsDataEntity({
    this.success,
    this.client,
    this.message,
  });
}
