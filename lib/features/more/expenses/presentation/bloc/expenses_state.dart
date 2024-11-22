part of 'expenses_bloc.dart';

@immutable
sealed class ExpensesState {}

final class ExpensesInitial extends ExpensesState {}

final class ExpensesListLoadingState extends ExpensesState {}

final class ExpensesListErrorState extends ExpensesState {
  final String errorMessage;
  ExpensesListErrorState({required this.errorMessage});
}

final class ExpensesListSuccessState extends ExpensesState {
  final ExpensesListMainResEntity expensesListMainResEntity;
  ExpensesListSuccessState({required this.expensesListMainResEntity});
}

final class AddExpensesLoadingState extends ExpensesState {}

final class AddExpensesErrorState extends ExpensesState {
  final String errorMessage;
  AddExpensesErrorState({required this.errorMessage});
}

final class AddExpensesSuccessState extends ExpensesState {
  final AddExpensesMainResEntity addExpensesMainResEntity;
  AddExpensesSuccessState({required this.addExpensesMainResEntity});
}

final class DeleteExpensesLoadingState extends ExpensesState {}

final class DeleteExpensesErrorState extends ExpensesState {
  final String errorMessage;
  DeleteExpensesErrorState({required this.errorMessage});
}

final class DeleteExpensesSuccessState extends ExpensesState {
  final DeleteExpensesMainResEntity deleteExpensesMainResEntity;
  DeleteExpensesSuccessState({required this.deleteExpensesMainResEntity});
}
