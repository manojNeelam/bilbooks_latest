// To parse this JSON data, do
//
//     final usersMainResEntity = usersMainResEntityFromJson(jsonString);

class UsersMainResEntity {
  int? success;
  UsersDataEntity? data;

  UsersMainResEntity({
    this.success,
    this.data,
  });
}

class UsersDataEntity {
  bool? success;
  String? message;
  List<UserEntity>? users;

  UsersDataEntity({
    this.success,
    this.message,
    this.users,
  });
}

class UserEntity {
  String? id;
  String? name;
  String? position;
  String? email;
  bool? isPrimary;
  String? status;
  String? statusText;

  UserEntity({
    this.id,
    this.name,
    this.position,
    this.email,
    this.isPrimary,
    this.status,
    this.statusText,
  });
}
