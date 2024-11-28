part of 'general_bloc.dart';

@immutable
sealed class GeneralState {}

final class GeneralInitial extends GeneralState {}

final class EstimateHeadingState extends GeneralState {
  final String estimateHeading;
  EstimateHeadingState({required this.estimateHeading});
}
