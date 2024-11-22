import 'package:billbooks_app/core/error/failures.dart';
import 'package:billbooks_app/features/dashboard/domain/entity/authinfo_entity.dart';
import 'package:billbooks_app/features/profile/domain/usecase/profile_usecase.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class ProfileRepository {
  Future<Either<Failure, AuthInfoMainResEntity>> selectOraganization(
      SelectOrganizationReqParams params);
}
