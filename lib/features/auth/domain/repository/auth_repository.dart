import 'package:billbooks_app/core/error/failures.dart';
import 'package:billbooks_app/features/auth/domain/entities/reset_password_entity.dart';
import 'package:billbooks_app/features/auth/domain/entities/user.dart';
import 'package:billbooks_app/features/auth/domain/usecases/user_signup.dart';
import 'package:fpdart/fpdart.dart';

import '../entities/register_user_entity.dart';
import '../entities/reset_password_req_entity.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, UserEntity>> loginWithNameandPassword(
      {required String userName, required String password});
  Future<Either<Failure, ResetPasswordResEntity>> resetPassword(
      ResetPasswordUseCaseReqParams params);
  Future<Either<Failure, ForgotPasswordReqResEntity>> resetPasswordReq(
      ResetPasswordReqUseCaseReqParams params);
  Future<Either<Failure, RegisterUserResEntity>> registerUser(
      RegisterUserUseCaseReqParams params);
}
