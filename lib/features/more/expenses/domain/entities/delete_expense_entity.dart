class DeleteExpensesMainResEntity {
  int? success;
  DeleteExpensesDataEntity? data;

  DeleteExpensesMainResEntity({
    this.success,
    this.data,
  });
}

class DeleteExpensesDataEntity {
  bool? success;
  String? message;

  DeleteExpensesDataEntity({
    this.success,
    this.message,
  });
}
