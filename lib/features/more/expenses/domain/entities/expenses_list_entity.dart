// To parse this JSON data, do
//
//     final expensesListMainResEntity = expensesListMainResEntityFromJson(jsonString);

import 'package:billbooks_app/core/theme/app_pallete.dart';
import 'package:billbooks_app/features/clients/domain/entities/client_list_entity.dart';
import 'package:billbooks_app/features/item/domain/entities/item_list_entity.dart';
import 'package:billbooks_app/features/more/expenses/data/models/expenses_list_model.dart';
import 'package:flutter/material.dart';

class ExpensesListMainResEntity {
  int? success;
  ExpensesListDataEntity? data;

  ExpensesListMainResEntity({
    this.success,
    this.data,
  });
}

class ExpensesListDataEntity {
  bool? success;
  List<StatusCountEntity>? statusCount;
  Paging? paging;
  List<ExpenseEntity>? expenses;
  String? message;

  ExpensesListDataEntity({
    this.success,
    this.statusCount,
    this.paging,
    this.expenses,
    this.message,
  });
}

class ExpenseEntity {
  String? id;
  String? date;
  DateTime? dateYmd;
  String? refno;
  String? categoryId;
  String? categoryName;
  String? vendor;
  String? amount;
  String? currency;
  dynamic exchangeRate;
  String? notes;
  String? clientId;
  String? clientName;
  bool? isBillable;
  bool? isInvoiced;
  String? invoiceId;
  String? projectId;
  String? projectName;
  String? receipt;
  String? status;
  String? parentId;
  String? frequency;
  String? frequencyName;
  String? howmany;
  String? lastRecurring;
  String? nextRecurring;
  String? recurringCount;
  DateTime? dateCreated;
  String? dateModified;
  String? formatedAmount;

  ExpenseEntity({
    this.id,
    this.date,
    this.dateYmd,
    this.refno,
    this.categoryId,
    this.categoryName,
    this.vendor,
    this.amount,
    this.currency,
    this.exchangeRate,
    this.notes,
    this.clientId,
    this.clientName,
    this.isBillable,
    this.isInvoiced,
    this.invoiceId,
    this.projectId,
    this.projectName,
    this.receipt,
    this.status,
    this.parentId,
    this.frequency,
    this.frequencyName,
    this.howmany,
    this.lastRecurring,
    this.nextRecurring,
    this.recurringCount,
    this.dateCreated,
    this.dateModified,
    this.formatedAmount,
  });

  Color get statusColor {
    final status = this.status ?? "";
    if (status.toLowerCase() == "recurring") {
      return AppPallete.blueColor;
    }

    return AppPallete.k666666;
  }
}
