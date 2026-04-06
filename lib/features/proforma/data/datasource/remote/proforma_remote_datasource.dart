import 'package:billbooks_app/core/api/api_client.dart';
import 'package:billbooks_app/core/api/api_endpoint_urls.dart';
import 'package:billbooks_app/core/api/api_exception.dart';
import 'package:billbooks_app/features/proforma/data/models/proforma_details_model.dart';
import 'package:billbooks_app/features/proforma/data/models/proforma_list_model.dart';
import 'package:billbooks_app/features/proforma/domain/usecase/proforma_list_usecase.dart';
import 'package:flutter/material.dart';

abstract interface class ProformaRemoteDatasource {
  Future<ProformaListMainResModel> getProformas(ProformaListReqParams params);
  Future<ProformaDetailsResponseModel> getProformaDetails(
      ProformaDetailsReqParams params);
}

class ProformaRemoteDatasourceImpl implements ProformaRemoteDatasource {
  final APIClient apiClient;
  ProformaRemoteDatasourceImpl({required this.apiClient});

  @override
  Future<ProformaListMainResModel> getProformas(
      ProformaListReqParams params) async {
    try {
      final Map<String, dynamic> queryParameters = {
        'q': params.query,
        'sort_column': params.columnName,
        'sort_order': params.sortOrder,
        'page': params.page,
        'status': params.status,
        'date_start': params.startDate ?? '',
        'date_end': params.endDate ?? '',
      };

      final response = await apiClient.getRequest(
        ApiEndPoints.proformas,
        queryParameters: queryParameters,
      );

      if (response.statusCode == 200) {
        final resModel = ProformaListMainResModel.fromJson(response.data);
        if (resModel.data?.success != true) {
          throw ApiException(
            message:
                resModel.data?.message ?? 'Request failed please try again!',
          );
        }
        return resModel;
      }
      throw ApiException(
          message: 'Invalid status code : ${response.statusCode}');
    } catch (e) {
      debugPrint('ProformaRemoteDatasourceImpl error: $e');
      throw ApiException(message: e.toString());
    }
  }

  @override
  Future<ProformaDetailsResponseModel> getProformaDetails(
      ProformaDetailsReqParams params) async {
    try {
      final response = await apiClient.getRequest(
        ApiEndPoints.proformaDetails,
        queryParameters: {
          'id': params.id,
          'duplicate': params.duplicate,
        },
      );

      if (response.statusCode == 200) {
        final resModel = ProformaDetailsResponseModel.fromJson(response.data);

        if (resModel.data?.success != true) {
          throw ApiException(
            message:
                resModel.data?.message ?? 'Request failed please try again!',
          );
        }

        return resModel;
      }

      throw ApiException(
          message: 'Invalid status code : ${response.statusCode}');
    } catch (e) {
      debugPrint('ProformaRemoteDatasourceImpl details error: $e');
      throw ApiException(message: e.toString());
    }
  }
}
