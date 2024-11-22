// To parse this JSON data, do
//
//     final invoiceVoidMainResModel = invoiceVoidMainResModelFromJson(jsonString);

import 'dart:convert';

import 'package:billbooks_app/features/invoice/domain/entities/invoice_void_entity.dart';

InvoiceVoidMainResModel invoiceVoidMainResModelFromJson(String str) =>
    InvoiceVoidMainResModel.fromJson(json.decode(str));

class InvoiceVoidMainResModel extends InvoiceVoidMainResEntity {
  InvoiceVoidMainResModel({
    int? success,
    InvoiceVoidDataModel? data,
  }) : super(data: data, success: success);

  factory InvoiceVoidMainResModel.fromJson(Map<String, dynamic> json) =>
      InvoiceVoidMainResModel(
        success: json["success"],
        data: json["data"] == null
            ? null
            : InvoiceVoidDataModel.fromJson(json["data"]),
      );
}

class InvoiceVoidDataModel extends InvoiceVoidDataEntity {
  InvoiceVoidDataModel({
    bool? success,
    String? message,
  }) : super(message: message, success: success);

  factory InvoiceVoidDataModel.fromJson(Map<String, dynamic> json) =>
      InvoiceVoidDataModel(
        success: json["success"],
        message: json["message"],
      );
}
