import 'dart:io';

import 'package:billbooks_app/core/error/failures.dart';
import 'package:billbooks_app/core/usecase/usecase.dart';
import 'package:billbooks_app/features/more/settings/domain/repository/organization_repository.dart';
import 'package:fpdart/fpdart.dart';

import '../entity/preference_update_entity.dart';

class UpdatePrefGeneralUsecase
    implements
        UseCase<PreferenceUpdateMainResEntity, UpdatePrefGeneralReqParams> {
  final OrganizationRepository organizationRepository;
  UpdatePrefGeneralUsecase({required this.organizationRepository});

  @override
  Future<Either<Failure, PreferenceUpdateMainResEntity>> call(
      UpdatePrefGeneralReqParams params) {
    return organizationRepository.updateGeneralSettings(params);
  }
}

class UpdatePrefGeneralReqParams {
  final String portalName,
      fiscalYear,
      currency,
      language,
      dateFormat,
      numberFormat,
      paperSize;
  final bool attachPdf,
      notifyInvoiceViewed,
      notifyApproveDeclined,
      notifyPayOnline;
  UpdatePrefGeneralReqParams({
    required this.portalName,
    required this.numberFormat,
    required this.paperSize,
    required this.attachPdf,
    required this.notifyApproveDeclined,
    required this.notifyPayOnline,
    required this.notifyInvoiceViewed,
    required this.fiscalYear,
    required this.currency,
    required this.language,
    required this.dateFormat,
  });
}
