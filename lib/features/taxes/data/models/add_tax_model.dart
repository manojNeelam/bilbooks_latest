// To parse this JSON data, do
//
//     final taxAddMainResModel = taxAddMainResModelFromJson(jsonString);

import 'dart:convert';

import 'package:billbooks_app/features/invoice/data/models/invoice_details_model.dart';
import 'package:billbooks_app/features/taxes/domain/models/add_tax_entity.dart';

TaxAddMainResModel taxAddMainResModelFromJson(String str) =>
    TaxAddMainResModel.fromJson(json.decode(str));

class TaxAddMainResModel extends TaxAddMainResEntity {
  TaxAddMainResModel({int? success, TaxResDataModel? data})
      : super(success: success, data: data);

  factory TaxAddMainResModel.fromJson(Map<String, dynamic> json) =>
      TaxAddMainResModel(
        success: json["success"],
        data: json["data"] == null
            ? null
            : TaxResDataModel.fromJson(json["data"]),
      );
}

class TaxResDataModel extends TaxResDataEntity {
  TaxResDataModel({
    bool? success,
    TaxData? tax,
    String? message,
  }) : super(success: success, tax: tax, message: message);

  factory TaxResDataModel.fromJson(Map<String, dynamic> json) =>
      TaxResDataModel(
        success: json["success"],
        tax: json["tax"] == null ? null : TaxData.fromJson(json["tax"]),
        message: json["message"],
      );
}
