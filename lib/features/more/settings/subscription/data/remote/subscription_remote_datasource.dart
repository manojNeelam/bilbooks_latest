import 'package:flutter/foundation.dart';

import '../../../../../../core/api/api_client.dart';
import '../../../../../../core/api/api_endpoint_urls.dart';
import '../../../../../../core/api/api_exception.dart';
import '../../domain/usecase/subscription_usecase.dart';
import '../model/subscription_model.dart';

abstract interface class SubscriptionRemoteDatasource {
  Future<SubscriptionMainResponseModel> getSubscription(
      SubscriptionReqParams params);
}

class SubscriptionRemoteDatasourceImpl implements SubscriptionRemoteDatasource {
  final APIClient apiClient;

  SubscriptionRemoteDatasourceImpl({required this.apiClient});

  @override
  Future<SubscriptionMainResponseModel> getSubscription(
      SubscriptionReqParams params) async {
    try {
      final response = await apiClient.getRequest(
        ApiEndPoints.subscription,
        queryParameters: {
          'page': params.page,
          'per_page': params.perPage,
        },
      );
      debugPrint('SubscriptionMainResponseModel');
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200) {
        final resModel = SubscriptionMainResponseModel.fromJson(response.data);
        if (resModel.data?.success != true) {
          throw ApiException(message: 'Request failed please try again!');
        }
        return resModel;
      }
      throw ApiException(
          message: 'Invalid status code : ${response.statusCode}');
    } catch (e) {
      debugPrint(e.toString());
      debugPrint('SubscriptionMainResponseModel error');
      throw ApiException(message: e.toString());
    }
  }
}
