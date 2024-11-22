part of 'organization_bloc.dart';

@immutable
sealed class OrganizationEvent {}

final class GetOrganizationDetailsEvent extends OrganizationEvent {
  final OrganizationReqParams organizationReqParams;
  GetOrganizationDetailsEvent({required this.organizationReqParams});
}

final class UpdateOrganizationDetailsEvent extends OrganizationEvent {
  final UpdateOrganizationReqParams updateOrganizationReqParams;
  UpdateOrganizationDetailsEvent({required this.updateOrganizationReqParams});
}

final class GetPreferenceDetailsEvent extends OrganizationEvent {
  final PreferenceDetailsReqParams preferenceDetailsReqParams;
  GetPreferenceDetailsEvent({required this.preferenceDetailsReqParams});
}

final class UpdatePreferenceDetailsEvent extends OrganizationEvent {
  final PreferenceUpdateReqParams preferenceUpdateReqParams;
  UpdatePreferenceDetailsEvent({required this.preferenceUpdateReqParams});
}

final class UpdatePreferenceColumnDetailsEvent extends OrganizationEvent {
  final UpdatePreferenceColumnReqParams preferenceUpdateReqParams;
  UpdatePreferenceColumnDetailsEvent({required this.preferenceUpdateReqParams});
}

final class UpdatePreferenceEstimateDetailsEvent extends OrganizationEvent {
  final UpdatePreferenceEstimateReqParams preferenceUpdateReqParams;
  UpdatePreferenceEstimateDetailsEvent(
      {required this.preferenceUpdateReqParams});
}

final class UpdatePreferenceInvoiceDetailsEvent extends OrganizationEvent {
  final UpdatePrefInvoiceReqParams preferenceUpdateReqParams;
  UpdatePreferenceInvoiceDetailsEvent(
      {required this.preferenceUpdateReqParams});
}

final class UpdatePreferenceGeneralDetailsEvent extends OrganizationEvent {
  final UpdatePrefGeneralReqParams preferenceUpdateReqParams;
  UpdatePreferenceGeneralDetailsEvent(
      {required this.preferenceUpdateReqParams});
}
