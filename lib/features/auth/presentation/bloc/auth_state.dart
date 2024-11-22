part of 'auth_bloc.dart';

@immutable
sealed class AuthState {
  const AuthState();
}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSuccess extends AuthState {
  final UserEntity user;
  const AuthSuccess(this.user);
}

final class AuthFailure extends AuthState {
  final String message;
  const AuthFailure(this.message);
}

final class ResetPasswordReqLoading extends AuthState {}

final class ResetPasswordReqSuccess extends AuthState {
  final ForgotPasswordReqResEntity res;
  const ResetPasswordReqSuccess(this.res);
}

final class ResetPasswordReqFailure extends AuthState {
  final String message;
  const ResetPasswordReqFailure(this.message);
}

final class ResetPasswordLoading extends AuthState {}

final class ResetPasswordSuccess extends AuthState {
  final ResetPasswordResEntity res;
  const ResetPasswordSuccess(this.res);
}

final class ResetPasswordFailure extends AuthState {
  final String message;
  const ResetPasswordFailure(this.message);
}

final class RegisterUserLoading extends AuthState {}

final class RegisterUserSuccess extends AuthState {
  final RegisterUserResEntity res;
  const RegisterUserSuccess(this.res);
}

final class RegisterUserFailure extends AuthState {
  final String message;
  const RegisterUserFailure(this.message);
}
