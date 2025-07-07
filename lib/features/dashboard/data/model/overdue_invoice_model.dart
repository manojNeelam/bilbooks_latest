// To parse this JSON data, do
//
//     final overdueInvoiceMainResModel = overdueInvoiceMainResModelFromJson(jsonString);

import 'dart:convert';

import '../../domain/entity/overdue_invoice_entity.dart';

OverdueInvoiceMainResModel overdueInvoiceMainResModelFromJson(String str) =>
    OverdueInvoiceMainResModel.fromJson(json.decode(str));

class OverdueInvoiceMainResModel extends OverdueInvoiceMainResEntity {
  OverdueInvoiceMainResModel({
    int? success,
    OverdueInvoiceMainDataModel? data,
  }) : super(
          success: success,
          data: data,
        );

  factory OverdueInvoiceMainResModel.fromJson(Map<String, dynamic> json) =>
      OverdueInvoiceMainResModel(
        success: json["success"],
        data: json["data"] == null
            ? null
            : OverdueInvoiceMainDataModel.fromJson(json["data"]),
      );
}

class OverdueInvoiceMainDataModel extends OverdueInvoiceMainDataEntity {
  OverdueInvoiceMainDataModel({
    bool? success,
    List<DashboardInvoiceModel>? invoices,
    String? message,
  }) : super(
          success: success,
          invoices: invoices,
          message: message,
        );

  factory OverdueInvoiceMainDataModel.fromJson(Map<String, dynamic> json) =>
      OverdueInvoiceMainDataModel(
        success: json["success"],
        invoices: json["invoices"] == null
            ? []
            : List<DashboardInvoiceModel>.from(json["invoices"]!
                .map((x) => DashboardInvoiceModel.fromJson(x))),
        message: json["message"],
      );
}

class DashboardInvoiceModel extends DashboardInvoiceEntity {
  DashboardInvoiceModel({
    String? id,
    String? clientName,
    String? summary,
    String? no,
    String? date,
    String? currency,
    String? dueDate,
    String? overdueDays,
    String? nettotal,
    String? paid,
    String? balance,
    String? status,
    String? overdueText,
    String? formatedBalance,
  }) : super(
          id: id,
          clientName: clientName,
          summary: summary,
          no: no,
          date: date,
          currency: currency,
          dueDate: dueDate,
          overdueDays: overdueDays,
          nettotal: nettotal,
          paid: paid,
          balance: balance,
          status: status,
          overdueText: overdueText,
          formatedBalance: formatedBalance,
        );

  factory DashboardInvoiceModel.fromJson(Map<String, dynamic> json) =>
      DashboardInvoiceModel(
        id: json["id"],
        clientName: json["client_name"],
        summary: json["summary"],
        no: json["no"],
        date: json["date"],
        currency: json["currency"],
        dueDate: json["due_date"],
        overdueDays: json["overdue_days"],
        nettotal: json["nettotal"],
        paid: json["paid"],
        balance: json["balance"],
        status: json["status"],
        overdueText: json["overdue_text"],
        formatedBalance: json["formated_balance"],
      );
}
