import 'dart:convert';

import '../../domain/entities/invoice_marksend_entity.dart';

InvoiceMarksendMainResModel invoiceMarkAsSendMainResModelFromJson(String str) =>
    InvoiceMarksendMainResModel.fromJson(json.decode(str));

class InvoiceMarksendMainResModel extends InvoiceMarksendMainResEntity {
  InvoiceMarksendMainResModel({
    int? success,
    InvoiceMarksendDataModel? data,
  }) : super(data: data, success: success);

  factory InvoiceMarksendMainResModel.fromJson(Map<String, dynamic> json) =>
      InvoiceMarksendMainResModel(
        success: json["success"],
        data: json["data"] == null
            ? null
            : InvoiceMarksendDataModel.fromJson(json["data"]),
      );
}

class InvoiceMarksendDataModel extends InvoiceMarksendDataEntity {
  InvoiceMarksendDataModel({
    bool? success,
    String? message,
  }) : super(message: message, success: success);

  factory InvoiceMarksendDataModel.fromJson(Map<String, dynamic> json) =>
      InvoiceMarksendDataModel(
        success: json["success"],
        message: json["message"],
      );
}
