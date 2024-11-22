import 'package:billbooks_app/core/error/failures.dart';
import 'package:billbooks_app/core/usecase/usecase.dart';
import 'package:billbooks_app/features/auth/domain/entities/user.dart';
import 'package:billbooks_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

import '../entities/register_user_entity.dart';
import '../entities/reset_password_entity.dart';
import '../entities/reset_password_req_entity.dart';

class UserLogin implements UseCase<UserEntity, UserLoginParams> {
  final AuthRepository authRepository;
  UserLogin(this.authRepository);
  @override
  Future<Either<Failure, UserEntity>> call(UserLoginParams params) async {
    return await authRepository.loginWithNameandPassword(
        userName: params.email, password: params.password);
  }
}

class UserLoginParams {
  final String email;
  final String password;

  UserLoginParams({
    required this.email,
    required this.password,
  });
}

class ResetPasswordRequestUseCase
    implements
        UseCase<ForgotPasswordReqResEntity, ResetPasswordReqUseCaseReqParams> {
  final AuthRepository authRepository;
  ResetPasswordRequestUseCase(this.authRepository);

  @override
  Future<Either<Failure, ForgotPasswordReqResEntity>> call(
      ResetPasswordReqUseCaseReqParams params) async {
    return await authRepository.resetPasswordReq(params);
  }
}

class ResetPasswordReqUseCaseReqParams {
  final String email;
  ResetPasswordReqUseCaseReqParams({
    required this.email,
  });
}

class ResetPasswordUseCase
    implements UseCase<ResetPasswordResEntity, ResetPasswordUseCaseReqParams> {
  final AuthRepository authRepository;
  ResetPasswordUseCase(this.authRepository);

  @override
  Future<Either<Failure, ResetPasswordResEntity>> call(
      ResetPasswordUseCaseReqParams params) async {
    return await authRepository.resetPassword(params);
  }
}

class ResetPasswordUseCaseReqParams {
  final String hashkey;
  final String password;
  final String confirmPassword;

  ResetPasswordUseCaseReqParams({
    required this.hashkey,
    required this.password,
    required this.confirmPassword,
  });
}

class RegisterUserUseCase
    implements UseCase<RegisterUserResEntity, RegisterUserUseCaseReqParams> {
  final AuthRepository authRepository;
  RegisterUserUseCase({required this.authRepository});
  @override
  Future<Either<Failure, RegisterUserResEntity>> call(
      RegisterUserUseCaseReqParams params) async {
    return await authRepository.registerUser(params);
  }
}

class RegisterUserUseCaseReqParams {
  final String email, company, name, password, country, lang;
  RegisterUserUseCaseReqParams(
      {required this.email,
      required this.company,
      required this.name,
      required this.password,
      required this.country,
      required this.lang});
}
