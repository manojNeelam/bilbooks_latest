class AccountsReceivablesMainResEntity {
  int? success;
  AccountsReceivablesDataEntity? data;

  AccountsReceivablesMainResEntity({
    this.success,
    this.data,
  });
}

class AccountsReceivablesDataEntity {
  bool? success;
  List<AccountsReceivableEntity>? data;
  String? message;

  AccountsReceivablesDataEntity({
    this.success,
    this.data,
    this.message,
  });
}

class AccountsReceivableEntity {
  String? name;
  String? amount;
  String? currency;
  String? formatedAmount;

  AccountsReceivableEntity({
    this.name,
    this.amount,
    this.currency,
    this.formatedAmount,
  });
}
