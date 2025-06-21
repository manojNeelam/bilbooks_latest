import 'package:billbooks_app/core/api/api_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../../core/api/api_endpoint_urls.dart';
import '../../../../core/api/api_exception.dart';
import '../../domain/usecase/online_payment_details_usecase.dart';
import '../model/online_payment_details_model.dart';
import '../model/update_online_payment_model.dart';

abstract interface class OnlinePaymentsRemoteDatasource {
  Future<OnlinePaymentMainResponseModel> getOnlinePaymentDetails(
      OnlinePaymentDetailsReqParms params);
  Future<UpdateOnlinePaymentMainResModel> updatePayPalDetails(
      PaypalUsecaseReqParams params);
  Future<UpdateOnlinePaymentMainResModel> updateAuthoriseDetails(
      AuthorizeUsecaseReqParams params);
  Future<UpdateOnlinePaymentMainResModel> updateBrainTreeDetails(
      BrainTreeUseCaseUsecaseReqParams params);

  Future<UpdateOnlinePaymentMainResModel> updateCheckoutDetails(
      CheckoutUseCaseUsecaseReqParams params);

  Future<UpdateOnlinePaymentMainResModel> updateStripeDetails(
      StripeUseCaseReqParams params);
}

class OnlinePaymentsRemoteDatasourceImpl
    implements OnlinePaymentsRemoteDatasource {
  final APIClient apiClient;
  OnlinePaymentsRemoteDatasourceImpl({required this.apiClient});
  @override
  Future<OnlinePaymentMainResponseModel> getOnlinePaymentDetails(
      OnlinePaymentDetailsReqParms params) async {
    try {
      final response = await apiClient.getRequest(
        ApiEndPoints.onlinepayments,
      );
      debugPrint("OnlinePaymentMainResponseModel ");
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200) {
        final resModel = OnlinePaymentMainResponseModel.fromJson(response.data);
        if (resModel.data?.success != true) {
          throw ApiException(message: "Request failed please try again!");
        }
        debugPrint(
            "stripe: ${resModel.data?.onlinepayments?.pgStripePublishablekey}");

        return resModel;
      } else {
        throw ApiException(
            message: 'Invalid status code : ${response.statusCode}');
      }
    } catch (e) {
      debugPrint(e.toString());
      debugPrint("OnlinePaymentMainResponseModel error");
      throw ApiException(message: e.toString());
    }
  }

  @override
  Future<UpdateOnlinePaymentMainResModel> updatePayPalDetails(
      PaypalUsecaseReqParams params) async {
    try {
      Map<String, String> map = {
        "gateway": "paypal",
        "pg_paypal": params.paypalid.isEmpty ? "false" : "true",
        "pg_paypal_id": params.paypalid,
      };
      FormData body = FormData.fromMap(map);
      final response = await apiClient.postRequest(
          path: ApiEndPoints.onlinepayments, body: body);
      debugPrint("UpdateOnlinePaymentMainResModel paypal");
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200) {
        final resModel =
            UpdateOnlinePaymentMainResModel.fromJson(response.data);
        if (resModel.data?.success != true) {
          throw ApiException(message: "Request failed please try again!");
        }
        return resModel;
      } else {
        throw ApiException(
            message: 'Invalid status code : ${response.statusCode}');
      }
    } catch (e) {
      debugPrint(e.toString());
      debugPrint("UpdateOnlinePaymentMainResModel paypal error");
      throw ApiException(message: e.toString());
    }
  }

  @override
  Future<UpdateOnlinePaymentMainResModel> updateAuthoriseDetails(
      AuthorizeUsecaseReqParams params) async {
    try {
      Map<String, String> map = {
        "gateway": "authorize",
        "pg_authorize": params.authoriseId.isEmpty ? "false" : "true",
        "pg_authorize_id": params.authoriseId,
        "pg_authorize_transkey": params.authriseTransactionKey
      };
      FormData body = FormData.fromMap(map);
      final response = await apiClient.postRequest(
          path: ApiEndPoints.onlinepayments, body: body);
      debugPrint("UpdateOnlinePaymentMainResModel authorize");
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200) {
        final resModel =
            UpdateOnlinePaymentMainResModel.fromJson(response.data);
        if (resModel.data?.success != true) {
          throw ApiException(message: "Request failed please try again!");
        }
        return resModel;
      } else {
        throw ApiException(
            message: 'Invalid status code : ${response.statusCode}');
      }
    } catch (e) {
      debugPrint(e.toString());
      debugPrint("UpdateOnlinePaymentMainResModel authorize error");
      throw ApiException(message: e.toString());
    }
  }

  @override
  Future<UpdateOnlinePaymentMainResModel> updateBrainTreeDetails(
      BrainTreeUseCaseUsecaseReqParams params) async {
    try {
      /*
      pg_braintree:true
pg_braintree_id:wer
pg_braintree_publickey:wer
pg_braintree_privatekey:wer
      */
      Map<String, String> map = {
        "gateway": "braintree",
        "pg_braintree_id": params.merchantId,
        "pg_braintree": params.merchantId.isEmpty ? "false" : "true",
        "pg_braintree_publickey": params.publickey,
        "pg_braintree_privatekey": params.privateKey
      };
      FormData body = FormData.fromMap(map);
      final response = await apiClient.postRequest(
          path: ApiEndPoints.onlinepayments, body: body);
      debugPrint("UpdateOnlinePaymentMainResModel braintree");
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200) {
        final resModel =
            UpdateOnlinePaymentMainResModel.fromJson(response.data);
        if (resModel.data?.success != true) {
          throw ApiException(message: "Request failed please try again!");
        }
        return resModel;
      } else {
        throw ApiException(
            message: 'Invalid status code : ${response.statusCode}');
      }
    } catch (e) {
      debugPrint(e.toString());
      debugPrint("UpdateOnlinePaymentMainResModel braintree error");
      throw ApiException(message: e.toString());
    }
  }

  @override
  Future<UpdateOnlinePaymentMainResModel> updateCheckoutDetails(
      CheckoutUseCaseUsecaseReqParams params) async {
    try {
      Map<String, String> map = {
        "gateway": "2co",
        "pg_2co_id": params.accountId,
        "pg_2co": params.accountId.isEmpty ? "false" : "true",
        "pg_2co_secret": params.secret,
      };
      FormData body = FormData.fromMap(map);
      final response = await apiClient.postRequest(
          path: ApiEndPoints.onlinepayments, body: body);
      debugPrint("UpdateOnlinePaymentMainResModel 2co");
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200) {
        final resModel =
            UpdateOnlinePaymentMainResModel.fromJson(response.data);
        if (resModel.data?.success != true) {
          throw ApiException(message: "Request failed please try again!");
        }
        return resModel;
      } else {
        throw ApiException(
            message: 'Invalid status code : ${response.statusCode}');
      }
    } catch (e) {
      debugPrint(e.toString());
      debugPrint("UpdateOnlinePaymentMainResModel 2co error");
      throw ApiException(message: e.toString());
    }
  }

  @override
  Future<UpdateOnlinePaymentMainResModel> updateStripeDetails(
      StripeUseCaseReqParams params) async {
    try {
      Map<String, String> map = {
        "gateway": "stripe",
        "pg_stripe_id": params.id,
        "pg_stripe": params.id.isEmpty ? "false" : "true",
        "pg_stripe_publishablekey": params.publishableKey,
      };
      FormData body = FormData.fromMap(map);
      final response = await apiClient.postRequest(
          path: ApiEndPoints.onlinepayments, body: body);
      debugPrint("UpdateOnlinePaymentMainResModel stripe");
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200) {
        final resModel =
            UpdateOnlinePaymentMainResModel.fromJson(response.data);
        if (resModel.data?.success != true) {
          throw ApiException(message: "Request failed please try again!");
        }
        return resModel;
      } else {
        throw ApiException(
            message: 'Invalid status code : ${response.statusCode}');
      }
    } catch (e) {
      debugPrint(e.toString());
      debugPrint("UpdateOnlinePaymentMainResModel stripe error");
      throw ApiException(message: e.toString());
    }
  }
  //updateStripeDetails
}
