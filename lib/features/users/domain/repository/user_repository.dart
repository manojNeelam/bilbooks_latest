import 'package:billbooks_app/core/error/failures.dart';
import 'package:billbooks_app/features/users/domain/entities/user_list_entity.dart';
import 'package:billbooks_app/features/users/domain/usecases/user_list_usecase.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class UserRepository {
  Future<Either<Failure, UsersMainResEntity>> getUsers(
      UserListRequestParams params);
}
