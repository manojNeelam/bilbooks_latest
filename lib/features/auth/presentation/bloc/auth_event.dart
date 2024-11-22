part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthLogin extends AuthEvent {
  final String email;
  final String password;

  AuthLogin({required this.email, required this.password});
}

final class ResetPasswordReqEvent extends AuthEvent {
  final ResetPasswordReqUseCaseReqParams params;
  ResetPasswordReqEvent({required this.params});
}

final class ResetPasswordEvent extends AuthEvent {
  final ResetPasswordUseCaseReqParams params;
  ResetPasswordEvent({required this.params});
}

final class RegisterUserEvent extends AuthEvent {
  final RegisterUserUseCaseReqParams params;
  RegisterUserEvent({required this.params});
}
