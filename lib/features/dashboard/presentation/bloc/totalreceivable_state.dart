part of 'totalreceivable_bloc.dart';

@immutable
sealed class TotalreceivableState {}

final class TotalreceivableInitial extends TotalreceivableState {}

class TotalReceivablesLoadingState extends TotalreceivableState {}

class TotalReceivablesErrorState extends TotalreceivableState {
  final String errorMessage;
  TotalReceivablesErrorState({required this.errorMessage});
}

class TotalReceivablesSuccessState extends TotalreceivableState {
  final TotalReceivablesMainResEntity totalReceivablesMainResEntity;
  TotalReceivablesSuccessState({required this.totalReceivablesMainResEntity});
}

//END