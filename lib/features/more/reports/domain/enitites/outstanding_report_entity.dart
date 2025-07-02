class OutstandingReportMainResEntity {
  int? success;
  OutstandingReportDataEntity? data;

  OutstandingReportMainResEntity({
    required this.success,
    required this.data,
  });
}

class OutstandingReportDataEntity {
  bool? success;
  List<OutstandingReportEntity>? data;
  List<OutstandingReportTotalEntity>? totals;
  String? message;

  OutstandingReportDataEntity({
    required this.success,
    required this.data,
    required this.totals,
    required this.message,
  });
}

class OutstandingReportEntity {
  String? name;
  String? clientId;
  String? contactName;
  String? contactEmail;
  String? contactPhone;
  String? city;
  String? country;
  String? balance;
  String? formatBalance;
  String? currency;

  OutstandingReportEntity({
    required this.name,
    required this.clientId,
    required this.contactName,
    required this.contactEmail,
    required this.contactPhone,
    required this.city,
    required this.country,
    required this.balance,
    required this.formatBalance,
    required this.currency,
  });
}

class OutstandingReportTotalEntity {
  String? currency;
  String? amount;
  String? formatAmount;

  OutstandingReportTotalEntity({
    required this.currency,
    required this.amount,
    required this.formatAmount,
  });
}
