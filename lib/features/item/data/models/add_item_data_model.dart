// To parse this JSON data, do
//
//     final addItemMainResModel = addItemMainResModelFromJson(jsonString);

import 'dart:convert';

import 'package:billbooks_app/features/invoice/data/models/invoice_details_model.dart';
import 'package:billbooks_app/features/item/domain/entities/add_item_entity.dart';

AddItemMainResModel addItemMainResModelFromJson(String str) =>
    AddItemMainResModel.fromJson(json.decode(str));

class AddItemMainResModel extends AddItemMainResEntity {
  AddItemMainResModel({int? success, AddItemData? data})
      : super(success: success, data: data);

  factory AddItemMainResModel.fromJson(Map<String, dynamic> json) =>
      AddItemMainResModel(
        success: json["success"],
        data: json["data"] == null ? null : AddItemData.fromJson(json["data"]),
      );
}

class AddItemData extends AddItemDataEntity {
  AddItemData({bool? success, ItemData? item, String? message})
      : super(success: success, item: item, message: message);

  factory AddItemData.fromJson(Map<String, dynamic> json) => AddItemData(
        success: json["success"],
        item: json["item"] == null ? null : ItemData.fromJson(json["item"]),
        message: json["message"],
      );
}

class ItemData extends ItemEntity {
  ItemData({
    String? id,
    String? type,
    String? name,
    String? sku,
    dynamic hsn,
    String? description,
    String? rate,
    String? unit,
    List<TaxData>? taxes,
    bool? trackInventory,
    int? stock,
    DateTime? dateCreated,
    dynamic dateModified,
    String? status,
  }) : super(
            id: id,
            type: type,
            name: name,
            sku: sku,
            hsn: hsn,
            description: description,
            rate: rate,
            unit: unit,
            taxes: taxes,
            trackInventory: trackInventory,
            stock: stock,
            dateCreated: dateCreated,
            dateModified: dateModified,
            status: status);

  factory ItemData.fromJson(Map<String, dynamic> json) => ItemData(
        id: json["id"],
        type: json["type"],
        name: json["name"],
        sku: json["sku"],
        hsn: json["hsn"],
        description: json["description"],
        rate: json["rate"],
        unit: json["unit"],
        taxes: json["taxes"] == null
            ? []
            : List<TaxData>.from(
                json["taxes"]!.map((x) => TaxData.fromJson(x))),
        trackInventory: json["track_inventory"],
        stock: json["stock"],
        dateCreated: json["date_created"] == null
            ? null
            : DateTime.parse(json["date_created"]),
        dateModified: json["date_modified"],
        status: json["status"],
      );
}
