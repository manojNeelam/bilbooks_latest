part of 'general_bloc.dart';

@immutable
sealed class GeneralEvent {}

final class SetEstimateHeading extends GeneralEvent {
  final String estimateHeading;
  SetEstimateHeading({required this.estimateHeading});
}
