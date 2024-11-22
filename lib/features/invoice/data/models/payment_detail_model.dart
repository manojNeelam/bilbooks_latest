// To parse this JSON data, do
//
//     final paymentDetailMainResModel = paymentDetailMainResModelFromJson(jsonString);

import 'dart:convert';

import 'package:billbooks_app/features/invoice/data/models/invoice_details_model.dart';
import 'package:billbooks_app/features/invoice/domain/entities/payment_details_entity.dart';

PaymentDetailMainResModel paymentDetailMainResModelFromJson(String str) =>
    PaymentDetailMainResModel.fromJson(json.decode(str));

class PaymentDetailMainResModel extends PaymentDetailMainResEntity {
  PaymentDetailMainResModel({
    int? success,
    PaymentDetailDataModel? data,
  }) : super(success: success, data: data);

  factory PaymentDetailMainResModel.fromJson(Map<String, dynamic> json) =>
      PaymentDetailMainResModel(
        success: json["success"],
        data: json["data"] == null
            ? null
            : PaymentDetailDataModel.fromJson(json["data"]),
      );
}

class PaymentDetailDataModel extends PaymentDetailDataEntity {
  PaymentDetailDataModel({
    bool? success,
    PaymentData? payments,
    String? message,
  }) : super(
          message: message,
          payments: payments,
          success: success,
        );

  factory PaymentDetailDataModel.fromJson(Map<String, dynamic> json) =>
      PaymentDetailDataModel(
        success: json["success"],
        payments: json["payments"] == null
            ? null
            : PaymentData.fromJson(json["payments"]),
        message: json["message"],
      );
}
