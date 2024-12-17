import 'package:billbooks_app/features/dashboard/domain/entity/session_data.dart';
import 'package:hive_flutter/adapters.dart';

class AuthInfoMainResEntity {
  int? success;
  AuthInfoMainDataEntity? data;

  AuthInfoMainResEntity({
    this.success,
    this.data,
  });
}

class AuthInfoMainDataEntity {
  bool? success;
  String? message;
  SessionDataEntity? sessionData;

  AuthInfoMainDataEntity({
    this.success,
    this.message,
    this.sessionData,
  });
}
