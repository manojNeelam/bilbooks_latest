part of 'profile_bloc.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

class SelectOrganizationLoadingState extends ProfileState {}

class SelectOrganizationErrorstateState extends ProfileState {
  final String errorMessage;
  SelectOrganizationErrorstateState({required this.errorMessage});
}

class SelectOrganizationSuccessState extends ProfileState {
  final AuthInfoMainResEntity authInfoMainResEntity;
  SelectOrganizationSuccessState({required this.authInfoMainResEntity});
}

class UpdateMyProfileLoadingState extends ProfileState {}

class UpdateMyProfileSuccessState extends ProfileState {
  final UpdateMyProfileResponseEntity updateMyProfileResponseEntity;
  UpdateMyProfileSuccessState({required this.updateMyProfileResponseEntity});
}

class UpdateMyProfileErrorState extends ProfileState {
  final String errorMessage;
  UpdateMyProfileErrorState({required this.errorMessage});
}
