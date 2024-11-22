part of 'salesexpenses_bloc.dart';

@immutable
sealed class SalesexpensesState {}

final class SalesexpensesInitial extends SalesexpensesState {}

class SalesExpensesLoadingState extends SalesexpensesState {}

class SalesExpensesErrorState extends SalesexpensesState {
  final String errorMessage;
  SalesExpensesErrorState({required this.errorMessage});
}

class SalesExpensesSuccessState extends SalesexpensesState {
  final SalesExpensesMainResEntity salesExpensesMainResEntity;
  SalesExpensesSuccessState({required this.salesExpensesMainResEntity});
}
