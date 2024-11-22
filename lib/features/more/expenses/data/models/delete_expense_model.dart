// To parse this JSON data, do
//
//     final deleteExpensesMainResModel = deleteExpensesMainResModelFromJson(jsonString);

import 'dart:convert';

import '../../domain/entities/delete_expense_entity.dart';

DeleteExpensesMainResModel deleteExpensesMainResModelFromJson(String str) =>
    DeleteExpensesMainResModel.fromJson(json.decode(str));

class DeleteExpensesMainResModel extends DeleteExpensesMainResEntity {
  DeleteExpensesMainResModel({int? success, DeleteExpensesDataModel? data})
      : super(success: success, data: data);

  factory DeleteExpensesMainResModel.fromJson(Map<String, dynamic> json) =>
      DeleteExpensesMainResModel(
        success: json["success"],
        data: json["data"] == null
            ? null
            : DeleteExpensesDataModel.fromJson(json["data"]),
      );
}

class DeleteExpensesDataModel extends DeleteExpensesDataEntity {
  DeleteExpensesDataModel({bool? success, String? message})
      : super(message: message, success: success);

  factory DeleteExpensesDataModel.fromJson(Map<String, dynamic> json) =>
      DeleteExpensesDataModel(
        success: json["success"],
        message: json["message"],
      );
}
