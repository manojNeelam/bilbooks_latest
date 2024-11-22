import 'package:billbooks_app/core/api/api_client.dart';
import 'package:billbooks_app/core/api/api_endpoint_urls.dart';
import 'package:billbooks_app/features/item/domain/usecase/item_usecase.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../../../core/api/api_exception.dart';
import '../../models/add_item_data_model.dart';
import '../../models/delete_item_data_model.dart';
import '../../models/item_active_model.dart';
import '../../models/item_inactive_model.dart';
import '../../models/item_list_data_model.dart';

abstract interface class ItemRemoteDatasource {
  Future<ItemsResponseDataModel> getList(ItemListReqModel reqModel);
  Future<AddItemMainResModel> addItem(FormData body);
  Future<DeleteItemMainResDataModel> deleteItem(
      DeleteItemReqModel deleteItemReqModel);
  Future<ItemActiveMainResModel> itemMarkAsActive(
      ItemMarkActiveUseCaseReqParams params);
  Future<ItemInActiveMainResModel> itemMarkAsInActive(
      ItemMarkInActiveUseCaseReqParams params);
}

class ItemRemoteDatasourceImpl implements ItemRemoteDatasource {
  final APIClient apiClient;

  ItemRemoteDatasourceImpl({required this.apiClient});
  @override
  Future<ItemsResponseDataModel> getList(ItemListReqModel reqModel) async {
    try {
      Map<String, String> queryParams = {
        "status": reqModel.status,
        "q": reqModel.query,
        "sort_column": reqModel.columnName,
        "sort_order": reqModel.orderBy,
        "page": reqModel.page,
      };
      final response = await apiClient.getRequest(ApiEndPoints.itemList,
          queryParameters: queryParams);
      if (response.statusCode == 200) {
        final resDataModel = itemsResponseDataModelFromJson(response.data);
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

  @override
  Future<AddItemMainResModel> addItem(FormData body) async {
    try {
      final response =
          await apiClient.postRequest(path: ApiEndPoints.addItem, body: body);
      if (response.statusCode == 200) {
        final resModel = addItemMainResModelFromJson(response.data);
        return resModel;
      } else {
        throw ApiException(
            message: 'Invalid status code : ${response.statusCode}');
      }
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }

  @override
  Future<DeleteItemMainResDataModel> deleteItem(
      DeleteItemReqModel deleteItemReqModel) async {
    try {
      Map<String, String> map = {"id": deleteItemReqModel.id};
      final response = await apiClient.deleteRequest(
          path: ApiEndPoints.deleteItem, queryParameters: map);
      if (response.statusCode == 200) {
        final resModel = deleteItemMainResDataModelFromJson(response.data);
        debugPrint("Item Removed Response: ${resModel.success ?? ""}");
        debugPrint("Success");
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

  @override
  Future<ItemActiveMainResModel> itemMarkAsActive(
      ItemMarkActiveUseCaseReqParams params) async {
    try {
      final Map<String, String> queryParams = {"id": params.id};
      final FormData formData = FormData.fromMap(queryParams);
      final response = await apiClient.postRequest(
          path: ApiEndPoints.itemActive, body: formData);
      if (response.statusCode == 200) {
        final resModel = itemActiveMainResModelFromJson(response.data);
        return resModel;
      } else {
        throw ApiException(
            message: 'Invalid status code : ${response.statusCode}');
      }
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }

  @override
  Future<ItemInActiveMainResModel> itemMarkAsInActive(
      ItemMarkInActiveUseCaseReqParams params) async {
    try {
      final Map<String, String> queryParams = {"id": params.id};
      final FormData formData = FormData.fromMap(queryParams);
      final response = await apiClient.postRequest(
          path: ApiEndPoints.itemInActive, body: formData);
      if (response.statusCode == 200) {
        final resModel = itemInActiveMainResModelFromJson(response.data);
        return resModel;
      } else {
        throw ApiException(
            message: 'Invalid status code : ${response.statusCode}');
      }
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }
}
