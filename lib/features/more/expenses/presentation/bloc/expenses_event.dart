part of 'expenses_bloc.dart';

@immutable
sealed class ExpensesEvent {}

final class GetExpensesList extends ExpensesEvent {
  final ExpensesListRequestParams params;
  GetExpensesList({required this.params});
}

final class AddExpensesEvent extends ExpensesEvent {
  final NewExpensesParams params;
  AddExpensesEvent({required this.params});
}

final class DeleteExpenseEvent extends ExpensesEvent {
  final DeleteExpenseReqParams params;
  DeleteExpenseEvent({required this.params});
}
