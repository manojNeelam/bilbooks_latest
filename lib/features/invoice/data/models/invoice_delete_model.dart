// To parse this JSON data, do
//
//     final invoiceDeleteMainResModel = invoiceDeleteMainResModelFromJson(jsonString);

import 'dart:convert';

import 'package:billbooks_app/features/invoice/domain/entities/invoice_delete_entity.dart';

InvoiceDeleteMainResModel invoiceDeleteMainResModelFromJson(String str) =>
    InvoiceDeleteMainResModel.fromJson(json.decode(str));

class InvoiceDeleteMainResModel extends InvoiceDeleteMainResEntity {
  InvoiceDeleteMainResModel({
    int? success,
    InvoiceDeleteDataModel? data,
  }) : super(
          success: success,
          data: data,
        );

  factory InvoiceDeleteMainResModel.fromJson(Map<String, dynamic> json) =>
      InvoiceDeleteMainResModel(
        success: json["success"],
        data: json["data"] == null
            ? null
            : InvoiceDeleteDataModel.fromJson(json["data"]),
      );
}

class InvoiceDeleteDataModel extends InvoiceDeleteDataEntity {
  InvoiceDeleteDataModel({
    bool? success,
    String? message,
  }) : super(
          message: message,
          success: success,
        );

  factory InvoiceDeleteDataModel.fromJson(Map<String, dynamic> json) =>
      InvoiceDeleteDataModel(
        success: json["success"],
        message: json["message"],
      );
}
