import 'package:billbooks_app/core/error/failures.dart';
import 'package:billbooks_app/core/usecase/usecase.dart';
import 'package:billbooks_app/features/notifications/domain/entities/notifcation_entity.dart';
import 'package:billbooks_app/features/notifications/domain/repository/notification_repository.dart';
import 'package:fpdart/fpdart.dart';

class NotificationListUsercase
    implements
        UseCase<NotificationMainResponseEntity,
            NotificationListUsercaseReqParams> {
  final NotificationRepository notificationRepository;

  NotificationListUsercase({required this.notificationRepository});
  @override
  Future<Either<Failure, NotificationMainResponseEntity>> call(
      NotificationListUsercaseReqParams params) {
    return notificationRepository.getActivities(params);
  }
}

class NotificationListUsercaseReqParams {}
