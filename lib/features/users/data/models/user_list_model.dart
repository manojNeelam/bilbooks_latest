// To parse this JSON data, do
//
//     final usersMainResModel = usersMainResModelFromJson(jsonString);

import 'dart:convert';

import 'package:billbooks_app/features/users/domain/entities/user_list_entity.dart';
import 'package:flutter/material.dart';

UsersMainResModel usersMainResModelFromJson(String str) {
  final userMian = UsersMainResModel.fromJson(json.decode(str));
  debugPrint(userMian.data?.message ?? "NOOOO ");
  return userMian;
}

class UsersMainResModel extends UsersMainResEntity {
  UsersMainResModel({int? success, UsersDataModel? data})
      : super(success: success, data: data);

  factory UsersMainResModel.fromJson(Map<String, dynamic> json) =>
      UsersMainResModel(
        success: json["success"],
        data:
            json["data"] == null ? null : UsersDataModel.fromJson(json["data"]),
      );
}

class UsersDataModel extends UsersDataEntity {
  UsersDataModel({bool? success, String? message, List<UserModel>? users})
      : super(message: message, users: users, success: success);

  factory UsersDataModel.fromJson(Map<String, dynamic> json) {
    final res = UsersDataModel(
      success: json["success"],
      message: json["message"],
      users: json["users"] == null
          ? []
          : List<UserModel>.from(
              json["users"]!.map((x) => UserModel.fromJson(x))),
    );
    debugPrint(res.users?.length.toString());
    return res;
  }
}

class UserModel extends UserEntity {
  UserModel(
      {String? id,
      String? name,
      String? position,
      String? email,
      bool? isPrimary,
      String? status,
      String? statusText})
      : super(
            id: id,
            name: name,
            position: position,
            email: email,
            isPrimary: isPrimary,
            status: status,
            statusText: statusText);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final user = UserModel(
      id: json["id"],
      name: json["name"],
      position: json["position"],
      email: json["email"],
      isPrimary: json["is_primary"],
      status: json["status"],
      statusText: json["status_text"],
    );
    //debugPrint(json.values.toString());
    //debugPrint(user.email ?? "NO EMial");
    return user;
  }
}
