part of 'user_bloc.dart';

@immutable
sealed class UserEvent {}

final class GetUserList extends UserEvent {
  final UserListRequestParams userListRequestParams;
  GetUserList({required this.userListRequestParams});
}
