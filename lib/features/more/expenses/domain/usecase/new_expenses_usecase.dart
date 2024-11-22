import 'package:billbooks_app/core/error/failures.dart';
import 'package:billbooks_app/core/usecase/usecase.dart';
import 'package:billbooks_app/features/more/expenses/domain/entities/add_expenses_entity.dart';
import 'package:fpdart/fpdart.dart';
import '../repository/expenses_repository.dart';

class NewExpensesUsecase
    implements UseCase<AddExpensesMainResEntity, NewExpensesParams> {
  final ExpensesRepository expensesRepository;
  NewExpensesUsecase({required this.expensesRepository});
  @override
  Future<Either<Failure, AddExpensesMainResEntity>> call(params) {
    return expensesRepository.addExpenses(params);
  }
}

class NewExpensesParams {
  final String date,
      refNo,
      category,
      vendor,
      amount,
      currency,
      notes,
      cient,
      isBillable,
      project,
      receipt,
      recurring,
      howMany,
      repeat,
      id;

  NewExpensesParams(
      this.date,
      this.refNo,
      this.category,
      this.vendor,
      this.amount,
      this.currency,
      this.notes,
      this.cient,
      this.isBillable,
      this.project,
      this.receipt,
      this.recurring,
      this.howMany,
      this.repeat,
      this.id);

  @override
  String toString() {
    return "repeat : $repeat howmany: $howMany ";
  }
}

// "date": "13/07/2024",
//         "refno": "Jul13",
//         "category": "12565",
//         "vendor": "ICICI Bank",
//         "amount": "500",
//         "currency": "USD",
//         "notes": "Bank fees notes come here.",
//         "client": "23241",
//         "is_billable": "true",
//         "project": "1669",
//         "receipt": "NA",
//         "recurring": "false",
//         "howmany": "10",
//         "repeat": ""
