// To parse this JSON data, do
//
//     final outstandingReportMainResModel = outstandingReportMainResModelFromJson(jsonString);

import 'package:billbooks_app/features/more/reports/domain/enitites/outstanding_report_entity.dart';

class OutstandingReportMainResModel extends OutstandingReportMainResEntity {
  OutstandingReportMainResModel({
    int? success,
    OutstandingReportDataModel? data,
  }) : super(data: data, success: success);

  factory OutstandingReportMainResModel.fromJson(Map<String, dynamic> json) =>
      OutstandingReportMainResModel(
        success: json["success"],
        data: OutstandingReportDataModel.fromJson(json["data"]),
      );
}

class OutstandingReportDataModel extends OutstandingReportDataEntity {
  OutstandingReportDataModel({
    bool? success,
    List<OutstandingReportModel>? data,
    List<OutstandingReportTotalModel>? totals,
    String? message,
  }) : super(data: data, success: success, totals: totals, message: message);

  factory OutstandingReportDataModel.fromJson(Map<String, dynamic> json) =>
      OutstandingReportDataModel(
        success: json["success"],
        data: List<OutstandingReportModel>.from(
            json["data"].map((x) => OutstandingReportModel.fromJson(x))),
        totals: List<OutstandingReportTotalModel>.from(
            json["totals"].map((x) => OutstandingReportTotalModel.fromJson(x))),
        message: json["message"],
      );
}

class OutstandingReportModel extends OutstandingReportEntity {
  OutstandingReportModel({
    String? name,
    String? clientId,
    String? contactName,
    String? contactEmail,
    String? contactPhone,
    String? city,
    String? country,
    String? balance,
    String? formatBalance,
    String? currency,
  }) : super(
            name: name,
            clientId: clientId,
            contactName: contactName,
            contactEmail: contactEmail,
            contactPhone: contactPhone,
            city: city,
            country: country,
            balance: balance,
            formatBalance: formatBalance,
            currency: currency);

  factory OutstandingReportModel.fromJson(Map<String, dynamic> json) =>
      OutstandingReportModel(
        name: json["name"],
        clientId: json["client_id"],
        contactName: json["contact_name"],
        contactEmail: json["contact_email"],
        contactPhone: json["contact_phone"],
        city: json["city"],
        country: json["country"],
        balance: json["balance"],
        formatBalance: json["format_balance"],
        currency: json["currency"],
      );
}

class OutstandingReportTotalModel extends OutstandingReportTotalEntity {
  OutstandingReportTotalModel({
    String? currency,
    String? amount,
    String? formatAmount,
  }) : super(currency: currency, amount: amount, formatAmount: formatAmount);

  factory OutstandingReportTotalModel.fromJson(Map<String, dynamic> json) =>
      OutstandingReportTotalModel(
        currency: json["currency"],
        amount: json["amount"],
        formatAmount: json["format_amount"],
      );
}
