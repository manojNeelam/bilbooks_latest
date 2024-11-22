import 'package:billbooks_app/core/error/failures.dart';
import 'package:billbooks_app/features/auth/data/datasources/remote/auth_remote_data_source.dart';
import 'package:billbooks_app/features/auth/domain/entities/register_user_entity.dart';
import 'package:billbooks_app/features/auth/domain/entities/reset_password_entity.dart';
import 'package:billbooks_app/features/auth/domain/entities/reset_password_req_entity.dart';
import 'package:billbooks_app/features/auth/domain/entities/user.dart';
import 'package:billbooks_app/features/auth/domain/usecases/user_signup.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/api/api_exception.dart';
import '../../domain/repository/auth_repository.dart';

class AuthRepositoryImp implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImp(this.authRemoteDataSource);
  @override
  Future<Either<Failure, UserEntity>> loginWithNameandPassword(
      {required String userName, required String password}) async {
    try {
      print("loginWithNameandPassword");
      final userModel = await authRemoteDataSource.loginWithEmailandPassword(
          email: userName, password: password);
      print(userModel);
      return right(userModel);
    } on ApiException catch (e) {
      return left(Failure(e.message));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ResetPasswordResEntity>> resetPassword(
      ResetPasswordUseCaseReqParams params) async {
    try {
      print("resetPassword");
      final userModel = await authRemoteDataSource.resetpassword(params);
      print(userModel);
      return right(userModel);
    } on ApiException catch (e) {
      return left(Failure(e.message));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ForgotPasswordReqResEntity>> resetPasswordReq(
      ResetPasswordReqUseCaseReqParams params) async {
    try {
      print("resetPasswordReq");
      final userModel = await authRemoteDataSource.resetpasswordRequest(params);
      print(userModel);
      return right(userModel);
    } on ApiException catch (e) {
      return left(Failure(e.message));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, RegisterUserResEntity>> registerUser(
      RegisterUserUseCaseReqParams params) async {
    try {
      print("registerUser");
      final userModel = await authRemoteDataSource.registerUser(params);
      print(userModel);
      return right(userModel);
    } on ApiException catch (e) {
      return left(Failure(e.message));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
