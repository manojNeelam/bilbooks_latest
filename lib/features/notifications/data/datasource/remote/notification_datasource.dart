import 'package:billbooks_app/features/notifications/data/model/notifcation_model.dart';
import 'package:billbooks_app/features/notifications/domain/usecase/notification_list_usercase.dart';
import 'package:flutter/material.dart';

import '../../../../../core/api/api_client.dart';
import '../../../../../core/api/api_endpoint_urls.dart';
import '../../../../../core/api/api_exception.dart';

abstract interface class NotificationRemoteDatasource {
  Future<NotificationMainResponseModel> getList(
      NotificationListUsercaseReqParams reqModel);
}

class NotificationRemoteDatasourceImpl implements NotificationRemoteDatasource {
  final APIClient apiClient;
  NotificationRemoteDatasourceImpl({required this.apiClient});

  @override
  Future<NotificationMainResponseModel> getList(
      NotificationListUsercaseReqParams reqModel) async {
    try {
      final response = await apiClient.getRequest(ApiEndPoints.latestactivity);
      if (response.statusCode == 200) {
        final resDataModel =
            notificationMainResponseModelFromJson(response.data);
        return resDataModel;
      } else {
        throw ApiException(
            message: 'Invalid status code : ${response.statusCode}');
      }
    } catch (e) {
      debugPrint(e.toString());
      debugPrint("ItemRemoteDatasourceImpl error");
      throw ApiException(message: e.toString());
    }
  }
}
