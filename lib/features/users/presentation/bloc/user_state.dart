part of 'user_bloc.dart';

@immutable
sealed class UserState {}

final class UserInitial extends UserState {}

final class UserListLoadingState extends UserState {}

final class UserListErrorState extends UserState {
  final String errorMessage;
  UserListErrorState({required this.errorMessage});
}

final class UserListSuccessState extends UserState {
  final UsersMainResEntity usersMainResEntity;
  UserListSuccessState({required this.usersMainResEntity});
}
