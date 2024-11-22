import 'dart:convert';

import 'package:billbooks_app/features/item/domain/entities/item_inactive_entity.dart';

ItemInActiveMainResModel itemInActiveMainResModelFromJson(String str) =>
    ItemInActiveMainResModel.fromJson(json.decode(str));

class ItemInActiveMainResModel extends ItemInActiveMainResEntity {
  ItemInActiveMainResModel({
    int? success,
    ItemInActiveMainDataModel? data,
  }) : super(
          data: data,
          success: success,
        );

  factory ItemInActiveMainResModel.fromJson(Map<String, dynamic> json) =>
      ItemInActiveMainResModel(
        success: json["success"],
        data: json["data"] == null
            ? null
            : ItemInActiveMainDataModel.fromJson(json["data"]),
      );
}

class ItemInActiveMainDataModel extends ItemInActiveMainDataEntity {
  ItemInActiveMainDataModel({
    bool? success,
    String? message,
  }) : super(
          success: success,
          message: message,
        );

  factory ItemInActiveMainDataModel.fromJson(Map<String, dynamic> json) =>
      ItemInActiveMainDataModel(
        success: json["success"],
        message: json["message"],
      );
}
