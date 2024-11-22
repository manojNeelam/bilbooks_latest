// To parse this JSON data, do
//
//     final estimateMainResEntity = estimateMainResEntityFromJson(jsonString);

import 'dart:convert';

EstimateMainResEntity estimateNameMainResEntityFromJson(String str) =>
    EstimateMainResEntity.fromJson(json.decode(str));

class EstimateMainResEntity {
  List<EstimateName>? estimateName;

  EstimateMainResEntity({
    this.estimateName,
  });

  factory EstimateMainResEntity.fromJson(Map<String, dynamic> json) =>
      EstimateMainResEntity(
        estimateName: json["estimate_name"] == null
            ? []
            : List<EstimateName>.from(
                json["estimate_name"]!.map((x) => EstimateName.fromJson(x))),
      );
}

class EstimateName {
  String? name;

  EstimateName({
    this.name,
  });

  factory EstimateName.fromJson(Map<String, dynamic> json) => EstimateName(
        name: json["name"],
      );
}
