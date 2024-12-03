// To parse this JSON data, do
//
//     final salesExpensesMainResModel = salesExpensesMainResModelFromJson(jsonString);

import 'dart:convert';

import '../../domain/entity/sales_expenses_entity.dart';

SalesExpensesMainResModel salesExpensesMainResModelFromJson(String str) =>
    SalesExpensesMainResModel.fromJson(json.decode(str));

class SalesExpensesMainResModel extends SalesExpensesMainResEntity {
  SalesExpensesMainResModel({
    int? success,
    SalesExpensesMainDataModel? data,
  }) : super(
          success: success,
          data: data,
        );

  factory SalesExpensesMainResModel.fromJson(Map<String, dynamic> json) =>
      SalesExpensesMainResModel(
        success: json["success"],
        data: json["data"] == null
            ? null
            : SalesExpensesMainDataModel.fromJson(json["data"]),
      );
}

class SalesExpensesMainDataModel extends SalesExpensesMainDataEntity {
  SalesExpensesMainDataModel({
    bool? success,
    SalesExpensesDataModel? data,
    String? message,
  }) : super(
          success: success,
          data: data,
          message: message,
        );

  factory SalesExpensesMainDataModel.fromJson(Map<String, dynamic> json) =>
      SalesExpensesMainDataModel(
        success: json["success"],
        data: json["data"] == null
            ? null
            : SalesExpensesDataModel.fromJson(json["data"]),
        message: json["message"],
      );
}

class SalesExpensesDataModel extends SalesExpensesDataEntity {
  SalesExpensesDataModel({
    List<String>? label,
    List<String>? labelAlt,
    List<String>? labelHtml,
    DashboardExpensesModel? sales,
    DashboardExpensesModel? receipts,
    DashboardExpensesModel? expenses,
    TotalsModel? totals,
  }) : super(
          label: label,
          labelAlt: labelAlt,
          labelHtml: labelHtml,
          sales: sales,
          receipts: receipts,
          expenses: expenses,
          totals: totals,
        );

  factory SalesExpensesDataModel.fromJson(Map<String, dynamic> json) =>
      SalesExpensesDataModel(
        label: json["label"] == null
            ? []
            : List<String>.from(json["label"]!.map((x) => x)),
        labelAlt: json["label-alt"] == null
            ? []
            : List<String>.from(json["label-alt"]!.map((x) => x)),
        labelHtml: json["label-html"] == null
            ? []
            : List<String>.from(json["label-html"]!.map((x) => x)),
        sales: json["sales"] == null
            ? null
            : DashboardExpensesModel.fromJson(json["sales"]),
        receipts: json["receipts"] == null
            ? null
            : DashboardExpensesModel.fromJson(json["receipts"]),
        expenses: json["expenses"] == null
            ? null
            : DashboardExpensesModel.fromJson(json["expenses"]),
        totals: json["totals"] == null
            ? null
            : TotalsModel.fromJson(json["totals"]),
      );
}

class DashboardExpensesModel extends DashboardExpensesEntity {
  DashboardExpensesModel({
    List<dynamic>? value,
    List<String>? formatValue,
  }) : super(
          value: value,
          formatValue: formatValue,
        );

  factory DashboardExpensesModel.fromJson(Map<String, dynamic> json) =>
      DashboardExpensesModel(
        value: json["value"] == null
            ? []
            : List<dynamic>.from(json["value"]!.map((x) => x)),
        formatValue: json["format_value"] == null
            ? []
            : List<String>.from(json["format_value"]!.map((x) => x)),
      );
}

class TotalsModel extends TotalsEntity {
  TotalsModel({
    dynamic sales,
    dynamic receipts,
    dynamic expenses,
    String? formattedSales,
    String? formattedReceipts,
    String? formattedExpenses,
  }) : super(
          sales: sales,
          receipts: receipts,
          expenses: expenses,
          formattedExpenses: formattedExpenses,
          formattedReceipts: formattedReceipts,
          formattedSales: formattedSales,
        );

  factory TotalsModel.fromJson(Map<String, dynamic> json) => TotalsModel(
        sales: json["sales"],
        receipts: json["receipts"],
        expenses: json["expenses"],
        formattedExpenses: json['formated_expenses'],
        formattedReceipts: json['formated_receipts'],
        formattedSales: json['formated_sales'],
      );
}
