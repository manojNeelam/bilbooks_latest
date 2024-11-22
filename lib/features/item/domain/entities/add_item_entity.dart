// To parse this JSON data, do
//
//     final addItemMainResEntity = addItemMainResEntityFromJson(jsonString);

import '../../../invoice/data/models/invoice_details_model.dart';

class AddItemMainResEntity {
  int? success;
  AddItemDataEntity? data;

  AddItemMainResEntity({
    this.success,
    this.data,
  });
}

class AddItemDataEntity {
  bool? success;
  ItemEntity? item;
  String? message;

  AddItemDataEntity({
    this.success,
    this.item,
    this.message,
  });
}

class ItemEntity {
  String? id;
  String? type;
  String? name;
  String? sku;
  dynamic hsn;
  String? description;
  String? rate;
  String? unit;
  List<TaxData>? taxes;
  bool? trackInventory;
  int? stock;
  DateTime? dateCreated;
  dynamic dateModified;
  String? status;

  ItemEntity({
    this.id,
    this.type,
    this.name,
    this.sku,
    this.hsn,
    this.description,
    this.rate,
    this.unit,
    this.taxes,
    this.trackInventory,
    this.stock,
    this.dateCreated,
    this.dateModified,
    this.status,
  });
}
