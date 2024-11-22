import 'dart:convert';

import '../../domain/entities/send_document_entity.dart';

SendDocumentMainResModel sendDocumentMainResModelFromJson(String str) =>
    SendDocumentMainResModel.fromJson(json.decode(str));

class SendDocumentMainResModel extends SendDocumentMainResEntity {
  SendDocumentMainResModel({
    int? success,
    SendDocumentDataModel? data,
  }) : super(success: success, data: data);

  factory SendDocumentMainResModel.fromJson(Map<String, dynamic> json) =>
      SendDocumentMainResModel(
        success: json["success"],
        data: json["data"] == null
            ? null
            : SendDocumentDataModel.fromJson(json["data"]),
      );
}

class SendDocumentDataModel extends SendDocumentDataEntity {
  SendDocumentDataModel({
    bool? success,
    String? message,
  }) : super(
          message: message,
          success: success,
        );

  factory SendDocumentDataModel.fromJson(Map<String, dynamic> json) =>
      SendDocumentDataModel(
        success: json["success"],
        message: json["message"],
      );
}
