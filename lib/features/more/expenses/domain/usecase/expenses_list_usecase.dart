import 'package:auto_route/auto_route.dart';
import 'package:billbooks_app/core/error/failures.dart';
import 'package:billbooks_app/core/usecase/usecase.dart';
import 'package:billbooks_app/features/more/expenses/domain/entities/expenses_list_entity.dart';
import 'package:billbooks_app/features/more/expenses/domain/repository/expenses_repository.dart';
import 'package:fpdart/fpdart.dart';

class ExpensesListUsecase
    implements UseCase<ExpensesListMainResEntity, ExpensesListRequestParams> {
  final ExpensesRepository expensesRepository;
  ExpensesListUsecase({required this.expensesRepository});
  @override
  Future<Either<Failure, ExpensesListMainResEntity>> call(
      ExpensesListRequestParams params) {
    return expensesRepository.getExpenses(params);
  }
}

class ExpensesListRequestParams {
  final String status;
  final String sortBy;
  final String orderBy;
  final String query;
  final String page;
  final String? startDate;
  final String? endDate;
  ExpensesListRequestParams({
    required this.status,
    required this.orderBy,
    required this.sortBy,
    required this.query,
    required this.page,
    this.startDate,
    this.endDate,
  });
}
