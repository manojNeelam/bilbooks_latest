import 'package:billbooks_app/features/dashboard/domain/entity/authinfo_entity.dart';
import 'package:billbooks_app/features/profile/domain/repository/repository.dart';
import 'package:billbooks_app/features/profile/domain/usecase/profile_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entity/profile_entity.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final SelectOrganizationUseCase _selectOrganizationUseCase;
  final UpdateProfileUsecase _updateProfileUsecase;

  ProfileBloc({
    required SelectOrganizationUseCase selectOrganizationUseCase,
    required UpdateProfileUsecase updateProfileUsecase,
  })  : _selectOrganizationUseCase = selectOrganizationUseCase,
        _updateProfileUsecase = updateProfileUsecase,
        super(ProfileInitial()) {
    on<SetOrganizationEvent>((event, emit) async {
      emit(SelectOrganizationLoadingState());
      final response = await _selectOrganizationUseCase
          .call(event.selectOrganizationReqParams);
      response.fold(
          (l) =>
              emit(SelectOrganizationErrorstateState(errorMessage: l.message)),
          (r) =>
              emit(SelectOrganizationSuccessState(authInfoMainResEntity: r)));
    });

    on<UpdateMyProfileEvent>((event, emit) async {
      emit(UpdateMyProfileLoadingState());
      final response =
          await _updateProfileUsecase.call(event.updateProfileReqParams);
      response.fold(
          (l) => emit(UpdateMyProfileErrorState(errorMessage: l.message)),
          (r) => emit(
              UpdateMyProfileSuccessState(updateMyProfileResponseEntity: r)));
    });
  }
}
