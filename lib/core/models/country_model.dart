// To parse this JSON data, do
//
//     final countryMainDataModel = countryMainDataModelFromJson(jsonString);

import 'dart:convert';

CountryMainDataModel countryMainDataModelFromJson(String str) =>
    CountryMainDataModel.fromJson(json.decode(str));

String countryMainDataModelToJson(CountryMainDataModel data) =>
    json.encode(data.toJson());

class CountryMainDataModel {
  List<CountryModel>? country;

  CountryMainDataModel({
    this.country,
  });

  factory CountryMainDataModel.fromJson(Map<String, dynamic> json) =>
      CountryMainDataModel(
        country: json["country"] == null
            ? []
            : List<CountryModel>.from(
                json["country"]!.map((x) => CountryModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "country": country == null
            ? []
            : List<dynamic>.from(country!.map((x) => x.toJson())),
      };
}

class CountryModel {
  String? countryId;
  String? code;
  String? name;
  String? currency;
  String? timezoneId;

  CountryModel({
    this.countryId,
    this.code,
    this.name,
    this.currency,
    this.timezoneId,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) => CountryModel(
        countryId: json["country_id"],
        code: json["code"],
        name: json["name"],
        currency: json["currency"],
        timezoneId: json["timezone_id"],
      );

  Map<String, dynamic> toJson() => {
        "country_id": countryId,
        "code": code,
        "name": name,
        "currency": currency,
        "timezone_id": timezoneId,
      };
}
