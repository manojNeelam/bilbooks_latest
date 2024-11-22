// To parse this JSON data, do
//
//     final paymentTermsResModel = paymentTermsResModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/material.dart';

PaymentTermsResModel paymentTermsResModelFromJson(String str) =>
    PaymentTermsResModel.fromJson(json.decode(str));

String paymentTermsResModelToJson(PaymentTermsResModel data) =>
    json.encode(data.toJson());

class PaymentTermsResModel {
  List<PaymentTerms>? items;

  PaymentTermsResModel({
    this.items,
  });

  factory PaymentTermsResModel.fromJson(Map<String, dynamic> json) {
    debugPrint(json.toString());
    final paymentTermsResModel = PaymentTermsResModel(
      items: json["items"] == null
          ? []
          : List<PaymentTerms>.from(
              json["items"]!.map((x) => PaymentTerms.fromJson(x))),
    );
    debugPrint(paymentTermsResModel.items?.first.label.toString());
    return paymentTermsResModel;
  }

  Map<String, dynamic> toJson() => {
        "items": items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toJson())),
      };
}

class PaymentTerms {
  String? value;
  String? label;

  PaymentTerms({
    this.value,
    this.label,
  });

  factory PaymentTerms.fromJson(Map<String, dynamic> json) {
    debugPrint(json.toString());
    return PaymentTerms(
      value: json["value"],
      label: json["label"],
    );
  }

  Map<String, dynamic> toJson() => {
        "value": value,
        "label": label,
      };
}
