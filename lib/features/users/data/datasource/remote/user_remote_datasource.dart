import 'package:billbooks_app/core/api/api_client.dart';
import 'package:billbooks_app/core/api/api_endpoint_urls.dart';
import 'package:billbooks_app/core/api/api_exception.dart';
import 'package:flutter/material.dart';

import '../../models/user_list_model.dart';

abstract interface class UserRemoteDatasource {
  Future<UsersMainResModel> getUsers();
}

class UserRemoteDatasourceImp implements UserRemoteDatasource {
  final APIClient apiClient;
  UserRemoteDatasourceImp({required this.apiClient});
  @override
  Future<UsersMainResModel> getUsers() async {
    try {
      final response = await apiClient.getRequest(ApiEndPoints.users);
      if (response.statusCode == 200) {
        final resModel = UsersMainResModel.fromJson(response.data);
        if (resModel.data?.success != true) {
          throw ApiException(
              message:
                  resModel.data?.message ?? "Request failed please try again!");
        }
        return resModel;
      } else {
        throw ApiException(
            message: "Invalid status code : ${response.statusCode}");
      }
    } on ApiException catch (e) {
      throw ApiException(message: e.message);
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }
}
