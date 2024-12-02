import 'package:billbooks_app/core/api/api_client.dart';
import 'package:billbooks_app/features/estimate/domain/usecase/estimate_detail_usecase.dart';
import 'package:billbooks_app/features/estimate/domain/usecase/estimate_list_usecase.dart';
import 'package:billbooks_app/features/invoice/data/models/invoice_details_model.dart';
import 'package:billbooks_app/features/invoice/domain/entities/invoice_details_entity.dart';
import 'package:flutter/material.dart';

import '../../../../core/api/api_endpoint_urls.dart';
import '../../../../core/api/api_exception.dart';
import '../estimate_list_model.dart';

abstract interface class EstimateDataSource {
  Future<EstimateListMainResModel> getEstimateList(
      EstimateListReqParams params);

  Future<InvoiceDetailsResponseEntity> getEstimateDetails(
      EstimateDetailUsecaseReqParams params);
}

class EstimateDataSourceImpl implements EstimateDataSource {
  final APIClient apiClient;
  EstimateDataSourceImpl({required this.apiClient});

  @override
  Future<EstimateListMainResModel> getEstimateList(
      EstimateListReqParams params) async {
    try {
      Map<String, dynamic> queryParameters = {
        "q": params.query,
        "sort_column": params.columnName,
        "sort_order": params.sortOrder,
        "page": params.page,
      };

      if (params.startDateStr != null) {
        queryParameters.addAll({
          "start_date": params.startDateStr ?? "",
        });
      }

      if (params.endDateStr != null) {
        queryParameters.addAll({
          "end_date": params.endDateStr ?? "",
        });
      }

      if (params.status.isNotEmpty) {
        queryParameters.addAll({
          "status": params.status,
        });
      } else {
        queryParameters.addAll({
          "status": "",
        });
      }

      debugPrint(queryParameters.toString());

      final response = await apiClient.getRequest(ApiEndPoints.estimates,
          queryParameters: queryParameters);
      debugPrint("EstimateListMainResModel ");
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200) {
        final resModel = estimateListMainResModelFromJson(response.data);
        debugPrint("length1: ${resModel.data?.estimates?.length}");
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

      debugPrint("EstimateListMainResModel error");
      throw ApiException(message: e.toString());
    }
  }

  @override
  Future<InvoiceDetailsResponseEntity> getEstimateDetails(
      EstimateDetailUsecaseReqParams params) async {
    try {
      Map<String, dynamic> queryParameters = {
        "id": params.id,
      };

      final response = await apiClient.getRequest(ApiEndPoints.estimates,
          queryParameters: queryParameters);
      debugPrint("InvoiceDetailsResponseEntity ");
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200) {
        final resModel = invoiceDetailsResponseModelFromJson(response.data);
        debugPrint("Name: ${resModel.data?.estimate?.clientName}");
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

      debugPrint("InvoiceDetailsResponseEntity error");
      throw ApiException(message: e.toString());
    }
  }
}
