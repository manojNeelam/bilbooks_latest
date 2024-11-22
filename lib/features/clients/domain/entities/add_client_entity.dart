import 'client_list_entity.dart';

class ClientAddMainResEntity {
  int? success;
  ClientAddDataEntity? data;

  ClientAddMainResEntity({
    this.success,
    this.data,
  });
}

class ClientAddDataEntity {
  bool? success;
  ClientEntity? client;
  String? message;

  ClientAddDataEntity({
    this.success,
    this.client,
    this.message,
  });
}
