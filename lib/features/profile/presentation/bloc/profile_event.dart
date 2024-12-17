part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent {}

class SetOrganizationEvent extends ProfileEvent {
  final SelectOrganizationReqParams selectOrganizationReqParams;
  SetOrganizationEvent({required this.selectOrganizationReqParams});
}

class UpdateMyProfileEvent extends ProfileEvent {
  final UpdateProfileReqParams updateProfileReqParams;
  UpdateMyProfileEvent({required this.updateProfileReqParams});
}
