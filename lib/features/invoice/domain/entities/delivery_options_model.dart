import 'dart:convert';

DeliveryOptionsResModel deliveryOptionsResModelFromJson(String str) =>
    DeliveryOptionsResModel.fromJson(json.decode(str));

String deliveryOptionsResModelToJson(DeliveryOptionsResModel data) =>
    json.encode(data.toJson());

class DeliveryOptionsResModel {
  List<DeliveryOption>? items;

  DeliveryOptionsResModel({
    this.items,
  });

  factory DeliveryOptionsResModel.fromJson(Map<String, dynamic> json) =>
      DeliveryOptionsResModel(
        items: json["items"] == null
            ? []
            : List<DeliveryOption>.from(
                json["items"]!.map((x) => DeliveryOption.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "items": items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toJson())),
      };
}

class DeliveryOption {
  String? value;
  String? label;

  DeliveryOption({
    this.value,
    this.label,
  });

  factory DeliveryOption.fromJson(Map<String, dynamic> json) => DeliveryOption(
        value: json["value"],
        label: json["label"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "label": label,
      };
}
