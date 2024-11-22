import 'package:billbooks_app/core/api/api_client.dart';
import 'package:billbooks_app/features/profile/domain/usecase/profile_usecase.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../../core/api/api_endpoint_urls.dart';
import '../../../../core/api/api_exception.dart';
import '../../../dashboard/data/model/authinfo_model.dart';

abstract interface class ProfileRemoteDataSource {
  Future<AuthInfoMainResModel> selectOrganization(
      SelectOrganizationReqParams params);
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final APIClient apiClient;
  ProfileRemoteDataSourceImpl({required this.apiClient});
  @override
  Future<AuthInfoMainResModel> selectOrganization(
      SelectOrganizationReqParams params) async {
    try {
      Map<String, dynamic> queryParameters = {"id": params.id};
      FormData data = FormData.fromMap(queryParameters);

      final response = await apiClient.postRequest(
          path: ApiEndPoints.selectorganization, body: data);
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200) {
        final resModel = authInfoMainResModelFromJson(response.data);
        if (resModel.data?.success != true) {
          throw ApiException(
              message:
                  resModel.data?.message ?? "Request failed please try again!");
        }
        return resModel;
      } else {
        throw ApiException(
            message: 'Invalid status code : ${response.statusCode}');
      }
    } catch (e) {
      debugPrint(e.toString());

      throw ApiException(message: e.toString());
    }
  }
}
