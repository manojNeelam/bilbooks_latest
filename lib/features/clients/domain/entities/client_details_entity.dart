import 'client_list_entity.dart';

class ClientDetailsMainResEntity {
  int? success;
  ClientDetailsDataEntity? data;

  ClientDetailsMainResEntity({
    this.success,
    this.data,
  });
}

class ClientDetailsDataEntity {
  bool? success;
  ClientEntity? client;
  String? message;
  TotalsEntity? totals;
  List<ClientInvoiceEntity>? invoices;
  List<ClientEstimateEntity>? estimates;
  List<ClientExpensesEntity>? expenses;
  List<ClientProjectEntity>? projects;

  ClientDetailsDataEntity({
    this.success,
    this.client,
    this.message,
    this.estimates,
    this.totals,
    this.expenses,
    this.invoices,
    this.projects,
  });
}

class ClientEstimateEntity {
  String? id;
  ClientEstimateEntity({this.id});
}

class ClientInvoiceEntity {
  String? id;
  String? netTotal;
  String? paid;
  String? balance;
  String? formatedTotal;
  String? formatedPaid;
  String? formatedBalance;
  String? status;
  String? no;
  String? date;

  ClientInvoiceEntity({
    this.id,
    this.netTotal,
    this.paid,
    this.balance,
    this.formatedTotal,
    this.formatedPaid,
    this.formatedBalance,
    this.status,
    this.no,
    this.date,
  });
}

class ClientExpensesEntity {
  String? id;
  ClientExpensesEntity({this.id});
}

class ClientProjectEntity {
  String? id;
  ClientProjectEntity({this.id});
}

class TotalsEntity {
  dynamic sales;
  dynamic receipts;
  dynamic expenses;

  TotalsEntity({
    this.sales,
    this.receipts,
    this.expenses,
  });
}
