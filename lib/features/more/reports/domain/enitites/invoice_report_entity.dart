class InvoiceReportMainResEntity {
  final int? success;
  final InvoiceReportDataEntity? data;
  InvoiceReportMainResEntity({this.success, this.data});
}

class InvoiceReportDataEntity {
  final bool? success;
  final List<InvoiceDataEntity>? data;
  final List<TotalDataEntity>? totals;
  final String? message;

  InvoiceReportDataEntity({this.success, this.data, this.totals, this.message});
}

class InvoiceDataEntity {
  final String? date;
  final String? id;
  final String? clientId;
  final String? no;
  final String? name;
  final String? status;
  final String? dueDate;
  final String? overdueDays;
  final String? amount;
  final String? formatAmount;
  final String? paid;
  final String? formatPaid;
  final String? balance;
  final String? formatBalance;
  final String? currency;

  InvoiceDataEntity({
    this.date,
    this.id,
    this.clientId,
    this.no,
    this.name,
    this.status,
    this.dueDate,
    this.overdueDays,
    this.amount,
    this.formatAmount,
    this.paid,
    this.formatPaid,
    this.balance,
    this.formatBalance,
    this.currency,
  });
}

class TotalDataEntity {
  final String? currency;
  final int? amount;
  final int? paid;
  final int? balance;
  final String? formatAmount;
  final String? formatPaid;
  final String? formatBalance;

  TotalDataEntity({
    this.currency,
    this.amount,
    this.paid,
    this.balance,
    this.formatAmount,
    this.formatPaid,
    this.formatBalance,
  });
}
