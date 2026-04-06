part of 'proforma_bloc.dart';

@immutable
sealed class ProformaState {}

final class ProformaInitial extends ProformaState {}

class ProformaListLoadingState extends ProformaState {}

class ProformaListSuccessState extends ProformaState {
  final ProformaListMainResEntity proformaListMainResEntity;

  ProformaListSuccessState({required this.proformaListMainResEntity});
}

class ProformaListFailureState extends ProformaState {
  final String errorMessage;

  ProformaListFailureState({required this.errorMessage});
}

class ProformaDetailsLoadingState extends ProformaState {}

class ProformaDetailsSuccessState extends ProformaState {
  final ProformaDetailResEntity proformaDetailResEntity;

  ProformaDetailsSuccessState({required this.proformaDetailResEntity});
}

class ProformaDetailsFailureState extends ProformaState {
  final String errorMessage;

  ProformaDetailsFailureState({required this.errorMessage});
}
