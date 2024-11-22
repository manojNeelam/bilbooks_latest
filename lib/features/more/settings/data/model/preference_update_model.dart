import 'dart:convert';

import 'package:billbooks_app/features/more/settings/domain/entity/preference_update_entity.dart';

PreferenceUpdateMainResModel preferenceUpdateMainResModelFromJson(String str) =>
    PreferenceUpdateMainResModel.fromJson(json.decode(str));

class PreferenceUpdateMainResModel extends PreferenceUpdateMainResEntity {
  PreferenceUpdateMainResModel({
    int? success,
    PreferenceUpdateDataModel? data,
  }) : super(data: data, success: success);

  factory PreferenceUpdateMainResModel.fromJson(Map<String, dynamic> json) =>
      PreferenceUpdateMainResModel(
        success: json["success"],
        data: json["data"] == null
            ? null
            : PreferenceUpdateDataModel.fromJson(json["data"]),
      );
}

class PreferenceUpdateDataModel extends PreferenceUpdateDataEntity {
  PreferenceUpdateDataModel({
    bool? success,
    String? message,
  }) : super(success: success, message: message);

  factory PreferenceUpdateDataModel.fromJson(Map<String, dynamic> json) =>
      PreferenceUpdateDataModel(
        success: json["success"],
        message: json["message"],
      );
}
