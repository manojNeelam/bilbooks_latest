// To parse this JSON data, do
//
//     final deleteItemMainResDataModel = deleteItemMainResDataModelFromJson(jsonString);

import 'dart:convert';

import 'package:billbooks_app/features/item/domain/entities/delete_item_entity.dart';

DeleteItemMainResDataModel deleteItemMainResDataModelFromJson(String str) =>
    DeleteItemMainResDataModel.fromJson(json.decode(str));

class DeleteItemMainResDataModel extends DeleteItemMainResEntity {
  DeleteItemMainResDataModel({int? success, DeleteItemDataModel? data})
      : super(success: success, data: data);

  factory DeleteItemMainResDataModel.fromJson(Map<String, dynamic> json) =>
      DeleteItemMainResDataModel(
        success: json["success"],
        data: json["data"] == null
            ? null
            : DeleteItemDataModel.fromJson(json["data"]),
      );
}

class DeleteItemDataModel extends DeleteItemDataEntity {
  DeleteItemDataModel({bool? success, String? message})
      : super(success: success, message: message);

  factory DeleteItemDataModel.fromJson(Map<String, dynamic> json) =>
      DeleteItemDataModel(
        success: json["success"],
        message: json["message"],
      );
}
