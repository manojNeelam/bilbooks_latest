import 'dart:convert';
import 'package:billbooks_app/features/invoice/domain/entities/payment_list_entity.dart';
import 'invoice_details_model.dart';

PaymentListMainResModel paymentListMainResModelFromJson(String str) =>
    PaymentListMainResModel.fromJson(json.decode(str));

class PaymentListMainResModel extends PaymentListMainResEntity {
  PaymentListMainResModel({
    int? success,
    PaymentDataModel? data,
  }) : super(
          data: data,
          success: success,
        );

  factory PaymentListMainResModel.fromJson(Map<String, dynamic> json) =>
      PaymentListMainResModel(
        success: json["success"],
        data: json["data"] == null
            ? null
            : PaymentDataModel.fromJson(json["data"]),
      );
}

class PaymentDataModel extends PaymentDataEntity {
  PaymentDataModel({
    bool? success,
    List<PaymentData>? payments,
    String? balance,
    String? message,
  }) : super(
          success: success,
          payments: payments,
          balance: balance,
          message: message,
        );

  factory PaymentDataModel.fromJson(Map<String, dynamic> json) =>
      PaymentDataModel(
        success: json["success"],
        payments: json["payments"] == null
            ? []
            : List<PaymentData>.from(
                json["payments"]!.map((x) => PaymentData.fromJson(x))),
        balance: json["balance"],
        message: json["message"],
      );
}
