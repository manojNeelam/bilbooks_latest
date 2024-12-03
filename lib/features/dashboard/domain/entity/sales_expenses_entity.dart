class SalesExpensesMainResEntity {
  int? success;
  SalesExpensesMainDataEntity? data;

  SalesExpensesMainResEntity({
    this.success,
    this.data,
  });
}

class SalesExpensesMainDataEntity {
  bool? success;
  SalesExpensesDataEntity? data;
  String? message;

  SalesExpensesMainDataEntity({
    this.success,
    this.data,
    this.message,
  });
}

class SalesExpensesDataEntity {
  List<String>? label;
  List<String>? labelAlt;
  List<String>? labelHtml;
  DashboardExpensesEntity? sales;
  DashboardExpensesEntity? receipts;
  DashboardExpensesEntity? expenses;
  TotalsEntity? totals;

  SalesExpensesDataEntity({
    this.label,
    this.labelAlt,
    this.labelHtml,
    this.sales,
    this.receipts,
    this.expenses,
    this.totals,
  });
}

class DashboardExpensesEntity {
  List<dynamic>? value;
  List<String>? formatValue;

  DashboardExpensesEntity({
    this.value,
    this.formatValue,
  });
}

class TotalsEntity {
  dynamic sales;
  dynamic receipts;
  dynamic expenses;
  String? formattedSales;
  String? formattedReceipts;
  String? formattedExpenses;

  TotalsEntity({
    this.sales,
    this.receipts,
    this.expenses,
    this.formattedExpenses,
    this.formattedReceipts,
    this.formattedSales,
  });
}
