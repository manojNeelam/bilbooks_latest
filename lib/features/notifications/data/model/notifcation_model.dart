// To parse this JSON data, do
//
//     final notificationMainResponseModel = notificationMainResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:billbooks_app/features/notifications/domain/entities/notifcation_entity.dart';

NotificationMainResponseModel notificationMainResponseModelFromJson(
        String str) =>
    NotificationMainResponseModel.fromJson(json.decode(str));

class NotificationMainResponseModel extends NotificationMainResponseEntity {
  NotificationMainResponseModel({
    int? success,
    NotificationMainDataModel? data,
  }) : super(
          success: success,
          data: data,
        );

  factory NotificationMainResponseModel.fromJson(Map<String, dynamic> json) =>
      NotificationMainResponseModel(
        success: json["success"],
        data: json["data"] == null
            ? null
            : NotificationMainDataModel.fromJson(json["data"]),
      );
}

class NotificationMainDataModel extends NotificationMainDataEntity {
  NotificationMainDataModel({
    bool? success,
    List<ActivitylogModel>? activitylog,
    String? message,
  }) : super(success: success, activitylog: activitylog, message: message);

  factory NotificationMainDataModel.fromJson(Map<String, dynamic> json) =>
      NotificationMainDataModel(
        success: json["success"],
        activitylog: json["activitylog"] == null
            ? []
            : List<ActivitylogModel>.from(
                json["activitylog"]!.map((x) => ActivitylogModel.fromJson(x))),
        message: json["message"],
      );
}

class ActivitylogModel extends ActivitylogEntity {
  ActivitylogModel({
    String? activityId,
    String? organizationId,
    String? transactionType,
    String? operationType,
    String? parameters,
    String? userId,
    String? clientId,
    String? itemId,
    String? estimateId,
    String? invoiceId,
    String? paymentId,
    String? expenseId,
    String? categoryId,
    String? projectId,
    String? taxId,
    String? createdBy,
    DateTime? dateCreated,
    String? createdName,
  }) : super(
          activityId: activityId,
          organizationId: organizationId,
          transactionType: transactionType,
          operationType: operationType,
          parameters: parameters,
          userId: userId,
          clientId: clientId,
          itemId: itemId,
          estimateId: estimateId,
          invoiceId: invoiceId,
          paymentId: paymentId,
          expenseId: expenseId,
          categoryId: categoryId,
          projectId: projectId,
          taxId: taxId,
          createdBy: createdBy,
          dateCreated: dateCreated,
          createdName: createdName,
        );

  factory ActivitylogModel.fromJson(Map<String, dynamic> json) =>
      ActivitylogModel(
        activityId: json["activity_id"],
        organizationId: json["organization_id"],
        transactionType: json["transaction_type"],
        operationType: json["operation_type"],
        parameters: json["parameters"],
        userId: json["user_id"],
        clientId: json["client_id"],
        itemId: json["item_id"],
        estimateId: json["estimate_id"],
        invoiceId: json["invoice_id"],
        paymentId: json["payment_id"],
        expenseId: json["expense_id"],
        categoryId: json["category_id"],
        projectId: json["project_id"],
        taxId: json["tax_id"],
        createdBy: json["created_by"],
        dateCreated: json["date_created"] == null
            ? null
            : DateTime.parse(json["date_created"]),
        createdName: json["created_name"],
      );
}
