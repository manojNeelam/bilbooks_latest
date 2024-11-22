part of 'totalincomes_bloc.dart';

@immutable
sealed class TotalincomesEvent {}

class GetTotalIncomesEvent extends TotalincomesEvent {
  final TotalIncomesUsecaseReqParams params;
  GetTotalIncomesEvent({required this.params});
}
