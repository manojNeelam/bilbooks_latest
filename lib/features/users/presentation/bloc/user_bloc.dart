import 'package:billbooks_app/features/users/domain/entities/user_list_entity.dart';
import 'package:billbooks_app/features/users/domain/usecases/user_list_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserListUsecase _userListUsecase;

  UserBloc({required UserListUsecase userListUsecase})
      : _userListUsecase = userListUsecase,
        super(UserInitial()) {
    on<GetUserList>((event, emit) async {
      emit(UserListLoadingState());
      final response = await _userListUsecase.call(event.userListRequestParams);
      response.fold((l) => emit(UserListErrorState(errorMessage: l.message)),
          (r) => emit(UserListSuccessState(usersMainResEntity: r)));
    });
  }
}
