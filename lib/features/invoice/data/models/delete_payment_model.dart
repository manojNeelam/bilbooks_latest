// To parse this JSON data, do
//
//     final deletePaymentMethodMainResModel = deletePaymentMethodMainResModelFromJson(jsonString);

import 'dart:convert';

import 'package:billbooks_app/features/invoice/domain/entities/delete_payment_entity.dart';

DeletePaymentMethodMainResModel deletePaymentMethodMainResModelFromJson(
        String str) =>
    DeletePaymentMethodMainResModel.fromJson(json.decode(str));

class DeletePaymentMethodMainResModel extends DeletePaymentMethodMainResEntity {
  DeletePaymentMethodMainResModel({
    int? success,
    DeletePaymentMethodDataModel? data,
  }) : super(
          data: data,
          success: success,
        );

  factory DeletePaymentMethodMainResModel.fromJson(Map<String, dynamic> json) =>
      DeletePaymentMethodMainResModel(
        success: json["success"],
        data: json["data"] == null
            ? null
            : DeletePaymentMethodDataModel.fromJson(json["data"]),
      );
}

class DeletePaymentMethodDataModel extends DeletePaymentMethodDataEntity {
  DeletePaymentMethodDataModel({
    bool? success,
    dynamic balance,
    String? message,
  }) : super(
          balance: balance,
          message: message,
          success: success,
        );

  factory DeletePaymentMethodDataModel.fromJson(Map<String, dynamic> json) =>
      DeletePaymentMethodDataModel(
        success: json["success"],
        balance: json["balance"],
        message: json["message"],
      );
}
