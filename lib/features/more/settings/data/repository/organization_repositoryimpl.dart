import 'package:billbooks_app/core/error/failures.dart';
import 'package:billbooks_app/features/more/settings/data/model/preference_update_model.dart';
import 'package:billbooks_app/features/more/settings/data/remote/organization_remote_datasource.dart';
import 'package:billbooks_app/features/more/settings/domain/entity/preference_update_entity.dart';
import 'package:billbooks_app/features/more/settings/domain/repository/organization_repository.dart';
import 'package:billbooks_app/features/more/settings/domain/usecase/organization_list_usecase.dart';
import 'package:billbooks_app/features/more/settings/domain/usecase/preference_details_usecase.dart';
import 'package:billbooks_app/features/more/settings/domain/usecase/preference_update_usecase.dart';
import 'package:billbooks_app/features/more/settings/domain/usecase/update_organization_usecase.dart';
import 'package:billbooks_app/features/more/settings/domain/usecase/update_pref_general_usecase.dart';
import 'package:billbooks_app/features/more/settings/domain/usecase/update_pref_invoice_usecase.dart';
import 'package:billbooks_app/features/more/settings/domain/usecase/update_preference_column_usecase.dart';
import 'package:billbooks_app/features/more/settings/domain/usecase/update_preference_estimate_usecase.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../../core/api/api_exception.dart';
import '../model/organization_details_model.dart';
import '../model/preference_details_model.dart';
import '../model/update_organization_model.dart';

class OrganizationRepositoryimpl implements OrganizationRepository {
  final OrganizationRemoteDatasource organizationRemoteDatasource;
  OrganizationRepositoryimpl({required this.organizationRemoteDatasource});
  @override
  Future<Either<Failure, OrganizationDetailsMainResModel>>
      getOrganizationDetails(OrganizationReqParams params) async {
    try {
      final responseBody =
          await organizationRemoteDatasource.getOrganizationDetails(params);
      return right(responseBody);
    } on ApiException catch (e) {
      return left(Failure(e.message));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UpdateOrganizationMainResModel>>
      updateOrganizationDetails(UpdateOrganizationReqParams params) async {
    try {
      final responseBody =
          await organizationRemoteDatasource.updateOrganizationDetails(params);
      return right(responseBody);
    } on ApiException catch (e) {
      return left(Failure(e.message));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, PreferenceUpdateMainResModel>> updatePreferenceDetails(
      PreferenceUpdateReqParams params) async {
    try {
      final responseBody =
          await organizationRemoteDatasource.updatePreferenceDetails(params);
      return right(responseBody);
    } on ApiException catch (e) {
      return left(Failure(e.message));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, PreferenceMainResModel>> getPreference(
      PreferenceDetailsReqParams params) async {
    try {
      final responseBody =
          await organizationRemoteDatasource.getPreferenceDetails(params);
      return right(responseBody);
    } on ApiException catch (e) {
      return left(Failure(e.message));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, PreferenceUpdateMainResModel>> updateColumnSettings(
      UpdatePreferenceColumnReqParams params) async {
    try {
      final responseBody =
          await organizationRemoteDatasource.updateColumnSettingss(params);
      return right(responseBody);
    } on ApiException catch (e) {
      return left(Failure(e.message));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, PreferenceUpdateMainResModel>> updateEstimateSettings(
      UpdatePreferenceEstimateReqParams params) async {
    try {
      final responseBody =
          await organizationRemoteDatasource.updateEstimateSettingss(params);
      return right(responseBody);
    } on ApiException catch (e) {
      return left(Failure(e.message));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, PreferenceUpdateMainResEntity>> updateGeneralSettings(
      UpdatePrefGeneralReqParams params) async {
    try {
      final responseBody =
          await organizationRemoteDatasource.updateGeneralSettingss(params);
      return right(responseBody);
    } on ApiException catch (e) {
      return left(Failure(e.message));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, PreferenceUpdateMainResEntity>> updateInvoiceSettings(
      UpdatePrefInvoiceReqParams params) async {
    try {
      final responseBody =
          await organizationRemoteDatasource.updateInvoiceSettingss(params);
      return right(responseBody);
    } on ApiException catch (e) {
      return left(Failure(e.message));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
