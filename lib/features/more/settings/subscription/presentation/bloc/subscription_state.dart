part of 'subscription_bloc.dart';

@immutable
sealed class SubscriptionState {}

final class SubscriptionInitial extends SubscriptionState {}

final class SubscriptionLoadingState extends SubscriptionState {}

final class SubscriptionErrorState extends SubscriptionState {
  final String errorMessage;

  SubscriptionErrorState({required this.errorMessage});
}

final class SubscriptionSuccessState extends SubscriptionState {
  final SubscriptionMainResponseEntity subscriptionEntity;

  SubscriptionSuccessState({required this.subscriptionEntity});
}
