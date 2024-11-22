import 'package:billbooks_app/features/auth/domain/entities/register_user_entity.dart';
import 'package:billbooks_app/features/auth/domain/entities/user.dart';
import 'package:billbooks_app/features/auth/domain/usecases/user_signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/reset_password_entity.dart';
import '../../domain/entities/reset_password_req_entity.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserLogin _userLogin;
  final ResetPasswordUseCase _resetPasswordUseCase;
  final ResetPasswordRequestUseCase _resetPasswordRequestUseCase;
  final RegisterUserUseCase _registerUserUseCase;

  AuthBloc(
      {required UserLogin userLogin,
      required ResetPasswordUseCase resetPasswordUseCase,
      required ResetPasswordRequestUseCase resetPasswordRequestUseCase,
      required RegisterUserUseCase registerUserUseCase})
      : _userLogin = userLogin,
        _resetPasswordUseCase = resetPasswordUseCase,
        _resetPasswordRequestUseCase = resetPasswordRequestUseCase,
        _registerUserUseCase = registerUserUseCase,
        super(AuthInitial()) {
    on<AuthLogin>((event, emit) async {
      emit(AuthLoading());
      final response = await _userLogin(
          UserLoginParams(email: event.email, password: event.password));
      response.fold(
          (l) => emit(AuthFailure(l.message)), (r) => emit(AuthSuccess(r)));
    });

    on<ResetPasswordReqEvent>((event, emit) async {
      emit(ResetPasswordReqLoading());
      final response = await _resetPasswordRequestUseCase(event.params);
      response.fold((l) => emit(ResetPasswordReqFailure(l.message)),
          (r) => emit(ResetPasswordReqSuccess(r)));
    });

    on<ResetPasswordEvent>((event, emit) async {
      emit(ResetPasswordLoading());
      final response = await _resetPasswordUseCase(event.params);
      response.fold((l) => emit(ResetPasswordFailure(l.message)),
          (r) => emit(ResetPasswordSuccess(r)));
    });

    on<RegisterUserEvent>((event, emit) async {
      emit(RegisterUserLoading());
      final response = await _registerUserUseCase(event.params);
      response.fold((l) => emit(RegisterUserFailure(l.message)),
          (r) => emit(RegisterUserSuccess(r)));
    });
  }
}
