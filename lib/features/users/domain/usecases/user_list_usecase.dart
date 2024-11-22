import 'package:billbooks_app/core/error/failures.dart';
import 'package:billbooks_app/core/usecase/usecase.dart';
import 'package:billbooks_app/features/users/domain/entities/user_list_entity.dart';
import 'package:billbooks_app/features/users/domain/repository/user_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserListUsecase
    implements UseCase<UsersMainResEntity, UserListRequestParams> {
  final UserRepository userRepository;
  UserListUsecase({required this.userRepository});
  @override
  Future<Either<Failure, UsersMainResEntity>> call(
      UserListRequestParams params) {
    return userRepository.getUsers(params);
  }
}

class UserListRequestParams {}
