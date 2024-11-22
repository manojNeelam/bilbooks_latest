part of 'authinfo_bloc.dart';

@immutable
sealed class AuthinfoState {}

final class AuthinfoInitial extends AuthinfoState {}

class AuthInfoLoadingState extends AuthinfoState {}

class AuthInfoErrorState extends AuthinfoState {
  final String errorMessage;
  AuthInfoErrorState({required this.errorMessage});
}

class AuthInfoSuccessState extends AuthinfoState {
  final AuthInfoMainResEntity authInfoMainResEntity;
  AuthInfoSuccessState({required this.authInfoMainResEntity});
}
