import 'package:billbooks_app/core/error/failures.dart';
import 'package:billbooks_app/core/usecase/usecase.dart';
import 'package:billbooks_app/features/dashboard/domain/repository/dashboard_repository.dart';
import 'package:fpdart/fpdart.dart';

import '../entity/account_receivables_entity.dart';

class AccountReceivablesUsecase
    implements
        UseCase<AccountsReceivablesMainResEntity,
            AccountReceivablesUsecaseReqParams> {
  final DashboardRepository dashboardRepository;
  AccountReceivablesUsecase({required this.dashboardRepository});
  @override
  Future<Either<Failure, AccountsReceivablesMainResEntity>> call(
      AccountReceivablesUsecaseReqParams params) {
    return dashboardRepository.getAccountReceivables(params);
  }
}

class AccountReceivablesUsecaseReqParams {}
