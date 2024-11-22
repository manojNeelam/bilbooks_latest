part of 'accountrecivable_bloc.dart';

@immutable
sealed class AccountrecivableEvent {}

class GetAccountReceivablesEvent extends AccountrecivableEvent {
  final AccountReceivablesUsecaseReqParams params;
  GetAccountReceivablesEvent({required this.params});
}
