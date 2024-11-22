import 'package:billbooks_app/core/error/failures.dart';
import 'package:billbooks_app/core/usecase/usecase.dart';
import 'package:billbooks_app/features/dashboard/domain/entity/authinfo_entity.dart';
import 'package:billbooks_app/features/dashboard/domain/repository/dashboard_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthInfoUsecase
    implements UseCase<AuthInfoMainResEntity, AuthInfoReqParams> {
  final DashboardRepository dashboardRepository;
  AuthInfoUsecase({required this.dashboardRepository});
  @override
  Future<Either<Failure, AuthInfoMainResEntity>> call(
      AuthInfoReqParams params) {
    return dashboardRepository.getUserInfo(params);
  }
}

class AuthInfoReqParams {}
