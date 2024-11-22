import 'package:billbooks_app/core/error/failures.dart';
import 'package:billbooks_app/core/usecase/usecase.dart';
import 'package:billbooks_app/features/more/settings/domain/repository/organization_repository.dart';
import 'package:fpdart/fpdart.dart';
import '../entity/preference_update_entity.dart';

class PreferenceUpdateUsecase
    implements
        UseCase<PreferenceUpdateMainResEntity, PreferenceUpdateReqParams> {
  final OrganizationRepository organizationRepository;
  PreferenceUpdateUsecase({required this.organizationRepository});
  @override
  Future<Either<Failure, PreferenceUpdateMainResEntity>> call(
      PreferenceUpdateReqParams params) {
    return organizationRepository.updatePreferenceDetails(params);
  }
}

class PreferenceUpdateReqParams {
  final String? type;
  final String? portal_name;
  final String? invoice_heading;
  final String? payment_terms;
  final String? payment_terms_custom;
  final String? date_format;
  final String? number_format;
  final String? paper_size;
  final String? attach_pdf;
  final String? invoice_no;
  final String? invoice_template;
  final String? invoice_terms;
  final String? invoice_notes;
  final String? estimate_heading;
  final String? estimate_no;
  final String? estimate_template;
  final String? estimate_terms;
  final String? estimate_notes;
  final String? billbooks_branding;
  final String? themes;
  final String? column_layout;
  final String? column_items_title;
  final String? column_items_other;
  final String? column_units_title;
  final String? column_units_other;
  final String? column_rate_title;
  final String? column_rate_other;
  final String? column_amount_title;
  final String? column_amount_other;
  final String? column_date;
  final String? column_time;
  final String? column_custom;
  final String? column_custom_title;
  final String? hide_column_qty;
  final String? hide_column_rate;
  final String? hide_column_amount;
  final String? notified_viewed_invoices_estimates;
  final String? notified_approved_declined_estimates;
  final String? notified_payonline;
  final String? fiscal_year;
  final String? currency;
  final String? language;
  PreferenceUpdateReqParams(
      this.type,
      this.portal_name,
      this.invoice_heading,
      this.payment_terms,
      this.payment_terms_custom,
      this.date_format,
      this.number_format,
      this.paper_size,
      this.invoice_no,
      this.invoice_template,
      this.invoice_terms,
      this.invoice_notes,
      this.estimate_heading,
      this.estimate_no,
      this.estimate_template,
      this.estimate_terms,
      this.estimate_notes,
      this.themes,
      this.column_layout,
      this.column_items_title,
      this.column_items_other,
      this.column_units_title,
      this.column_units_other,
      this.column_rate_title,
      this.column_rate_other,
      this.column_date,
      this.column_time,
      this.column_custom_title,
      this.hide_column_qty,
      this.hide_column_rate,
      this.hide_column_amount,
      this.notified_viewed_invoices_estimates,
      this.notified_approved_declined_estimates,
      this.notified_payonline,
      this.fiscal_year,
      this.currency,
      this.language,
      this.attach_pdf,
      this.billbooks_branding,
      this.column_amount_title,
      this.column_amount_other,
      this.column_custom);
}
