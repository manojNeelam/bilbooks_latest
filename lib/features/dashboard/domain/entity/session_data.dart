import 'package:billbooks_app/features/dashboard/domain/entity/authinfo_entity.dart';
import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';

import 'company_data.dart';
import 'organization_data.dart';
import 'user_auth_data.dart';
part 'session_data.g.dart';

@HiveType(typeId: 0)
class SessionDataEntity {
  @HiveField(0)
  UserAuthEntity? user;
  @HiveField(1)
  OrganizationAuthEntity? organization;
  @HiveField(2)
  List<CompanyEntity>? companies;

  SessionDataEntity({
    this.user,
    this.organization,
    this.companies,
  });
}
