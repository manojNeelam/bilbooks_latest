import 'package:billbooks_app/core/error/failures.dart';
import 'package:billbooks_app/features/notifications/domain/entities/notifcation_entity.dart';
import 'package:billbooks_app/features/notifications/domain/usecase/notification_list_usercase.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class NotificationRepository {
  Future<Either<Failure, NotificationMainResponseEntity>> getActivities(
      NotificationListUsercaseReqParams reqParams);
}
