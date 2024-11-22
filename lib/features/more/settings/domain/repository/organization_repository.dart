import 'package:billbooks_app/features/more/settings/domain/entity/organization_details_entity.dart';
import 'package:billbooks_app/features/more/settings/domain/entity/preference_details_entity.dart';
import 'package:billbooks_app/features/more/settings/domain/entity/preference_update_entity.dart';
import 'package:billbooks_app/features/more/settings/domain/entity/update_organization_entity.dart';
import 'package:billbooks_app/features/more/settings/domain/usecase/organization_list_usecase.dart';
import 'package:billbooks_app/features/more/settings/domain/usecase/preference_details_usecase.dart';
import 'package:billbooks_app/features/more/settings/domain/usecase/preference_update_usecase.dart';
import 'package:billbooks_app/features/more/settings/domain/usecase/update_organization_usecase.dart';
import 'package:billbooks_app/features/more/settings/domain/usecase/update_pref_invoice_usecase.dart';
import 'package:billbooks_app/features/more/settings/domain/usecase/update_preference_column_usecase.dart';
import 'package:billbooks_app/features/more/settings/presentation/bloc/organization_bloc.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../../core/error/failures.dart';
import '../../data/model/preference_update_model.dart';
import '../usecase/update_pref_general_usecase.dart';
import '../usecase/update_preference_estimate_usecase.dart';

abstract interface class OrganizationRepository {
  Future<Either<Failure, OrganizationDetailsMainResEntity>>
      getOrganizationDetails(OrganizationReqParams params);
  Future<Either<Failure, UpdateOrganizationMainResEntity>>
      updateOrganizationDetails(UpdateOrganizationReqParams params);
  Future<Either<Failure, PreferenceUpdateMainResEntity>>
      updatePreferenceDetails(PreferenceUpdateReqParams params);
  Future<Either<Failure, PreferenceMainResEntity>> getPreference(
      PreferenceDetailsReqParams params);

  Future<Either<Failure, PreferenceUpdateMainResModel>> updateColumnSettings(
      UpdatePreferenceColumnReqParams params);

  Future<Either<Failure, PreferenceUpdateMainResEntity>> updateEstimateSettings(
      UpdatePreferenceEstimateReqParams params);

  Future<Either<Failure, PreferenceUpdateMainResEntity>> updateInvoiceSettings(
      UpdatePrefInvoiceReqParams params);
  Future<Either<Failure, PreferenceUpdateMainResEntity>> updateGeneralSettings(
      UpdatePrefGeneralReqParams params);
}
