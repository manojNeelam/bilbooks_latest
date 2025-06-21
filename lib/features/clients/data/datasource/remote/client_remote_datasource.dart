import 'dart:convert';

import 'package:billbooks_app/core/api/api_client.dart';
import 'package:billbooks_app/core/api/api_endpoint_urls.dart';
import 'package:billbooks_app/core/api/api_exception.dart';
import 'package:billbooks_app/features/clients/data/models/add_client_model.dart';
import 'package:billbooks_app/features/clients/data/models/client_details_model.dart';
import 'package:billbooks_app/features/clients/data/models/client_list_model.dart';
import 'package:billbooks_app/features/clients/domain/entities/add_client_entity.dart';
import 'package:billbooks_app/features/clients/domain/usecase/client_usecase.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../domain/usecase/add_client_usecase.dart';
import '../../models/delete_client_model.dart';
import '../../models/update_status_model.dart';

abstract interface class ClientRemoteDataSource {
  Future<ClientResponseModel> getList(ClientListParams params);
  Future<DeleteClientMainDataModel> deleteClient(DeleteClientParams params);
  Future<UpdateClientMainDataModel> updateClientStatus(
      UpdateClientStatusParams params);
  Future<ClientDetailsMainResModel> getDetails(ClientDetailsReqParams params);

  Future<ClientAddMainResEntity> addClient(AddClientUsecaseReqParams params);
}

class ClientRemoteDataSourceImpl implements ClientRemoteDataSource {
  final APIClient apiClient;
  ClientRemoteDataSourceImpl(this.apiClient);
  @override
  Future<ClientResponseModel> getList(ClientListParams params) async {
    try {
      Map<String, dynamic> queryParameters = {
        "q": params.query,
        "sort_column": params.columnName,
        "sort_order": params.sortOrder,
        "page": params.page,
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

      debugPrint(queryParameters.toString());

      final response = await apiClient.getRequest(ApiEndPoints.client,
          queryParameters: queryParameters);
      debugPrint("ClientRemoteDataSourceImpl ");
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200) {
        final resModel = ClientResponseModel.fromJson(response.data);
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

      debugPrint("ClientRemoteDataSourceImpl error");
      throw ApiException(message: e.toString());
    }
  }

  @override
  Future<DeleteClientMainDataModel> deleteClient(
      DeleteClientParams params) async {
    try {
      Map<String, String> reqPrams = {
        "id": params.id,
      };
      final response = await apiClient.deleteRequest(
          path: ApiEndPoints.deleteClient, queryParameters: reqPrams);
      if (response.statusCode == 200) {
        final resModel = DeleteClientMainDataModel.fromJson(response.data);
        if (resModel.data?.success != true) {
          throw ApiException(
              message:
                  resModel.data?.message ?? "Request failed please try again!");
        }
        return resModel;
      } else {
        throw ApiException(
            message: "Invalid Status code: ${response.statusCode}");
      }
    } on ApiException catch (e) {
      throw ApiException(message: e.toString());
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }

  @override
  Future<UpdateClientMainDataModel> updateClientStatus(
      UpdateClientStatusParams params) async {
    try {
      Map<String, String> body = {"id": params.id};
      final reqPrams = FormData.fromMap(body);

      final path = params.isActive
          ? ApiEndPoints.inActiveClient
          : ApiEndPoints.activeClient;

      final response = await apiClient.postRequest(path: path, body: reqPrams);
      if (response.statusCode == 200) {
        final resModel = UpdateClientMainDataModel.fromJson(response.data);
        if (resModel.data?.success != true) {
          throw ApiException(
              message:
                  resModel.data?.message ?? "Request failed please try again!");
        }
        return resModel;
      } else {
        throw ApiException(
            message: "Invalid Status code: ${response.statusCode}");
      }
    } on ApiException catch (e) {
      throw ApiException(message: e.toString());
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }

  @override
  Future<ClientDetailsMainResModel> getDetails(
      ClientDetailsReqParams params) async {
    try {
      //page=views
      Map<String, String> map = {"id": params.id, "page": "views"};
      final response = await apiClient.getRequest(ApiEndPoints.clientDetails,
          queryParameters: map);
      if (response.statusCode == 200) {
        final resModel = ClientDetailsMainResModel.fromJson(response.data);
        if (resModel.data?.success != true) {
          throw ApiException(
              message:
                  resModel.data?.message ?? "Request failed please try again!");
        }
        return resModel;
      } else {
        throw ApiException(
            message: "Invalid Status code: ${response.statusCode}");
      }
    } on ApiException catch (e) {
      throw ApiException(message: e.toString());
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }

  @override
  Future<ClientAddMainResEntity> addClient(
      AddClientUsecaseReqParams params) async {
    try {
      /*
      //id:23532
//contact_id:30238
persons:[{"name":"krunal","email":"primaryp@gmail.com","phone":"987654"}]
//persons[0]:{↵	"name": "Ram",↵	"email": "p1.example.com",↵	"phone": "5555656565"↵}
//persons[1]:{↵	"name": "Ram",↵	"email": "p1.example.com",↵	"phone": "5555656565"↵}
//persons[2]:{↵	"name": "Ram",↵	"email": "p1.example.com",↵	"phone": "5555656565"↵}

      */

      final personsMapList = params.clientPersons.map((element) {
        return {
          "name": element.name,
          "email": element.email,
          "phone": element.phoneNumber,
        };
      }).toList();

      final personsJsonString = json.encode(personsMapList);

      Map<String, String> body = {
        "address": params.address,
        "city": params.city,
        "state": params.state,
        "zipcode": params.zipCode,
        "phone": params.phone,
        "country_id": params.countryId,
        "registration_no": params.registrationNo,
        "website": params.website,
        "currency": params.currency,
        "payment_terms": params.paymentTerms,
        "language": params.language,
        "shipping_address": params.shippingAddress,
        "shipping_city": params.shippingCity,
        "shipping_state": params.shippingState,
        "shipping_zipcode": params.shippingZipcode,
        "shipping_phone": params.shippingPhone,
        "shipping_country_id": params.shippingCountry,
        "remarks": params.remarks,
        "contact_phone": params.contactPhone,
        "contact_email": params.contactEmail,
        "contact_name": params.contactName,
        "name": params.name,
        "persons": personsJsonString,
        "contact_id": params.contactId,
      };

      if (params.id.isNotEmpty) {
        body.addAll({"id": params.id});
      }

      debugPrint("Req: ${body.toString()}");

      final reqPrams = FormData.fromMap(body);
      const path = ApiEndPoints.addClient;
      final response = await apiClient.postRequest(
        path: path,
        body: reqPrams,
      );
      if (response.statusCode == 200) {
        final resModel = ClientAddMainResModel.fromJson(response.data);
        if (resModel.data?.success != true) {
          throw ApiException(
              message:
                  resModel.data?.message ?? "Request failed please try again!");
        }
        return resModel;
      } else {
        throw ApiException(
            message: "Invalid Status code: ${response.statusCode}");
      }
    } on ApiException catch (e) {
      throw ApiException(message: e.toString());
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }
}
