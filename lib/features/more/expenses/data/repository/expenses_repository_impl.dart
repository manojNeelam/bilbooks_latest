import 'package:billbooks_app/core/api/api_exception.dart';
import 'package:billbooks_app/core/error/failures.dart';
import 'package:billbooks_app/features/item/domain/entities/delete_item_entity.dart';
import 'package:billbooks_app/features/more/expenses/data/datasource/remote/expenses_remote_datasource.dart';
import 'package:billbooks_app/features/more/expenses/data/models/add_expenses_model.dart';
import 'package:billbooks_app/features/more/expenses/data/models/delete_expense_model.dart';
import 'package:billbooks_app/features/more/expenses/domain/entities/expenses_list_entity.dart';
import 'package:billbooks_app/features/more/expenses/domain/repository/expenses_repository.dart';
import 'package:billbooks_app/features/more/expenses/domain/usecase/delete_expense_usecase.dart';
import 'package:billbooks_app/features/more/expenses/domain/usecase/expenses_list_usecase.dart';
import 'package:billbooks_app/features/more/expenses/domain/usecase/new_expenses_usecase.dart';
import 'package:fpdart/fpdart.dart';

class ExpensesRepositoryImpl implements ExpensesRepository {
  final ExpensesRemoteDatasource expensesRemoteDatasource;
  ExpensesRepositoryImpl({required this.expensesRemoteDatasource});
  @override
  Future<Either<Failure, ExpensesListMainResEntity>> getExpenses(
      ExpensesListRequestParams params) async {
    try {
      final resmodel = await expensesRemoteDatasource.getExpenses(params);
      return right(resmodel);
    } on ApiException catch (e) {
      return left(Failure(e.message));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AddExpensesMainResModel>> addExpenses(
      NewExpensesParams params) async {
    try {
      final resmodel = await expensesRemoteDatasource.addExpenses(params);
      return right(resmodel);
    } on ApiException catch (e) {
      return left(Failure(e.message));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, DeleteExpensesMainResModel>> deleteExpense(
      DeleteExpenseReqParams params) async {
    try {
      final resmodel = await expensesRemoteDatasource.deleteExpense(params);
      return right(resmodel);
    } on ApiException catch (e) {
      return left(Failure(e.message));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
