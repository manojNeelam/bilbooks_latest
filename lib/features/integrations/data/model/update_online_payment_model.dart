import 'dart:convert';

import '../../domain/entity/update_online_payment_entity.dart';

UpdateOnlinePaymentMainResModel updateOrganizationMainResModelFromJson(
        String str) =>
    UpdateOnlinePaymentMainResModel.fromJson(json.decode(str));

class UpdateOnlinePaymentMainResModel extends UpdateOnlinePaymentMainResEntity {
  UpdateOnlinePaymentMainResModel({
    int? success,
    UpdateOnlinePaymentDataModel? data,
  }) : super(data: data, success: success);

  factory UpdateOnlinePaymentMainResModel.fromJson(Map<String, dynamic> json) =>
      UpdateOnlinePaymentMainResModel(
        success: json["success"],
        data: json["data"] == null
            ? null
            : UpdateOnlinePaymentDataModel.fromJson(json["data"]),
      );
}

class UpdateOnlinePaymentDataModel extends UpdateOnlinePaymentDataEntity {
  UpdateOnlinePaymentDataModel({
    bool? success,
    String? message,
  }) : super(success: success, message: message);

  factory UpdateOnlinePaymentDataModel.fromJson(Map<String, dynamic> json) =>
      UpdateOnlinePaymentDataModel(
        success: json["success"],
        message: json["message"],
      );
}
