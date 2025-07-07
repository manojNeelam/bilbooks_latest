// To parse this JSON data, do
//
//     final accountsReceivablesMainResModel = accountsReceivablesMainResModelFromJson(jsonString);

import 'dart:convert';

import '../../domain/entity/account_receivables_entity.dart';

AccountsReceivablesMainResModel accountsReceivablesMainResModelFromJson(
        String str) =>
    AccountsReceivablesMainResModel.fromJson(json.decode(str));

class AccountsReceivablesMainResModel extends AccountsReceivablesMainResEntity {
  AccountsReceivablesMainResModel({
    int? success,
    AccountsReceivablesDataModel? data,
  }) : super(data: data, success: success);

  factory AccountsReceivablesMainResModel.fromJson(Map<String, dynamic> json) =>
      AccountsReceivablesMainResModel(
        success: json["success"],
        data: json["data"] == null
            ? null
            : AccountsReceivablesDataModel.fromJson(json["data"]),
      );
}

class AccountsReceivablesDataModel extends AccountsReceivablesDataEntity {
  AccountsReceivablesDataModel({
    bool? success,
    List<AccountsReceivableModel>? data,
    String? message,
  }) : super(
          data: data,
          message: message,
          success: success,
        );

  factory AccountsReceivablesDataModel.fromJson(Map<String, dynamic> json) =>
      AccountsReceivablesDataModel(
        success: json["success"],
        data: json["data"] == null
            ? []
            : List<AccountsReceivableModel>.from(
                json["data"]!.map((x) => AccountsReceivableModel.fromJson(x))),
        message: json["message"],
      );
}

class AccountsReceivableModel extends AccountsReceivableEntity {
  AccountsReceivableModel(
      {String? name, String? amount, String? currency, String? formatedAmount})
      : super(
          amount: amount,
          name: name,
          currency: currency,
          formatedAmount: formatedAmount,
        );

  factory AccountsReceivableModel.fromJson(Map<String, dynamic> json) =>
      AccountsReceivableModel(
          name: json["name"],
          amount: json["amount"],
          currency: json["currency"],
          formatedAmount: json["formated_amount"]);
}
