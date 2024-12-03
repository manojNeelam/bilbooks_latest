part of 'notification_bloc.dart';

@immutable
sealed class NotificationState {}

final class NotificationInitial extends NotificationState {}

final class NotificationListLoading extends NotificationState {}

final class NotificationListErrorState extends NotificationState {
  final String errorMessage;
  NotificationListErrorState({required this.errorMessage});
}

final class NotificationListSuccessState extends NotificationState {
  final NotificationMainResponseEntity notificationMainResponseEntity;
  NotificationListSuccessState({required this.notificationMainResponseEntity});
}
