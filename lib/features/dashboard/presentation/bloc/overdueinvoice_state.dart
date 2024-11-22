part of 'overdueinvoice_bloc.dart';

@immutable
sealed class OverdueinvoiceState {}

final class OverdueinvoiceInitial extends OverdueinvoiceState {}

class OverdueInvoicesLoadingState extends OverdueinvoiceState {}

class OverdueInvoicesErrorState extends OverdueinvoiceState {
  final String errorMessage;
  OverdueInvoicesErrorState({required this.errorMessage});
}

class OverdueInvoicesSuccessState extends OverdueinvoiceState {
  final OverdueInvoiceMainResEntity overdueInvoiceMainResEntity;
  OverdueInvoicesSuccessState({required this.overdueInvoiceMainResEntity});
}
