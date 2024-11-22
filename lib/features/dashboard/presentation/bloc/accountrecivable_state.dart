part of 'accountrecivable_bloc.dart';

@immutable
sealed class AccountrecivableState {}

final class AccountrecivableInitial extends AccountrecivableState {}

class AccountReceivablesLoadingState extends AccountrecivableState {}

class AccountReceivablesErrorState extends AccountrecivableState {
  final String errorMessage;
  AccountReceivablesErrorState({required this.errorMessage});
}

class AccountReceivablesSuccessState extends AccountrecivableState {
  final AccountsReceivablesMainResEntity accountsReceivablesMainResEntity;
  AccountReceivablesSuccessState(
      {required this.accountsReceivablesMainResEntity});
}
