import 'package:billbooks_app/core/error/failures.dart';
import 'package:billbooks_app/core/usecase/usecase.dart';
import 'package:billbooks_app/features/more/settings/domain/repository/organization_repository.dart';
import 'package:fpdart/fpdart.dart';

import '../entity/preference_update_entity.dart';

class UpdatePrefInvoiceUsecase
    implements
        UseCase<PreferenceUpdateMainResEntity, UpdatePrefInvoiceReqParams> {
  final OrganizationRepository organizationRepository;
  UpdatePrefInvoiceUsecase({required this.organizationRepository});

  @override
  Future<Either<Failure, PreferenceUpdateMainResEntity>> call(
      UpdatePrefInvoiceReqParams params) {
    return organizationRepository.updateInvoiceSettings(params);
  }
}

class UpdatePrefInvoiceReqParams {
  /*
  invoice_heading:
invoice_no:
invoice_template:
invoice_terms:
invoice_notes:
payment_terms
  */
  final String heading;
  final String number;
  final String terms;
  final String template;
  final String notes;
  final String paymentTerms;
  UpdatePrefInvoiceReqParams({
    required this.heading,
    required this.number,
    required this.notes,
    required this.paymentTerms,
    required this.template,
    required this.terms,
  });
}
