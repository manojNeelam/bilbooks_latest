part of 'subscription_bloc.dart';

@immutable
sealed class SubscriptionEvent {}

class GetSubscriptionEvent extends SubscriptionEvent {
  final SubscriptionReqParams params;

  GetSubscriptionEvent({required this.params});
}
