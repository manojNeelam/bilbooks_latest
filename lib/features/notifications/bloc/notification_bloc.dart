import 'package:billbooks_app/features/notifications/domain/entities/notifcation_entity.dart';
import 'package:billbooks_app/features/notifications/domain/usecase/notification_list_usercase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final NotificationListUsercase _notificationListUsercase;

  NotificationBloc({required NotificationListUsercase notificationListUsercase})
      : _notificationListUsercase = notificationListUsercase,
        super(NotificationInitial()) {
    on<GetNotificationsEvent>((event, emit) async {
      emit(NotificationListLoading());
      final response = await _notificationListUsercase.call(event.params);
      response.fold(
          (l) => emit(NotificationListErrorState(errorMessage: l.message)),
          (r) => emit(
              NotificationListSuccessState(notificationMainResponseEntity: r)));
    });
  }
}
