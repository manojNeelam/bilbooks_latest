// To parse this JSON data, do
//
//     final taxDeleteMainResDataModel = taxDeleteMainResDataModelFromJson(jsonString);

import 'dart:convert';

import 'package:billbooks_app/features/taxes/domain/models/tax_delete_entity.dart';

TaxDeleteMainResModel taxDeleteMainResDataModelFromJson(String str) =>
    TaxDeleteMainResModel.fromJson(json.decode(str));

class TaxDeleteMainResModel extends TaxDeleteMainResEnity {
  TaxDeleteMainResModel({
    int? success,
    TaxDeleteDataModel? data,
  }) : super(success: success, data: data);

  factory TaxDeleteMainResModel.fromJson(Map<String, dynamic> json) =>
      TaxDeleteMainResModel(
        success: json["success"],
        data: json["data"] == null
            ? null
            : TaxDeleteDataModel.fromJson(json["data"]),
      );
}

class TaxDeleteDataModel extends TaxDeleteDataEnity {
  TaxDeleteDataModel({bool? success, String? message})
      : super(success: success, message: message);

  factory TaxDeleteDataModel.fromJson(Map<String, dynamic> json) =>
      TaxDeleteDataModel(
        success: json["success"],
        message: json["message"],
      );
}
