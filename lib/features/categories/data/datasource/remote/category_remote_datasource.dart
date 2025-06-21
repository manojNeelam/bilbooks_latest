import 'dart:async';

import 'package:billbooks_app/core/api/api_client.dart';
import 'package:billbooks_app/core/api/api_endpoint_urls.dart';
import 'package:flutter/material.dart';

import '../../../../../core/api/api_exception.dart';
import '../../models/category_list_model.dart';

abstract interface class CategoryRemoteDatasource {
  Future<CategoryListMainResModel> getCategories();
}

class CategoryRemoteDatasourceImpl implements CategoryRemoteDatasource {
  final APIClient apiClient;
  CategoryRemoteDatasourceImpl({required this.apiClient});
  @override
  Future<CategoryListMainResModel> getCategories() async {
    try {
      Map<String, String> map = {"action": "fetch"};
      final response = await apiClient.getRequest(ApiEndPoints.categories,
          queryParameters: map);
      if (response.statusCode == 200) {
        final resModel = CategoryListMainResModel.fromJson(response.data);
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

      debugPrint("CategoryRemoteDatasourceImpl error");
      throw ApiException(message: e.toString());
    }
  }
}
