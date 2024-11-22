// To parse this JSON data, do
//
//     final invoiceDetailsResponseModel = invoiceDetailsResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:billbooks_app/features/invoice/data/models/invoice_list_model.dart';
import 'package:billbooks_app/features/invoice/domain/entities/invoice_details_entity.dart';
import 'package:billbooks_app/features/invoice/domain/entities/invoice_list_entity.dart';
import 'package:billbooks_app/features/item/data/models/item_list_data_model.dart';
import 'package:billbooks_app/features/project/data/models/project_list_data.dart';
import 'package:flutter/material.dart';

import '../../../clients/data/models/client_list_model.dart';

InvoiceDetailsResponseModel invoiceDetailsResponseModelFromJson(String str) =>
    InvoiceDetailsResponseModel.fromJson(json.decode(str));

class InvoiceDetailsResponseModel extends InvoiceDetailsResponseEntity {
  InvoiceDetailsResponseModel({
    int? success,
    InvoiceDetailResData? data,
  }) : super(data: data, success: success);

  factory InvoiceDetailsResponseModel.fromJson(Map<String, dynamic> json) =>
      InvoiceDetailsResponseModel(
        success: json["success"],
        data: json["data"] == null
            ? null
            : InvoiceDetailResData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {"success": success, "data": data};
}

class InvoiceDetailResData extends InvoiceDetailResEntity {
  InvoiceDetailResData({
    bool? success,
    InvoiceModel? estimate,
    InvoiceModel? invoice,
    List<TaxData>? taxes,
    List<ClientModel>? clients,
    List<ProjectData>? projects,
    List<ItemDataModel>? items,
    List<InvoiceHistoryData>? history,
    List<PaymentData>? payments,
    String? message,
  }) : super(
          success: success,
          invoice: invoice,
          taxes: taxes,
          clients: clients,
          projects: projects,
          items: items,
          message: message,
          history: history,
          payments: payments,
          estimate: estimate,
        );

  factory InvoiceDetailResData.fromJson(Map<String, dynamic> json) =>
      InvoiceDetailResData(
        success: json["success"],
        estimate: json["estimate"] == null
            ? null
            : InvoiceModel.fromJson(json["estimate"]),
        invoice: json["invoice"] == null
            ? null
            : InvoiceModel.fromJson(json["invoice"]),
        payments: json["payments"] == null
            ? []
            : List<PaymentData>.from(
                json["payments"]!.map((x) => PaymentData.fromJson(x))),
        taxes: json["taxes"] == null
            ? []
            : List<TaxData>.from(
                json["taxes"]!.map((x) => TaxData.fromJson(x))),
        clients: json["clients"] == null
            ? []
            : List<ClientModel>.from(
                json["clients"]!.map((x) => ClientModel.fromJson(x))),
        projects: json["projects"] == null
            ? []
            : List<ProjectData>.from(
                json["projects"]!.map((x) => ProjectData.fromJson(x))),
        items: json["items"] == null
            ? []
            : List<ItemDataModel>.from(
                json["items"]!.map((x) => ItemDataModel.fromJson(x))),
        history: json["history"] == null
            ? []
            : List<InvoiceHistoryData>.from(
                json["history"]!.map((x) => InvoiceHistoryData.fromJson(x))),
        message: json["message"],
      );

  // Map<String, dynamic> toJson() => {
  //       "success": success,
  //       "invoice": (invoice as InvoiceData).toJson(),
  //       "taxes": taxes == null ? [] : List<dynamic>.from(taxes!.map((x) => x)),
  //       "clients":
  //           clients == null ? [] : List<dynamic>.from(clients!.map((x) => x)),
  //       "projects":
  //           projects == null ? [] : List<dynamic>.from(projects!.map((x) => x)),
  //       "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x)),
  //       "message": message,
  //     };
}

/*class ClientData extends ClientEntity {
  ClientData({
    String? id,
    String? name,
    String? city,
  }) : super(id: id, name: name, city: city);

  factory ClientData.fromJson(Map<String, dynamic> json) => ClientData(
        id: json["id"],
        name: json["name"],
        city: json["city"],
      );

  Map<String, dynamic> toJson() => {
        "id": clientId,
        "name": name,
        "city": city,
      };
}*/

class InvoiceTaxModel extends InvoiceTaxEntity {
  InvoiceTaxModel({
    String? id,
    String? name,
    dynamic rate,
    dynamic total,
    dynamic amount,
  }) : super(
          id: id,
          name: name,
          rate: rate,
          total: total,
          amount: amount,
        );

  factory InvoiceTaxModel.fromJson(Map<String, dynamic> json) =>
      InvoiceTaxModel(
        id: json["id"],
        name: json["name"],
        rate: json["rate"],
        total: json["total"],
        amount: json["amount"],
      );
}

class InvoiceItemModel extends InvoiceItemEntity {
  InvoiceItemModel({
    String? type,
    String? itemId,
    String? itemName,
    String? description,
    DateTime? date,
    String? time,
    String? custom,
    int? qty,
    String? unit,
    String? rate,
    String? discountType,
    String? discountValue,
    String? amount,
    bool? isTaxable,
    List<TaxData>? taxes,
  }) : super(
          type: type,
          itemId: itemId,
          itemName: itemName,
          description: description,
          date: date,
          time: time,
          custom: custom,
          qty: qty,
          unit: unit,
          rate: rate,
          discountType: discountType,
          discountValue: discountValue,
          amount: amount,
          isTaxable: isTaxable,
          taxes: taxes,
        );

  factory InvoiceItemModel.fromJson(Map<String, dynamic> json) =>
      InvoiceItemModel(
        type: json["type"],
        itemId: json["item_id"],
        itemName: json["item_name"],
        description: json["description"],
        date: json["date"] == null
            ? null
            : json["date"].isNotEmpty
                ? DateTime.parse(json["date"])
                : null,
        time: json["time"],
        custom: json["custom"],
        qty: json["qty"],
        unit: json["unit"],
        rate: json["rate"],
        discountType: json["discount_type"],
        discountValue: json["discount_value"],
        amount: json["amount"],
        isTaxable: json["is_taxable"],
        taxes: json["taxes"] == null
            ? []
            : List<TaxData>.from(
                json["taxes"]!.map((x) => TaxData.fromJson(x))),
      );
}

// class ItemTaxModel extends TaxEntity {
//   ItemTaxModel({
//     String? id,
//     String? name,
//     int? rate,
//   });

//   factory ItemTaxModel.fromJson(Map<String, dynamic> json) => ItemTaxModel(
//         id: json["id"],
//         name: json["name"],
//         rate: json["rate"],
//       );
// }

class EmailtoMystaffData extends EmailtoMystaffEntity {
  EmailtoMystaffData({
    String? id,
    String? name,
    String? email,
    bool? selected,
  }) : super(id: id, name: name, email: email, selected: selected);

  factory EmailtoMystaffData.fromJson(Map<String, dynamic> json) =>
      EmailtoMystaffData(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        selected: json["selected"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "selected": selected,
      };
}

class ItemData extends ItemEntity {
  ItemData({
    String? id,
    String? sku,
    String? name,
    String? rate,
    String? unit,
    bool? trackInventory,
    int? stock,
  }) : super(
            id: id,
            sku: sku,
            name: name,
            rate: rate,
            unit: unit,
            trackInventory: trackInventory,
            stock: stock);

  factory ItemData.fromJson(Map<String, dynamic> json) => ItemData(
        id: json["id"],
        sku: json["sku"],
        name: json["name"],
        rate: json["rate"],
        unit: json["unit"],
        trackInventory: json["track_inventory"],
        stock: json["stock"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sku": sku,
        "name": name,
        "rate": rate,
        "unit": unit,
        "track_inventory": trackInventory,
        "stock": stock,
      };
}

class TaxData extends TaxEntity {
  TaxData({
    String? id,
    String? name,
    dynamic rate,
  }) : super(id: id, name: name, rate: rate);

  factory TaxData.fromJson(Map<String, dynamic> json) {
    debugPrint("JSON: $json");
    final taxModel = TaxData(
      id: json["id"],
      name: json["name"] ?? "",
      rate: json["rate"],
    );
    return taxModel;
  }

  // Map<String, dynamic> toJson() => {
  //       "id": id,
  //       "name": name,
  //       "rate": rate,
  //     };
}

class InvoiceHistoryData extends InvoiceHistoryEntity {
  InvoiceHistoryData({
    String? date,
    String? description,
    String? createdBy,
  }) : super(date: date, description: description, createdBy: createdBy);

  factory InvoiceHistoryData.fromJson(Map<String, dynamic> json) =>
      InvoiceHistoryData(
        date: json["date"],
        description: json["description"],
        createdBy: json["created_by"],
      );
}

class PaymentData extends PaymentEntity {
  PaymentData({
    String? id,
    String? date,
    DateTime? dateYmd,
    String? amount,
    String? methodId,
    dynamic methodName,
    String? refno,
    String? notes,
  }) : super(
            id: id,
            date: date,
            dateYmd: dateYmd,
            amount: amount,
            methodId: methodId,
            methodName: methodName,
            refno: refno,
            notes: notes);

  factory PaymentData.fromJson(Map<String, dynamic> json) => PaymentData(
        id: json["id"],
        date: json["date"],
        dateYmd:
            json["date_ymd"] == null ? null : DateTime.parse(json["date_ymd"]),
        amount: json["amount"],
        methodId: json["method_id"],
        methodName: json["method_name"],
        refno: json["refno"],
        notes: json["notes"],
      );
}
