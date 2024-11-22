part of 'organization_bloc.dart';

@immutable
sealed class OrganizationState {}

final class OrganizationInitial extends OrganizationState {}

final class OrganizationLoadingState extends OrganizationState {}

final class OrganizationErrorState extends OrganizationState {
  final String errorMessage;
  OrganizationErrorState({required this.errorMessage});
}

final class OrganizationSuccessState extends OrganizationState {
  final OrganizationDetailsMainResEntity organizationDetailsMainResEntity;
  OrganizationSuccessState({required this.organizationDetailsMainResEntity});
}

// Update organization
final class UpdateOrganizationLoadingState extends OrganizationState {}

final class UpdateOrganizationErrorState extends OrganizationState {
  final String errorMessage;
  UpdateOrganizationErrorState({required this.errorMessage});
}

final class UpdateOrganizationSuccessState extends OrganizationState {
  final UpdateOrganizationMainResEntity updateOrganizationMainResEntity;
  UpdateOrganizationSuccessState(
      {required this.updateOrganizationMainResEntity});
}
// Update organization

// Update preference
final class UpdatePreferenceLoadingState extends OrganizationState {}

final class UpdatePreferenceErrorState extends OrganizationState {
  final String errorMessage;
  UpdatePreferenceErrorState({required this.errorMessage});
}

final class UpdatePreferenceSuccessState extends OrganizationState {
  final PreferenceUpdateMainResEntity preferenceUpdateMainResEntity;
  UpdatePreferenceSuccessState({required this.preferenceUpdateMainResEntity});
}
// Update preference

// get preference
final class GetPreferenceLoadingState extends OrganizationState {}

final class GetPreferenceErrorState extends OrganizationState {
  final String errorMessage;
  GetPreferenceErrorState({required this.errorMessage});
}

final class GetPreferenceSuccessState extends OrganizationState {
  final PreferenceMainResEntity preferenceMainResEntity;
  GetPreferenceSuccessState({required this.preferenceMainResEntity});
}
// get organization

// Update organization column settings
final class UpdateColumnSettingsLoadingState extends OrganizationState {}

final class UpdateColumnSettingsErrorState extends OrganizationState {
  final String errorMessage;
  UpdateColumnSettingsErrorState({required this.errorMessage});
}

final class UpdateColumnSettingsSuccessState extends OrganizationState {
  final PreferenceUpdateMainResEntity preferenceUpdateMainResEntity;
  UpdateColumnSettingsSuccessState(
      {required this.preferenceUpdateMainResEntity});
}
// Update organization column settings

// Update organization estimate settings
final class UpdateEstimateSettingsLoadingState extends OrganizationState {}

final class UpdateEstimateSettingsErrorState extends OrganizationState {
  final String errorMessage;
  UpdateEstimateSettingsErrorState({required this.errorMessage});
}

final class UpdateEstimateSettingsSuccessState extends OrganizationState {
  final PreferenceUpdateMainResEntity preferenceUpdateMainResEntity;
  UpdateEstimateSettingsSuccessState(
      {required this.preferenceUpdateMainResEntity});
}
// Update organization estimate settings

// Update organization invoice settings
final class UpdateInvoiceSettingsLoadingState extends OrganizationState {}

final class UpdateInvoiceSettingsErrorState extends OrganizationState {
  final String errorMessage;
  UpdateInvoiceSettingsErrorState({required this.errorMessage});
}

final class UpdateInvoiceSettingsSuccessState extends OrganizationState {
  final PreferenceUpdateMainResEntity preferenceUpdateMainResEntity;
  UpdateInvoiceSettingsSuccessState(
      {required this.preferenceUpdateMainResEntity});
}
// Update organization invoice settings

// Update organization general settings
final class UpdateGeneralSettingsLoadingState extends OrganizationState {}

final class UpdateGeneralSettingsErrorState extends OrganizationState {
  final String errorMessage;
  UpdateGeneralSettingsErrorState({required this.errorMessage});
}

final class UpdateGeneralSettingsSuccessState extends OrganizationState {
  final PreferenceUpdateMainResEntity preferenceUpdateMainResEntity;
  UpdateGeneralSettingsSuccessState(
      {required this.preferenceUpdateMainResEntity});
}
// Update organization general settings
