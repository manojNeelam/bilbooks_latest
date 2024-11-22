import 'package:billbooks_app/core/error/failures.dart';
import 'package:billbooks_app/core/usecase/usecase.dart';
import 'package:fpdart/fpdart.dart';

import '../entity/total_receivables_entity.dart';
import '../repository/dashboard_repository.dart';

class TotalReceivablesUsecase
    implements
        UseCase<TotalReceivablesMainResEntity,
            TotalReceivablesUsecaseReqParams> {
  final DashboardRepository dashboardRepository;
  TotalReceivablesUsecase({required this.dashboardRepository});

  @override
  Future<Either<Failure, TotalReceivablesMainResEntity>> call(
      TotalReceivablesUsecaseReqParams params) {
    return dashboardRepository.getTotalReceivables(params);
  }
}

class TotalReceivablesUsecaseReqParams {}
