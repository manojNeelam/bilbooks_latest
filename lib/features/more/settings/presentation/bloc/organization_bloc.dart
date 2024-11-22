import 'package:billbooks_app/features/more/settings/domain/entity/organization_details_entity.dart';
import 'package:billbooks_app/features/more/settings/domain/entity/preference_details_entity.dart';
import 'package:billbooks_app/features/more/settings/domain/entity/preference_update_entity.dart';
import 'package:billbooks_app/features/more/settings/domain/entity/update_organization_entity.dart';
import 'package:billbooks_app/features/more/settings/domain/usecase/organization_list_usecase.dart';
import 'package:billbooks_app/features/more/settings/domain/usecase/preference_details_usecase.dart';
import 'package:billbooks_app/features/more/settings/domain/usecase/preference_update_usecase.dart';
import 'package:billbooks_app/features/more/settings/domain/usecase/update_organization_usecase.dart';
import 'package:billbooks_app/features/more/settings/domain/usecase/update_pref_general_usecase.dart';
import 'package:billbooks_app/features/more/settings/domain/usecase/update_pref_invoice_usecase.dart';
import 'package:billbooks_app/features/more/settings/domain/usecase/update_preference_column_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecase/update_preference_estimate_usecase.dart';

part 'organization_event.dart';
part 'organization_state.dart';

class OrganizationBloc extends Bloc<OrganizationEvent, OrganizationState> {
  final OrganizationListUsecase _organizationListUsecase;
  final UpdateOrganizationUsecase _updateOrganizationUsecase;
  final PreferenceUpdateUsecase _preferenceUpdateUsecase;
  final PreferenceDetailsUsecase _preferenceDetailsUsecase;
  final UpdatePreferenceColumnUsecase _updatePreferenceColumnUsecase;
  final UpdatePreferenceEstimateUsecase _updatePreferenceEstimateUsecase;
  final UpdatePrefGeneralUsecase _updatePrefGeneralUsecase;
  final UpdatePrefInvoiceUsecase _updatePrefInvoiceUsecase;

  OrganizationBloc({
    required OrganizationListUsecase organizationListUsecase,
    required UpdateOrganizationUsecase updateOrganizationUsecase,
    required PreferenceUpdateUsecase preferenceUpdateUsecase,
    required PreferenceDetailsUsecase preferenceDetailsUsecase,
    required UpdatePreferenceColumnUsecase updatePreferenceColumnUsecase,
    required UpdatePreferenceEstimateUsecase updatePreferenceEstimateUsecase,
    required UpdatePrefGeneralUsecase updatePrefGeneralUsecase,
    required UpdatePrefInvoiceUsecase updatePrefInvoiceUsecase,
  })  : _preferenceUpdateUsecase = preferenceUpdateUsecase,
        _organizationListUsecase = organizationListUsecase,
        _updateOrganizationUsecase = updateOrganizationUsecase,
        _preferenceDetailsUsecase = preferenceDetailsUsecase,
        _updatePreferenceColumnUsecase = updatePreferenceColumnUsecase,
        _updatePreferenceEstimateUsecase = updatePreferenceEstimateUsecase,
        _updatePrefGeneralUsecase = updatePrefGeneralUsecase,
        _updatePrefInvoiceUsecase = updatePrefInvoiceUsecase,
        super(OrganizationInitial()) {
    on<GetOrganizationDetailsEvent>((event, emit) async {
      emit(OrganizationLoadingState());
      final response =
          await _organizationListUsecase.call(event.organizationReqParams);
      response.fold(
          (l) => emit(OrganizationErrorState(errorMessage: l.message)),
          (r) => emit(
              OrganizationSuccessState(organizationDetailsMainResEntity: r)));
    });

    on<UpdateOrganizationDetailsEvent>((event, emit) async {
      emit(UpdateOrganizationLoadingState());
      final response = await _updateOrganizationUsecase
          .call(event.updateOrganizationReqParams);
      response.fold(
          (l) => emit(UpdateOrganizationErrorState(errorMessage: l.message)),
          (r) => emit(UpdateOrganizationSuccessState(
              updateOrganizationMainResEntity: r)));
    });

    on<UpdatePreferenceDetailsEvent>((event, emit) async {
      emit(UpdatePreferenceLoadingState());
      final response =
          await _preferenceUpdateUsecase.call(event.preferenceUpdateReqParams);
      response.fold(
          (l) => emit(UpdatePreferenceErrorState(errorMessage: l.message)),
          (r) => emit(
              UpdatePreferenceSuccessState(preferenceUpdateMainResEntity: r)));
    });

    on<GetPreferenceDetailsEvent>((event, emit) async {
      emit(GetPreferenceLoadingState());
      final response = await _preferenceDetailsUsecase
          .call(event.preferenceDetailsReqParams);
      response.fold(
          (l) => emit(GetPreferenceErrorState(errorMessage: l.message)),
          (r) => emit(GetPreferenceSuccessState(preferenceMainResEntity: r)));
    });

    on<UpdatePreferenceColumnDetailsEvent>((event, emit) async {
      emit(UpdateColumnSettingsLoadingState());
      final response = await _updatePreferenceColumnUsecase
          .call(event.preferenceUpdateReqParams);
      response.fold(
          (l) => emit(UpdateColumnSettingsErrorState(errorMessage: l.message)),
          (r) => emit(UpdateColumnSettingsSuccessState(
              preferenceUpdateMainResEntity: r)));
    });

    on<UpdatePreferenceEstimateDetailsEvent>((event, emit) async {
      emit(UpdateEstimateSettingsLoadingState());
      final response = await _updatePreferenceEstimateUsecase
          .call(event.preferenceUpdateReqParams);
      response.fold(
          (l) =>
              emit(UpdateEstimateSettingsErrorState(errorMessage: l.message)),
          (r) => emit(UpdateEstimateSettingsSuccessState(
              preferenceUpdateMainResEntity: r)));
    });

    on<UpdatePreferenceInvoiceDetailsEvent>((event, emit) async {
      emit(UpdateInvoiceSettingsLoadingState());
      final response =
          await _updatePrefInvoiceUsecase.call(event.preferenceUpdateReqParams);
      response.fold(
          (l) => emit(UpdateInvoiceSettingsErrorState(errorMessage: l.message)),
          (r) => emit(UpdateInvoiceSettingsSuccessState(
              preferenceUpdateMainResEntity: r)));
    });

    on<UpdatePreferenceGeneralDetailsEvent>((event, emit) async {
      emit(UpdateGeneralSettingsLoadingState());
      final response =
          await _updatePrefGeneralUsecase.call(event.preferenceUpdateReqParams);
      response.fold(
          (l) => emit(UpdateGeneralSettingsErrorState(errorMessage: l.message)),
          (r) => emit(UpdateGeneralSettingsSuccessState(
              preferenceUpdateMainResEntity: r)));
    });
  }
}
