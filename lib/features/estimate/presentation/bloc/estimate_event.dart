part of 'estimate_bloc.dart';

@immutable
sealed class EstimateEvent {}

final class GetEstimateListEvent extends EstimateEvent {
  final EstimateListReqParams estimateListReqParams;
  GetEstimateListEvent({required this.estimateListReqParams});
}

final class GetEstimateDetailsEvent extends EstimateEvent {
  final EstimateDetailUsecaseReqParams estimateDetailUsecaseReqParams;
  GetEstimateDetailsEvent({required this.estimateDetailUsecaseReqParams});
}
