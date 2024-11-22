// To parse this JSON data, do
//
//     final invoiceVoidMainResModel = invoiceVoidMainResModelFromJson(jsonString);

import 'dart:convert';

import 'package:billbooks_app/features/invoice/domain/entities/invoice_unvoice_entity.dart';

InvoiceUnVoidMainResModel invoiceUnVoidMainResModelFromJson(String str) =>
    InvoiceUnVoidMainResModel.fromJson(json.decode(str));

class InvoiceUnVoidMainResModel extends InvoiceUnVoidMainResEntity {
  InvoiceUnVoidMainResModel({
    int? success,
    InvoiceUnVoidDataModel? data,
  }) : super(data: data, success: success);

  factory InvoiceUnVoidMainResModel.fromJson(Map<String, dynamic> json) =>
      InvoiceUnVoidMainResModel(
        success: json["success"],
        data: json["data"] == null
            ? null
            : InvoiceUnVoidDataModel.fromJson(json["data"]),
      );
}

class InvoiceUnVoidDataModel extends InvoiceUnVoidDataEntity {
  InvoiceUnVoidDataModel({
    bool? success,
    String? message,
  }) : super(message: message, success: success);

  factory InvoiceUnVoidDataModel.fromJson(Map<String, dynamic> json) =>
      InvoiceUnVoidDataModel(
        success: json["success"],
        message: json["message"],
      );
}
