// To parse this JSON data, do
//
//     final paymentReminderResModel = paymentReminderResModelFromJson(jsonString);

import 'dart:convert';

PaymentReminderResModel paymentReminderResModelFromJson(String str) =>
    PaymentReminderResModel.fromJson(json.decode(str));

String paymentReminderResModelToJson(PaymentReminderResModel data) =>
    json.encode(data.toJson());

class PaymentReminderResModel {
  List<PaymentReminder>? items;

  PaymentReminderResModel({
    this.items,
  });

  factory PaymentReminderResModel.fromJson(Map<String, dynamic> json) =>
      PaymentReminderResModel(
        items: json["items"] == null
            ? []
            : List<PaymentReminder>.from(
                json["items"]!.map((x) => PaymentReminder.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "items": items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toJson())),
      };
}

class PaymentReminder {
  String? value;
  String? label;

  PaymentReminder({
    this.value,
    this.label,
  });

  factory PaymentReminder.fromJson(Map<String, dynamic> json) =>
      PaymentReminder(
        value: json["value"],
        label: json["label"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "label": label,
      };
}
