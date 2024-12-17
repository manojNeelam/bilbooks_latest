import 'package:hive_flutter/hive_flutter.dart';
part 'user_auth_data.g.dart';

@HiveType(typeId: 1)
class UserAuthEntity {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? firstname;
  @HiveField(3)
  String? email;
  @HiveField(4)
  bool? isPrimary;

  UserAuthEntity({
    this.id,
    this.name,
    this.firstname,
    this.email,
    this.isPrimary,
  });
}
