// To parse this JSON data, do
//
//     final itemActiveMainResModel = itemActiveMainResModelFromJson(jsonString);

import 'dart:convert';

import 'package:billbooks_app/features/item/domain/entities/item_active_entity.dart';

ItemActiveMainResModel itemActiveMainResModelFromJson(String str) =>
    ItemActiveMainResModel.fromJson(json.decode(str));

class ItemActiveMainResModel extends ItemActiveMainResEntity {
  ItemActiveMainResModel({
    int? success,
    ItemActiveMainDataModel? data,
  }) : super(
          data: data,
          success: success,
        );

  factory ItemActiveMainResModel.fromJson(Map<String, dynamic> json) =>
      ItemActiveMainResModel(
        success: json["success"],
        data: json["data"] == null
            ? null
            : ItemActiveMainDataModel.fromJson(json["data"]),
      );
}

class ItemActiveMainDataModel extends ItemActiveMainDataEntity {
  ItemActiveMainDataModel({
    bool? success,
    String? message,
  }) : super(
          success: success,
          message: message,
        );

  factory ItemActiveMainDataModel.fromJson(Map<String, dynamic> json) =>
      ItemActiveMainDataModel(
        success: json["success"],
        message: json["message"],
      );
}
