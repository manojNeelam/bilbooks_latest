part of 'notification_bloc.dart';

@immutable
sealed class NotificationEvent {}

class GetNotificationsEvent implements NotificationEvent {
  final NotificationListUsercaseReqParams params;
  GetNotificationsEvent({required this.params});
}
