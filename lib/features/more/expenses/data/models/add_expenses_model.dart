// To parse this JSON data, do
//
//     final addExpensesMainResModel = addExpensesMainResModelFromJson(jsonString);

import 'dart:convert';

import '../../domain/entities/add_expenses_entity.dart';

AddExpensesMainResModel addExpensesMainResModelFromJson(String str) =>
    AddExpensesMainResModel.fromJson(json.decode(str));

class AddExpensesMainResModel extends AddExpensesMainResEntity {
  AddExpensesMainResModel({
    int? success,
    AddExpensesDataModel? data,
  }) : super(data: data, success: success);

  factory AddExpensesMainResModel.fromJson(Map<String, dynamic> json) =>
      AddExpensesMainResModel(
        success: json["success"],
        data: json["data"] == null
            ? null
            : AddExpensesDataModel.fromJson(json["data"]),
      );
}

class AddExpensesDataModel extends AddExpensesDataEntity {
  AddExpensesDataModel({
    bool? success,
    int? expenseId,
    String? message,
  }) : super(expenseId: expenseId, success: success, message: message);

  factory AddExpensesDataModel.fromJson(Map<String, dynamic> json) =>
      AddExpensesDataModel(
        success: json["success"],
        expenseId: json["expense_id"],
        message: json["message"],
      );
}
