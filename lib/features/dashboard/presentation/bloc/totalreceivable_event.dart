part of 'totalreceivable_bloc.dart';

@immutable
sealed class TotalreceivableEvent {}

class GetTotalReceivablesEvent extends TotalreceivableEvent {
  final TotalReceivablesUsecaseReqParams params;
  GetTotalReceivablesEvent({required this.params});
}
