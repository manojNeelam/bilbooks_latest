part of 'totalincomes_bloc.dart';

@immutable
sealed class TotalincomesState {}

final class TotalincomesInitial extends TotalincomesState {}

class TotalIncomesLoadingState extends TotalincomesState {}

class TotalIncomesErrorState extends TotalincomesState {
  final String errorMessage;
  TotalIncomesErrorState({required this.errorMessage});
}

class TotalIncomesSuccessState extends TotalincomesState {
  final TotalIncomesMainResEntity totalIncomesMainResEntity;
  TotalIncomesSuccessState({required this.totalIncomesMainResEntity});
}
//END