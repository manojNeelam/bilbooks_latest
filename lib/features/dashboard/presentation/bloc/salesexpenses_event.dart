part of 'salesexpenses_bloc.dart';

@immutable
sealed class SalesexpensesEvent {}

class GetSalesExpensesEvent extends SalesexpensesEvent {
  final SalesExpensesUsecaseReqParams params;
  GetSalesExpensesEvent({required this.params});
}
