import 'package:billbooks_app/core/error/failures.dart';
import 'package:billbooks_app/core/usecase/usecase.dart';
import 'package:fpdart/fpdart.dart';

import '../entity/sales_expenses_entity.dart';
import '../repository/dashboard_repository.dart';

class SalesExpensesUsecase
    implements
        UseCase<SalesExpensesMainResEntity, SalesExpensesUsecaseReqParams> {
  final DashboardRepository dashboardRepository;
  SalesExpensesUsecase({required this.dashboardRepository});
  @override
  Future<Either<Failure, SalesExpensesMainResEntity>> call(
      SalesExpensesUsecaseReqParams params) {
    return dashboardRepository.getSalesExpenses(params);
  }
}

class SalesExpensesUsecaseReqParams {}
