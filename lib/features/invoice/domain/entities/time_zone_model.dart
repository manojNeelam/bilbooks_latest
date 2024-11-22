// To parse this JSON data, do
//
//     final timeZoneResModel = timeZoneResModelFromJson(jsonString);

import 'dart:convert';

TimeZoneResModel timeZoneResModelFromJson(String str) =>
    TimeZoneResModel.fromJson(json.decode(str));

String timeZoneResModelToJson(TimeZoneResModel data) =>
    json.encode(data.toJson());

class TimeZoneResModel {
  List<Timezone>? timezone;

  TimeZoneResModel({
    this.timezone,
  });

  factory TimeZoneResModel.fromJson(Map<String, dynamic> json) =>
      TimeZoneResModel(
        timezone: json["timezone"] == null
            ? []
            : List<Timezone>.from(
                json["timezone"]!.map((x) => Timezone.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "timezone": timezone == null
            ? []
            : List<dynamic>.from(timezone!.map((x) => x.toJson())),
      };
}

class Timezone {
  String? timezoneId;
  String? code;
  String? gmt;
  String? name;

  Timezone({
    this.timezoneId,
    this.code,
    this.gmt,
    this.name,
  });

  factory Timezone.fromJson(Map<String, dynamic> json) => Timezone(
        timezoneId: json["timezone_id"],
        code: json["code"],
        gmt: json["gmt"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "timezone_id": timezoneId,
        "code": code,
        "gmt": gmt,
        "name": name,
      };
}
