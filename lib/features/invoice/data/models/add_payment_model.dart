// To parse this JSON data, do
//
//     final addPaymentMethodMainResModel = addPaymentMethodMainResModelFromJson(jsonString);

import 'dart:convert';

import 'package:billbooks_app/features/invoice/domain/entities/add_payment_entity.dart';

AddPaymentMethodMainResModel addPaymentMethodMainResModelFromJson(String str) =>
    AddPaymentMethodMainResModel.fromJson(json.decode(str));

class AddPaymentMethodMainResModel extends AddPaymentMethodMainResEntity {
  AddPaymentMethodMainResModel({
    int? success,
    AddPaymentMethodDataModel? data,
  }) : super(data: data, success: success);

  factory AddPaymentMethodMainResModel.fromJson(Map<String, dynamic> json) =>
      AddPaymentMethodMainResModel(
        success: json["success"],
        data: json["data"] == null
            ? null
            : AddPaymentMethodDataModel.fromJson(json["data"]),
      );
}

class AddPaymentMethodDataModel extends AddPaymentMethodDataEntity {
  AddPaymentMethodDataModel({
    bool? success,
    int? paymentId,
    dynamic balance,
    String? message,
  }) : super(
          balance: balance,
          paymentId: paymentId,
          message: message,
          success: success,
        );

  factory AddPaymentMethodDataModel.fromJson(Map<String, dynamic> json) =>
      AddPaymentMethodDataModel(
        success: json["success"],
        paymentId: json["payment_id"],
        balance: json["balance"],
        message: json["message"],
      );
}
