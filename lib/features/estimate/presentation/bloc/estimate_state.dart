part of 'estimate_bloc.dart';

@immutable
sealed class EstimateState {}

final class EstimateInitial extends EstimateState {}

final class EstimateListLoadingState extends EstimateState {}

final class EstimateListSuccessState extends EstimateState {
  final EstimateListMainResEntity estimateListMainResEntity;
  EstimateListSuccessState({required this.estimateListMainResEntity});
}

final class EstimateListErrorState extends EstimateState {
  final String errorMessage;
  EstimateListErrorState({required this.errorMessage});
}

final class EstimateDetailsLoadingState extends EstimateState {}

final class EstimateDetailsSuccessState extends EstimateState {
  final InvoiceDetailsResponseEntity invoiceDetailsResponseEntity;
  EstimateDetailsSuccessState({required this.invoiceDetailsResponseEntity});
}

final class EstimateDetailsErrorState extends EstimateState {
  final String errorMessage;
  EstimateDetailsErrorState({required this.errorMessage});
}
