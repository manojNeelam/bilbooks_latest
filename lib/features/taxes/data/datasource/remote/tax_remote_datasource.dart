import 'dart:ui';

import 'package:billbooks_app/core/api/api_client.dart';
import 'package:billbooks_app/core/api/api_endpoint_urls.dart';
import 'package:billbooks_app/core/api/api_exception.dart';
import 'package:billbooks_app/features/taxes/data/models/tax_delete_data_model.dart';
import 'package:billbooks_app/features/taxes/data/models/tax_list_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../domain/usecase/tax_list_usecase.dart';
import '../../models/add_tax_model.dart';

abstract interface class TaxRemoteDatasource {
  Future<TaxListResModel> getTaxList();
  Future<TaxAddMainResModel> addTax(AddTaxRequestModel request);
  Future<TaxDeleteMainResModel> deleteTax(
      DeleteTaxRequestModel deleteTaxRequestModel);
}

class TaxRemoteDatasourceImpl implements TaxRemoteDatasource {
  final APIClient apiClient;
  TaxRemoteDatasourceImpl({required this.apiClient});
  @override
  Future<TaxListResModel> getTaxList() async {
    try {
      final response = await apiClient.getRequest(ApiEndPoints.taxList);
      if (response.statusCode == 200) {
        final resModel = taxListResModelFromJson(response.data);
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

  @override
  Future<TaxAddMainResModel> addTax(AddTaxRequestModel request) async {
    try {
      Map<String, String> map = {"name": request.name, "rate": request.rate};
      if (request.id != null) {
        map.addAll({"id": request.id ?? ""});
      }
      var formData = FormData.fromMap(map);
      final response = await apiClient.postRequest(
          path: ApiEndPoints.addTax, body: formData);
      if (response.statusCode == 200) {
        final resModel = taxAddMainResModelFromJson(response.data);
        debugPrint("Tax: ${resModel.success ?? ""}");
        debugPrint("Success");
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

  @override
  Future<TaxDeleteMainResModel> deleteTax(
      DeleteTaxRequestModel deleteTaxRequestModel) async {
    try {
      Map<String, String> map = {"id": deleteTaxRequestModel.taxId};
      final response = await apiClient.deleteRequest(
          path: ApiEndPoints.deleteTax, queryParameters: map);
      if (response.statusCode == 200) {
        final resModel = taxDeleteMainResDataModelFromJson(response.data);
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
