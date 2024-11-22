// To parse this JSON data, do
//
//     final estimateListMainResModel = estimateListMainResModelFromJson(jsonString);

import 'dart:convert';

import 'package:billbooks_app/features/estimate/domain/entity_list_entity.dart';
import 'package:billbooks_app/features/invoice/data/models/invoice_list_model.dart';
import 'package:flutter/material.dart';

import '../../clients/data/models/client_list_model.dart';
import '../../item/data/models/item_list_data_model.dart';

EstimateListMainResModel estimateListMainResModelFromJson(String str) =>
    EstimateListMainResModel.fromJson(json.decode(str));

class EstimateListMainResModel extends EstimateListMainResEntity {
  EstimateListMainResModel({
    int? success,
    EstimateListDataModel? data,
  }) : super(data: data, success: success);

  factory EstimateListMainResModel.fromJson(Map<String, dynamic> json) =>
      EstimateListMainResModel(
        success: json["success"],
        data: json["data"] == null
            ? null
            : EstimateListDataModel.fromJson(json["data"]),
      );
}

class EstimateListDataModel extends EstimateListDataEntity {
  EstimateListDataModel({
    bool? success,
    List<StatusCountDataModel>? statusCount,
    List<GrandtotalModel>? grandtotal,
    PagingModel? paging,
    List<InvoiceModel>? estimates,
    StatusCountDataModel? statusCounts,
    String? message,
  }) : super(
          estimates: estimates,
          statusCount: statusCount,
          grandtotal: grandtotal,
          paging: paging,
          success: success,
          message: message,
          statusCounts: statusCounts,
        );

  factory EstimateListDataModel.fromJson(Map<String, dynamic> json) {
    debugPrint("Json: ${json["estimates"]}");
    return EstimateListDataModel(
      success: json["success"],
      statusCount: json["status_count"] == null
          ? []
          : List<StatusCountDataModel>.from(json["status_count"]!
              .map((x) => StatusCountDataModel.fromJson(x))),
      grandtotal: json["grandtotal"] == null
          ? []
          : List<GrandtotalModel>.from(
              json["grandtotal"]!.map((x) => GrandtotalModel.fromJson(x))),
      paging:
          json["paging"] == null ? null : PagingModel.fromJson(json["paging"]),
      estimates: json["estimates"] == null
          ? []
          : List<InvoiceModel>.from(json["estimates"]!.map((x) {
              return InvoiceModel.fromJson(x);
            })),
      statusCounts: json["status_counts"] == null
          ? null
          : StatusCountDataModel.fromJson(json["status_counts"]),
      message: json["message"],
    );
  }
  List<InvoiceModel> getEstimateList(Map<String, dynamic> json) {
    final list = List<InvoiceModel>.from(json["estimates"]!.map((x) {
      return InvoiceModel.fromJson(x);
    }));
    return list;
  }
}

/*class EstimateModel extends InvoiceEntity {
  EstimateModel({
    String? id,
    String? date,
    DateTime? dateYmd,
    String? clientId,
    String? clientName,
    String? clientAddress,
    String? projectId,
    String? projectName,
    String? no,
    String? pono,
    String? expiryDate,
    DateTime? expirydateYmd,
    String? summary,
    String? currency,
    int? exchangeRate,
    String? subtotal,
    String? discountType,
    String? discountValue,
    String? discount,
    String? taxtotal,
    String? shipping,
    String? nettotal,
    String? formatedTotal,
    String? notes,
    String? terms,
    String? publicKey,
    String? status,
    bool? isViewed,
    String? dateViewed,
    String? invoiceId,
    String? invoiceNo,
    bool? isAttachments,
    DateTime? dateCreated,
    DateTime? dateModified,
  }) : super();

  factory EstimateModel.fromJson(Map<String, dynamic> json) {
    //debugPrint("Estimate JSON: ${json.toString()}");
    final estmateModel = EstimateModel(
      id: json["id"],
      date: json["date"],
      dateYmd:
          json["date_ymd"] == null ? null : DateTime.parse(json["date_ymd"]),
      clientId: json["client_id"],
      clientName: json["client_name"],
      clientAddress: json["client_address"],
      projectId: json["project_id"],
      projectName: json["project_name"],
      no: json["no"],
      pono: json["pono"],
      expiryDate: json["expiry_date"],
      expirydateYmd: json["expirydate_ymd"] == null
          ? null
          : DateTime.parse(json["expirydate_ymd"]),
      summary: json["summary"],
      currency: json["currency"],
      exchangeRate: json["exchange_rate"],
      subtotal: json["subtotal"],
      discountType: json["discount_type"],
      discountValue: json["discount_value"],
      discount: json["discount"],
      taxtotal: json["taxtotal"],
      shipping: json["shipping"],
      nettotal: json["nettotal"],
      formatedTotal: json["formated_total"],
      notes: json["notes"],
      terms: json["terms"],
      publicKey: json["public_key"],
      status: json["status"]!,
      isViewed: json["is_viewed"],
      dateViewed: json["date_viewed"],
      invoiceId: json["invoice_id"],
      invoiceNo: json["invoice_no"],
      isAttachments: json["is_attachments"],
      dateCreated: json["date_created"] == null
          ? null
          : DateTime.parse(json["date_created"]),
      dateModified: json["date_modified"] == null
          ? null
          : DateTime.parse(json["date_modified"]),
    );
    debugPrint(estmateModel.clientName);
    return estmateModel;
  }
}*/
