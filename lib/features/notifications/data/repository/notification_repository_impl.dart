import 'package:billbooks_app/core/error/failures.dart';
import 'package:billbooks_app/features/notifications/data/datasource/remote/notification_datasource.dart';
import 'package:billbooks_app/features/notifications/domain/entities/notifcation_entity.dart';
import 'package:billbooks_app/features/notifications/domain/repository/notification_repository.dart';
import 'package:billbooks_app/features/notifications/domain/usecase/notification_list_usercase.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/api/api_exception.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationRemoteDatasource notificationRemoteDatasourceImpl;
  NotificationRepositoryImpl({required this.notificationRemoteDatasourceImpl});
  @override
  Future<Either<Failure, NotificationMainResponseEntity>> getActivities(
      NotificationListUsercaseReqParams reqParams) async {
    try {
      final resDataModel =
          await notificationRemoteDatasourceImpl.getList(reqParams);
      return right(resDataModel);
    } on ApiException catch (e) {
      return left(Failure(e.message));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
