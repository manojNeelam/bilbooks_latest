part of 'tax_bloc.dart';

@immutable
sealed class TaxState {}

final class TaxInitial extends TaxState {}

final class TaxListLoadingState extends TaxState {}

final class TaxListErrorState extends TaxState {
  final String errorMessage;

  TaxListErrorState({required this.errorMessage});
}

final class TaxListSuccessState extends TaxState {
  final TaxListResEntity taxListResEntity;

  TaxListSuccessState({required this.taxListResEntity});
}

final class AddTaxLoadState extends TaxState {}

final class AddTaxErrorState extends TaxState {
  final String errorMessage;

  AddTaxErrorState({required this.errorMessage});
}

final class SuccessAddTax extends TaxState {
  final TaxAddMainResEntity taxAddMainResEntity;
  SuccessAddTax({required this.taxAddMainResEntity});
}

final class TaxDeleteWaitingState extends TaxState {}

final class TaxDeleteErrorState extends TaxState {
  final String errorMessage;

  TaxDeleteErrorState({required this.errorMessage});
}

final class SuccessDeleteTax extends TaxState {
  final TaxDeleteMainResEnity taxDeleteMainResEnity;
  SuccessDeleteTax({required this.taxDeleteMainResEnity});
}
