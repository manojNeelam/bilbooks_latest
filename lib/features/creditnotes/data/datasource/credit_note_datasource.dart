import 'package:billbooks_app/core/api/api_client.dart';
import 'package:billbooks_app/features/creditnotes/data/models/credit_note_list_model.dart';
import 'package:billbooks_app/features/creditnotes/domain/model/credit_note_detail_req_params.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/api/api_endpoint_urls.dart';
import '../../../../core/api/api_exception.dart';
import '../../domain/model/credit_note_add_req_params.dart';
import '../../domain/model/credit_note_delete_req_params.dart';
import '../../domain/model/credit_note_list_req_params.dart';
import '../models/credit_note_delete_model.dart';
import '../models/credit_note_detail_model.dart';
import '../models/update_credit_note_model.dart';

abstract class CreditNoteRemoteDataSource {
  Future<CreditNoteListMainResponseModel> getList(
      CreditNoteListReqParams params);
  Future<CreditNoteDetailsMainResModel> getCreditNoteDetail(
      CreditNoteDetailReqParams params);

  Future<UpdateCreditNoteMainResponseModel> updateCreditNoteDetail(
      CreditNoteAddReqParams params);
  Future<CreditNoteDeleteMainResModel> deleteCreditNote(
      CreditNoteDeleteReqParams params);
}

class CreditNoteRemoteDataSourceImpl implements CreditNoteRemoteDataSource {
  final APIClient apiClient;
  CreditNoteRemoteDataSourceImpl(this.apiClient);
  @override
  Future<CreditNoteListMainResponseModel> getList(
      CreditNoteListReqParams params) async {
    try {
      Map<String, dynamic> queryParameters = {
        "q": params.query,
      };

      if (params.status.isNotEmpty) {
        queryParameters.addAll({
          "status": params.status,
        });
      } else {
        queryParameters.addAll({
          "status": "",
        });
      }

      // debugPrint(queryParameters.toString());

      final response = await apiClient.getRequest(
        ApiEndPoints.creditNotes,
        queryParameters: queryParameters,
      );
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

  @override
  Future<CreditNoteDetailsMainResModel> getCreditNoteDetail(
      CreditNoteDetailReqParams params) async {
    try {
      Map<String, dynamic> queryParameters = params.toJson();
      final response = await apiClient.getRequest(
        ApiEndPoints.creditnotedetails,
        queryParameters: queryParameters,
      );
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200) {
        final resModel = CreditNoteDetailsMainResModel.fromJson(response.data);
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
      debugPrint("Credit note details error");
      throw ApiException(message: e.toString());
    }
  }

  @override
  Future<UpdateCreditNoteMainResponseModel> updateCreditNoteDetail(
      CreditNoteAddReqParams params) async {
    try {
      debugPrint("Before api call");
      Map<String, dynamic> queryParameters = {
        "note_no": params.noteNumber,
        "project_id": params.projectId,
        "description": params.desc,
        "amount": params.amount,
        "client_id": params.clientId,
        "status": "Unused"
      };

      if (params.id != null && params.id != "0") {
        queryParameters.addAll({
          "id": params.id,
        });
      }

      final body = FormData.fromMap(queryParameters);
      final response = await apiClient.postRequest(
          path: ApiEndPoints.creditnoteadd, body: body);
      if (response.statusCode == 200) {
        final resModel =
            UpdateCreditNoteMainResponseModel.fromJson(response.data);
        if (resModel.data?.success != true) {
          throw ApiException(
              message:
                  resModel.data?.message ?? "Request failed please try again!");
        }
        return resModel;
      } else {
        throw ApiException(
            message: "Invalid status code: ${response.statusCode}");
      }
    } on ApiException catch (e) {
      throw ApiException(message: e.toString());
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }

  @override
  Future<CreditNoteDeleteMainResModel> deleteCreditNote(
      CreditNoteDeleteReqParams params) async {
    try {
      debugPrint("Before api call");
      Map<String, dynamic> queryParameters = {
        "id": params.id,
      };

      final response = await apiClient.deleteRequest(
          path: ApiEndPoints.creditnotedelete,
          queryParameters: queryParameters);
      debugPrint("deleteCreditNote After api call");
      if (response.statusCode == 200) {
        debugPrint("response.statusCode == 200");

        final resModel = CreditNoteDeleteMainResModel.fromJson(response.data);
        debugPrint("resModel after");

        if (resModel.data?.success != true) {
          debugPrint("resModel success");

          throw ApiException(
              message:
                  resModel.data?.message ?? "Request failed please try again!");
        }
        return resModel;
      } else {
        throw ApiException(
            message: "Invalid status code: ${response.statusCode}");
      }
    } on ApiException catch (e) {
      throw ApiException(message: e.toString());
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }
}
