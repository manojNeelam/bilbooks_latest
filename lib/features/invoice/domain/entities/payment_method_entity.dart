// To parse this JSON data, do
//
//     final paymentMethodMainResEntity = paymentMethodMainResEntityFromJson(jsonString);

import 'dart:convert';

PaymentMethodMainResEntity paymentMethodMainResEntityFromJson(String str) =>
    PaymentMethodMainResEntity.fromJson(json.decode(str));

String paymentMethodMainResEntityToJson(PaymentMethodMainResEntity data) =>
    json.encode(data.toJson());

class PaymentMethodMainResEntity {
  List<PaymentMethodEntity>? list;

  PaymentMethodMainResEntity({
    this.list,
  });

  factory PaymentMethodMainResEntity.fromJson(Map<String, dynamic> json) =>
      PaymentMethodMainResEntity(
        list: json["list"] == null
            ? []
            : List<PaymentMethodEntity>.from(
                json["list"]!.map((x) => PaymentMethodEntity.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "list": list == null
            ? []
            : List<dynamic>.from(list!.map((x) => x.toJson())),
      };
}

class PaymentMethodEntity {
  String? methodId;
  String? name;

  PaymentMethodEntity({
    this.methodId,
    this.name,
  });

  factory PaymentMethodEntity.fromJson(Map<String, dynamic> json) =>
      PaymentMethodEntity(
        methodId: json["method_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "method_id": methodId,
        "name": name,
      };
}
