// To parse this JSON data, do
//
//     final clientDetailsMainResModel = clientDetailsMainResModelFromJson(jsonString);

import 'dart:convert';

import 'package:billbooks_app/features/clients/data/models/client_list_model.dart';
import 'package:billbooks_app/features/clients/domain/entities/client_details_entity.dart';

ClientDetailsMainResModel clientDetailsMainResModelFromJson(String str) =>
    ClientDetailsMainResModel.fromJson(json.decode(str));

class ClientDetailsMainResModel extends ClientDetailsMainResEntity {
  ClientDetailsMainResModel({
    int? success,
    ClientDetailsDataModel? data,
  }) : super(
          data: data,
          success: success,
        );

  factory ClientDetailsMainResModel.fromJson(Map<String, dynamic> json) =>
      ClientDetailsMainResModel(
        success: json["success"],
        data: json["data"] == null
            ? null
            : ClientDetailsDataModel.fromJson(json["data"]),
      );
}

class ClientDetailsDataModel extends ClientDetailsDataEntity {
  ClientDetailsDataModel({
    bool? success,
    ClientModel? client,
    String? message,
    TotalsModel? totals,
    List<ClientInvoiceModel>? invoices,
    List<ClientEstimateModel>? estimates,
    List<ClientExpensesModel>? expenses,
    List<ClientProjectModel>? projects,
  }) : super(
            success: success,
            client: client,
            message: message,
            totals: totals,
            invoices: invoices,
            estimates: estimates,
            expenses: expenses,
            projects: projects);

  factory ClientDetailsDataModel.fromJson(Map<String, dynamic> json) =>
      ClientDetailsDataModel(
        success: json["success"],
        client: json["client"] == null
            ? null
            : ClientModel.fromJson(json["client"]),
        message: json["message"],
        totals: json["totals"] == null
            ? null
            : TotalsModel.fromJson(json["totals"]),
        invoices: json["invoices"] == null
            ? []
            : List<ClientInvoiceModel>.from(
                json["invoices"]!.map((x) => ClientInvoiceModel.fromJson(x))),
        estimates: json["estimates"] == null
            ? []
            : List<ClientEstimateModel>.from(
                json["estimates"]!.map((x) => ClientEstimateModel.fromJson(x))),
        projects: json["projects"] == null
            ? []
            : List<ClientProjectModel>.from(
                json["projects"]!.map((x) => ClientProjectModel.fromJson(x))),
        expenses: json["expenses"] == null
            ? []
            : List<ClientExpensesModel>.from(
                json["expenses"]!.map((x) => ClientExpensesModel.fromJson(x))),
      );
}

class ClientEstimateModel extends ClientEstimateEntity {
  ClientEstimateModel({String? id}) : super(id: id);
  factory ClientEstimateModel.fromJson(Map<String, dynamic> json) =>
      ClientEstimateModel(
        id: json["id"],
      );
}

class ClientInvoiceModel extends ClientInvoiceEntity {
  ClientInvoiceModel({String? id}) : super(id: id);
  factory ClientInvoiceModel.fromJson(Map<String, dynamic> json) =>
      ClientInvoiceModel(
        id: json["id"],
      );
}

class ClientExpensesModel extends ClientExpensesEntity {
  ClientExpensesModel({String? id}) : super(id: id);
  factory ClientExpensesModel.fromJson(Map<String, dynamic> json) =>
      ClientExpensesModel(
        id: json["id"],
      );
}

class ClientProjectModel extends ClientProjectEntity {
  ClientProjectModel({String? id}) : super(id: id);
  factory ClientProjectModel.fromJson(Map<String, dynamic> json) =>
      ClientProjectModel(
        id: json["id"],
      );
}

class TotalsModel extends TotalsEntity {
  TotalsModel({
    dynamic sales,
    dynamic receipts,
    dynamic expenses,
  }) : super(expenses: expenses, sales: sales, receipts: receipts);
  factory TotalsModel.fromJson(Map<String, dynamic> json) => TotalsModel(
        sales: json["sales"],
        receipts: json["receipts"],
        expenses: json["expenses"],
      );
}
