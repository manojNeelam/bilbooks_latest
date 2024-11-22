// To parse this JSON data, do
//
//     final addExpensesMainResEntity = addExpensesMainResEntityFromJson(jsonString);

class AddExpensesMainResEntity {
  int? success;
  AddExpensesDataEntity? data;

  AddExpensesMainResEntity({
    this.success,
    this.data,
  });
}

class AddExpensesDataEntity {
  bool? success;
  int? expenseId;
  String? message;

  AddExpensesDataEntity({
    this.success,
    this.expenseId,
    this.message,
  });
}
