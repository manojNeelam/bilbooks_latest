import 'package:billbooks_app/core/error/failures.dart';
import 'package:billbooks_app/features/more/expenses/domain/entities/add_expenses_entity.dart';
import 'package:billbooks_app/features/more/expenses/domain/entities/expenses_list_entity.dart';
import 'package:billbooks_app/features/more/expenses/domain/usecase/delete_expense_usecase.dart';
import 'package:billbooks_app/features/more/expenses/domain/usecase/expenses_list_usecase.dart';
import 'package:billbooks_app/features/more/expenses/domain/usecase/new_expenses_usecase.dart';
import 'package:fpdart/fpdart.dart';

import '../entities/delete_expense_entity.dart';

abstract interface class ExpensesRepository {
  Future<Either<Failure, ExpensesListMainResEntity>> getExpenses(
      ExpensesListRequestParams params);
  Future<Either<Failure, AddExpensesMainResEntity>> addExpenses(
      NewExpensesParams params);
  Future<Either<Failure, DeleteExpensesMainResEntity>> deleteExpense(
      DeleteExpenseReqParams params);
}
