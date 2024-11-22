class OverdueInvoiceMainResEntity {
  int? success;
  OverdueInvoiceMainDataEntity? data;

  OverdueInvoiceMainResEntity({
    this.success,
    this.data,
  });
}

class OverdueInvoiceMainDataEntity {
  bool? success;
  List<DashboardInvoiceEntity>? invoices;
  String? message;

  OverdueInvoiceMainDataEntity({
    this.success,
    this.invoices,
    this.message,
  });
}

class DashboardInvoiceEntity {
  String? id;
  String? clientName;
  String? summary;
  String? no;
  String? date;
  String? currency;
  String? dueDate;
  String? overdueDays;
  String? nettotal;
  String? paid;
  String? balance;
  String? status;

  DashboardInvoiceEntity({
    this.id,
    this.clientName,
    this.summary,
    this.no,
    this.date,
    this.currency,
    this.dueDate,
    this.overdueDays,
    this.nettotal,
    this.paid,
    this.balance,
    this.status,
  });
}
