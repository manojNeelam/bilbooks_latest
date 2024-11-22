import 'package:billbooks_app/core/error/failures.dart';
import 'package:billbooks_app/core/usecase/usecase.dart';
import 'package:billbooks_app/features/more/expenses/domain/entities/delete_expense_entity.dart';
import 'package:fpdart/fpdart.dart';

import '../repository/expenses_repository.dart';

class DeleteExpenseUsecase
    implements UseCase<DeleteExpensesMainResEntity, DeleteExpenseReqParams> {
  final ExpensesRepository expensesRepository;
  DeleteExpenseUsecase({required this.expensesRepository});

  @override
  Future<Either<Failure, DeleteExpensesMainResEntity>> call(
      DeleteExpenseReqParams params) {
    return expensesRepository.deleteExpense(params);
  }
}

class DeleteExpenseReqParams {
  final String id;
  DeleteExpenseReqParams({required this.id});
}
