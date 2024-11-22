// To parse this JSON data, do
//
//     final repeatEveryResModel = repeatEveryResModelFromJson(jsonString);

import 'dart:convert';

RepeatEveryResModel repeatEveryResModelFromJson(String str) =>
    RepeatEveryResModel.fromJson(json.decode(str));

String repeatEveryResModelToJson(RepeatEveryResModel data) =>
    json.encode(data.toJson());

class RepeatEveryResModel {
  List<RepeatEvery>? items;

  RepeatEveryResModel({
    this.items,
  });

  factory RepeatEveryResModel.fromJson(Map<String, dynamic> json) =>
      RepeatEveryResModel(
        items: json["items"] == null
            ? []
            : List<RepeatEvery>.from(
                json["items"]!.map((x) => RepeatEvery.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "items": items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toJson())),
      };
}

class RepeatEvery {
  String? value;
  String? label;

  RepeatEvery({
    this.value,
    this.label,
  });

  factory RepeatEvery.fromJson(Map<String, dynamic> json) => RepeatEvery(
        value: json["value"],
        label: json["label"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "label": label,
      };
}
