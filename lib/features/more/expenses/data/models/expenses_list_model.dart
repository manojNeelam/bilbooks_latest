// To parse this JSON data, do
//
//     final expensesListMainResModel = expensesListMainResModelFromJson(jsonString);

import 'dart:convert';

import 'package:billbooks_app/features/clients/data/models/client_list_model.dart';
import 'package:billbooks_app/features/item/data/models/item_list_data_model.dart';
import 'package:billbooks_app/features/more/expenses/domain/entities/expenses_list_entity.dart';

ExpensesListMainResModel expensesListMainResModelFromJson(String str) =>
    ExpensesListMainResModel.fromJson(json.decode(str));

class ExpensesListMainResModel extends ExpensesListMainResEntity {
  ExpensesListMainResModel({
    int? success,
    ExpensesListDataModel? data,
  }) : super(success: success, data: data);

  factory ExpensesListMainResModel.fromJson(Map<String, dynamic> json) =>
      ExpensesListMainResModel(
        success: json["success"],
        data: json["data"] == null
            ? null
            : ExpensesListDataModel.fromJson(json["data"]),
      );
}

class ExpensesListDataModel extends ExpensesListDataEntity {
  ExpensesListDataModel({
    bool? success,
    List<StatusCountDataModel>? statusCount,
    PagingModel? paging,
    List<ExpenseDataModel>? expenses,
    String? message,
  }) : super(
            success: success,
            statusCount: statusCount,
            paging: paging,
            expenses: expenses,
            message: message);

  factory ExpensesListDataModel.fromJson(Map<String, dynamic> json) =>
      ExpensesListDataModel(
        success: json["success"],
        statusCount: json["status_count"] == null
            ? []
            : List<StatusCountDataModel>.from(json["status_count"]!
                .map((x) => StatusCountDataModel.fromJson(x))),
        paging: json["paging"] == null
            ? null
            : PagingModel.fromJson(json["paging"]),
        expenses: json["expenses"] == null
            ? []
            : List<ExpenseDataModel>.from(
                json["expenses"]!.map((x) => ExpenseDataModel.fromJson(x))),
        message: json["message"],
      );
}

class ExpenseDataModel extends ExpenseEntity {
  ExpenseDataModel({
    String? id,
    String? date,
    DateTime? dateYmd,
    String? refno,
    String? categoryId,
    String? categoryName,
    String? vendor,
    String? amount,
    String? currency,
    dynamic exchangeRate,
    String? notes,
    String? clientId,
    String? clientName,
    bool? isBillable,
    bool? isInvoiced,
    String? invoiceId,
    String? projectId,
    String? projectName,
    String? receipt,
    String? status,
    String? parentId,
    String? frequency,
    String? frequencyName,
    String? howmany,
    String? lastRecurring,
    String? nextRecurring,
    String? recurringCount,
    DateTime? dateCreated,
  }) : super(
            id: id,
            date: date,
            dateYmd: dateYmd,
            refno: refno,
            categoryId: categoryId,
            categoryName: categoryName,
            vendor: vendor,
            amount: amount,
            currency: currency,
            exchangeRate: exchangeRate,
            notes: notes,
            clientId: clientId,
            clientName: clientName,
            isBillable: isBillable,
            isInvoiced: isInvoiced,
            invoiceId: invoiceId,
            projectId: projectId,
            projectName: projectName,
            receipt: receipt,
            status: status,
            parentId: parentId,
            frequency: frequency,
            frequencyName: frequencyName,
            howmany: howmany,
            lastRecurring: lastRecurring,
            nextRecurring: nextRecurring,
            recurringCount: recurringCount,
            dateCreated: dateCreated);

  factory ExpenseDataModel.fromJson(Map<String, dynamic> json) =>
      ExpenseDataModel(
        id: json["id"],
        date: json["date"],
        dateYmd:
            json["date_ymd"] == null ? null : DateTime.parse(json["date_ymd"]),
        refno: json["refno"],
        categoryId: json["category_id"],
        categoryName: json["category_name"],
        vendor: json["vendor"],
        amount: json["amount"],
        currency: json["currency"],
        exchangeRate: json["exchange_rate"],
        notes: json["notes"],
        clientId: json["client_id"],
        clientName: json["client_name"],
        isBillable: json["is_billable"],
        isInvoiced: json["is_invoiced"],
        invoiceId: json["invoice_id"],
        projectId: json["project_id"],
        projectName: json["project_name"],
        receipt: json["receipt"],
        status: json["status"],
        parentId: json["parent_id"],
        frequency: json["frequency"],
        frequencyName: json["frequency_name"],
        howmany: json["howmany"],
        lastRecurring: json["last_recurring"],
        nextRecurring: json["next_recurring"],
        recurringCount: json["recurring_count"],
        dateCreated: json["date_created"] == null
            ? null
            : DateTime.parse(json["date_created"]),
      );
}
