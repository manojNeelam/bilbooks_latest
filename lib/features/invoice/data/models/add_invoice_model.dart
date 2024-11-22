import 'package:billbooks_app/features/invoice/domain/entities/add_invoice_entity.dart';

import 'dart:convert';

AddInvoiceMainResModel addInvoiceMainResModelFromJson(String str) =>
    AddInvoiceMainResModel.fromJson(json.decode(str));

class AddInvoiceMainResModel extends AddInvoiceMainResEntity {
  AddInvoiceMainResModel({
    int? success,
    AddInvoiceDataModel? data,
  }) : super(success: success, data: data);

  factory AddInvoiceMainResModel.fromJson(Map<String, dynamic> json) =>
      AddInvoiceMainResModel(
        success: json["success"],
        data: json["data"] == null
            ? null
            : AddInvoiceDataModel.fromJson(json["data"]),
      );
}

class AddInvoiceDataModel extends AddInvoiceDataEntity {
  AddInvoiceDataModel({
    bool? success,
    String? message,
    int? estimateId,
  }) : super(
          message: message,
          success: success,
          estimateId: estimateId,
        );

  factory AddInvoiceDataModel.fromJson(Map<String, dynamic> json) =>
      AddInvoiceDataModel(
        success: json["success"],
        message: json["message"],
        estimateId: json["estimate_id"],
      );
}
