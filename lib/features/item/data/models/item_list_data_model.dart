// To parse this JSON data, do
//
//     final itemsResponseDataModel = itemsResponseDataModelFromJson(jsonString);

import 'dart:convert';

import 'package:billbooks_app/features/clients/data/models/client_list_model.dart';
import 'package:billbooks_app/features/clients/domain/entities/client_list_entity.dart';
import 'package:billbooks_app/features/invoice/data/models/invoice_details_model.dart';
import 'package:billbooks_app/features/item/domain/entities/item_list_entity.dart';
import 'package:flutter/material.dart';

ItemsResponseDataModel itemsResponseDataModelFromJson(String str) =>
    ItemsResponseDataModel.fromJson(json.decode(str));

// String itemsResponseDataModelToJson(ItemsResponseDataModel data) =>
//     json.encode(data.toJson());

class ItemsResponseDataModel extends ItemsResponseEntity {
  ItemsResponseDataModel({int? success, ItemResDataModel? data})
      : super(success: success, data: data);

  factory ItemsResponseDataModel.fromJson(Map<String, dynamic> json) =>
      ItemsResponseDataModel(
        success: json["success"],
        data: json["data"] == null
            ? null
            : ItemResDataModel.fromJson(json["data"]),
      );

  // Map<String, dynamic> toJson() => {
  //       "success": success,
  //       "data": data?.toJson(),
  //     };
}

class ItemResDataModel extends ItemResDataEntity {
  ItemResDataModel({
    bool? success,
    List<StatusCountDataModel>? statusCount,
    Paging? paging,
    List<ItemDataModel>? items,
    String? message,
  }) : super(
            success: success,
            statusCount: statusCount,
            paging: paging,
            items: items,
            message: message);

  factory ItemResDataModel.fromJson(Map<String, dynamic> json) =>
      ItemResDataModel(
        success: json["success"],
        statusCount: json["status_count"] == null
            ? []
            : List<StatusCountDataModel>.from(json["status_count"]!
                .map((x) => StatusCountDataModel.fromJson(x))),
        paging: json["paging"] == null
            ? null
            : PagingModel.fromJson(json["paging"]),
        items: json["items"] == null
            ? []
            : List<ItemDataModel>.from(
                json["items"]!.map((x) => ItemDataModel.fromJson(x))),
        message: json["message"],
      );

  // Map<String, dynamic> toJson() => {
  //       "success": success,
  //       "status_count": statusCount == null
  //           ? []
  //           : List<dynamic>.from(statusCount!.map((x) => x.toJson())),
  //       "paging": paging?.toJson(),
  //       "items": items == null
  //           ? []
  //           : List<dynamic>.from(items!.map((x) => x.toJson())),
  //       "message": message,
  //     };
}

/*
 "type": "goods",
                    "item_id": "20706",
                    "item_name": "Connectwise",
                    "description": "rdty",
                    "date": "2024-04-12",
                    "time": "",
                    "custom": "",
                    "qty": 76,
                    "unit": "76",
                    "rate": "87.00",
                    "discount_type": "0",
                    "discount_value": "0.00",
                    "amount": "6612.00",
                    "is_taxable": true,
                    "taxes": [
                        {
                            "id": "749",
                            "name": "GST",
                            "rate": 50
                        }
                    ]
*/
class ItemDataModel extends ItemListEntity {
  ItemDataModel({
    String? id,
    String? type,
    String? name,
    String? sku,
    String? hsn,
    String? description,
    String? rate,
    String? unit,
    List<TaxData>? taxes,
    bool? trackInventory,
    int? stock,
    DateTime? dateCreated,
    DateTime? dateModified,
    String? status,
    String? formatedRate,
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
          status: status,
          formatedRate: formatedRate,
        );

  factory ItemDataModel.fromJson(Map<String, dynamic> json) {
    debugPrint("ItemDataModel JSON: $json");
    return ItemDataModel(
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
          : List<TaxData>.from(json["taxes"]!.map((x) => TaxData.fromJson(x))),
      trackInventory: json["track_inventory"],
      stock: json["stock"],
      dateCreated: json["date_created"] == null
          ? null
          : DateTime.parse(json["date_created"]),
      dateModified: json["date_modified"] == null
          ? null
          : DateTime.parse(json["date_modified"]),
      status: json["status"],
      formatedRate: json["formated_rate"],
    );
  }

  // Map<String, dynamic> toJson() => {
  //       "id": id,
  //       "type": type,
  //       "name": name,
  //       "sku": sku,
  //       "hsn": hsn,
  //       "description": description,
  //       "rate": rate,
  //       "unit": unit,
  //       "taxes": taxes == null
  //           ? []
  //           : List<dynamic>.from(taxes!.map((x) => x.toJson())),
  //       "track_inventory": trackInventory,
  //       "stock": stock,
  //       "date_created": dateCreated?.toIso8601String(),
  //       "date_modified": dateModified?.toIso8601String(),
  //       "status": status,
  //     };
}

class StatusCountDataModel extends StatusCountEntity {
  StatusCountDataModel({
    String? allcount,
    String? active,
    String? inactive,
    String? service,
  }) : super(
            allcount: allcount,
            active: active,
            inactive: inactive,
            service: service);

  factory StatusCountDataModel.fromJson(Map<String, dynamic> json) =>
      StatusCountDataModel(
        allcount: json["allcount"],
        active: json["active"],
        inactive: json["inactive"],
        service: json["service"],
      );

  Map<String, dynamic> toJson() => {
        "allcount": allcount,
        "active": active,
        "inactive": inactive,
        "service": service,
      };
}
