part of 'tax_bloc.dart';

@immutable
sealed class TaxEvent {}

final class GetTaxList extends TaxEvent {}

final class AddTaxEvent extends TaxEvent {
  final String taxName;
  final String rate;
  final String? id;
  AddTaxEvent({required this.taxName, required this.rate, this.id});
}

final class DeleteTaxEvent extends TaxEvent {
  final String taxId;
  DeleteTaxEvent({required this.taxId});
}
