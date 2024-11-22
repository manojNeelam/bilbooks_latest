import 'package:billbooks_app/core/api/api_exception.dart';
import 'package:billbooks_app/core/error/failures.dart';
import 'package:billbooks_app/features/users/data/datasource/remote/user_remote_datasource.dart';
import 'package:billbooks_app/features/users/domain/entities/user_list_entity.dart';
import 'package:billbooks_app/features/users/domain/repository/user_repository.dart';
import 'package:billbooks_app/features/users/domain/usecases/user_list_usecase.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';

class UserRepositoryImp implements UserRepository {
  final UserRemoteDatasource userRemoteDatasource;
  UserRepositoryImp({required this.userRemoteDatasource});
  @override
  Future<Either<Failure, UsersMainResEntity>> getUsers(
      UserListRequestParams params) async {
    try {
      final resModel = await userRemoteDatasource.getUsers();
      return right(resModel);
    } on ApiException catch (e) {
      return left(Failure(e.message));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
