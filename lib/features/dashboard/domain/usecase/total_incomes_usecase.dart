import 'package:billbooks_app/core/error/failures.dart';
import 'package:billbooks_app/core/usecase/usecase.dart';
import 'package:fpdart/fpdart.dart';

import '../entity/total_incomes_entity.dart';
import '../repository/dashboard_repository.dart';

class TotalIncomesUsecase
    implements
        UseCase<TotalIncomesMainResEntity, TotalIncomesUsecaseReqParams> {
  final DashboardRepository dashboardRepository;
  TotalIncomesUsecase({required this.dashboardRepository});

  @override
  Future<Either<Failure, TotalIncomesMainResEntity>> call(
      TotalIncomesUsecaseReqParams params) {
    return dashboardRepository.getTotalIncomes(params);
  }
}

class TotalIncomesUsecaseReqParams {}
