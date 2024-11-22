part of 'overdueinvoice_bloc.dart';

@immutable
sealed class OverdueinvoiceEvent {}

class GetOverdueInvoicesEvent extends OverdueinvoiceEvent {
  final OverdueInvoiceUsecaseReqParams params;
  GetOverdueInvoicesEvent({required this.params});
}
