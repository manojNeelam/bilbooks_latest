import 'package:billbooks_app/features/more/reports/domain/enitites/invoice_report_entity.dart';

class InvoiceReportMainResModel extends InvoiceReportMainResEntity {
  InvoiceReportMainResModel({
    final int? success,
    final InvoiceReportData? data,
  }) : super(
          success: success,
          data: data,
        );

  factory InvoiceReportMainResModel.fromJson(Map<String, dynamic> json) {
    return InvoiceReportMainResModel(
      success: json['success'],
      data: json['data'] != null
          ? InvoiceReportData.fromJson(json['data'])
          : null,
    );
  }
}

class InvoiceReportData extends InvoiceReportDataEntity {
  InvoiceReportData({
    final bool? success,
    final List<InvoiceDataModel>? data,
    final List<TotalDataModel>? totals,
    final String? message,
  }) : super(
          success: success,
          data: data,
          totals: totals,
          message: message,
        );

  factory InvoiceReportData.fromJson(Map<String, dynamic> json) {
    return InvoiceReportData(
      success: json['success'],
      data: (json['data'] as List?)
          ?.map((item) => InvoiceDataModel.fromJson(item))
          .toList(),
      totals: (json['totals'] as List?)
          ?.map((item) => TotalDataModel.fromJson(item))
          .toList(),
      message: json['message'],
    );
  }
}

class InvoiceDataModel extends InvoiceDataEntity {
  InvoiceDataModel({
    final String? date,
    final String? id,
    final String? clientId,
    final String? no,
    final String? name,
    final String? status,
    final String? dueDate,
    final String? overdueDays,
    final String? amount,
    final String? formatAmount,
    final String? paid,
    final String? formatPaid,
    final String? balance,
    final String? formatBalance,
    final String? currency,
  }) : super(
          date: date,
          id: id,
          clientId: clientId,
          no: no,
          name: name,
          status: status,
          dueDate: dueDate,
          overdueDays: overdueDays,
          amount: amount,
          formatAmount: formatAmount,
          formatBalance: formatBalance,
          formatPaid: formatPaid,
          paid: paid,
          balance: balance,
          currency: currency,
        );

  factory InvoiceDataModel.fromJson(Map<String, dynamic> json) {
    return InvoiceDataModel(
      date: json['date'],
      id: json['id'],
      clientId: json['client_id'],
      no: json['no'],
      name: json['name'],
      status: json['status'],
      dueDate: json['due_date'],
      overdueDays: json['overdue_days'],
      amount: json['amount'],
      formatAmount: json['format_amount'],
      paid: json['paid'],
      formatPaid: json['format_paid'],
      balance: json['balance'],
      formatBalance: json['format_balance'],
      currency: json['currency'],
    );
  }
}

class TotalDataModel extends TotalDataEntity {
  TotalDataModel({
    final String? currency,
    final int? amount,
    final int? paid,
    final int? balance,
    final String? formatAmount,
    final String? formatPaid,
    final String? formatBalance,
  }) : super(
          currency: currency,
          amount: amount,
          paid: paid,
          balance: balance,
          formatAmount: formatAmount,
          formatPaid: formatPaid,
          formatBalance: formatBalance,
        );

  factory TotalDataModel.fromJson(Map<String, dynamic> json) {
    return TotalDataModel(
      currency: json['currency'],
      amount: json['amount'],
      paid: json['paid'],
      balance: json['balance'],
      formatAmount: json['format_amount'],
      formatPaid: json['format_paid'],
      formatBalance: json['format_balance'],
    );
  }
}
