import 'package:billbooks_app/core/api/api_client.dart';
import 'package:billbooks_app/features/creditnotes/data/models/credit_note_list_model.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/api/api_endpoint_urls.dart';
import '../../../../core/api/api_exception.dart';
import '../../domain/model/credit_note_list_req_params.dart';

abstract class CreditNoteRemoteDataSource {
  Future<CreditNoteListMainResponseModel> getList(
      CreditNoteListReqParams params);
}

class CreditNoteRemoteDataSourceImpl implements CreditNoteRemoteDataSource {
  final APIClient apiClient;
  CreditNoteRemoteDataSourceImpl(this.apiClient);
  @override
  Future<CreditNoteListMainResponseModel> getList(
      CreditNoteListReqParams params) async {
    try {
      // Map<String, dynamic> queryParameters = {
      //   "q": params.query,
      //   "sort_column": params.columnName,
      //   "sort_order": params.sortOrder,
      //   "page": params.page,
      // };

      // if (params.status.isNotEmpty) {
      //   queryParameters.addAll({
      //     "status": params.status,
      //   });
      // } else {
      //   queryParameters.addAll({
      //     "status": "",
      //   });
      // }

      // debugPrint(queryParameters.toString());

      final response = await apiClient.getRequest(ApiEndPoints.creditNotes);
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200) {
        final resModel =
            CreditNoteListMainResponseModel.fromJson(response.data);
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
      debugPrint("CreditNoteRemoteDataSourceImpl error");
      throw ApiException(message: e.toString());
    }
  }
}
