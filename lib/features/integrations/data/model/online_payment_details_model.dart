// To parse this JSON data, do
//
//     final onlinePaymentMainResponseModel = onlinePaymentMainResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:billbooks_app/features/integrations/domain/entity/online_payment_details_entity.dart';

OnlinePaymentMainResponseModel onlinePaymentMainResponseModelFromJson(
        String str) =>
    OnlinePaymentMainResponseModel.fromJson(json.decode(str));

class OnlinePaymentMainResponseModel extends OnlinePaymentMainResponseEntity {
  OnlinePaymentMainResponseModel({
    int? success,
    OnlinePaymentDataModel? data,
  }) : super(data: data, success: success);

  factory OnlinePaymentMainResponseModel.fromJson(Map<String, dynamic> json) =>
      OnlinePaymentMainResponseModel(
        success: json["success"],
        data: json["data"] == null
            ? null
            : OnlinePaymentDataModel.fromJson(json["data"]),
      );
}

class OnlinePaymentDataModel extends OnlinePaymentDataEntity {
  OnlinePaymentDataModel({
    bool? success,
    OnlinePaymentsModel? onlinepayments,
  }) : super(onlinepayments: onlinepayments, success: success);

  factory OnlinePaymentDataModel.fromJson(Map<String, dynamic> json) =>
      OnlinePaymentDataModel(
        success: json["success"],
        onlinepayments: json["onlinepayments"] == null
            ? null
            : OnlinePaymentsModel.fromJson(json["onlinepayments"]),
      );
}

class OnlinePaymentsModel extends OnlinePaymentsEntity {
  OnlinePaymentsModel({
    bool? pgPaypal,
    String? pgPaypalId,
    bool? pgAuthorize,
    String? pgAuthorizeId,
    String? pgAuthorizeTranskey,
    bool? pg2Co,
    String? pg2CoId,
    String? pg2CoSecret,
    bool? pgBraintree,
    String? pgBraintreeId,
    String? pgBraintreePublickey,
    String? pgBraintreePrivatekey,
    bool? pgStripe,
    String? pgStripeId,
    String? pgStripePublishablekey,
  }) : super(
            pgPaypalId: pgPaypalId,
            pgPaypal: pgPaypal,
            pgAuthorizeId: pgAuthorizeId,
            pgAuthorize: pgAuthorize,
            pgBraintreePublickey: pgBraintreePublickey,
            pgBraintreePrivatekey: pgBraintreePrivatekey,
            pgBraintreeId: pgBraintreeId,
            pgBraintree: pgBraintree,
            pg2Co: pg2Co,
            pg2CoSecret: pg2CoSecret,
            pg2CoId: pg2CoId,
            pgStripe: pgStripe,
            pgStripeId: pgStripeId,
            pgStripePublishablekey: pgStripePublishablekey,
            pgAuthorizeTranskey: pgAuthorizeTranskey);

  factory OnlinePaymentsModel.fromJson(Map<String, dynamic> json) =>
      OnlinePaymentsModel(
        pgPaypal: json["pg_paypal"],
        pgPaypalId: json["pg_paypal_id"],
        pgAuthorize: json["pg_authorize"],
        pgAuthorizeId: json["pg_authorize_id"],
        pgAuthorizeTranskey: json["pg_authorize_transkey"],
        pg2Co: json["pg_2co"],
        pg2CoId: json["pg_2co_id"],
        pg2CoSecret: json["pg_2co_secret"],
        pgBraintree: json["pg_braintree"],
        pgBraintreeId: json["pg_braintree_id"],
        pgBraintreePublickey: json["pg_braintree_publickey"],
        pgBraintreePrivatekey: json["pg_braintree_privatekey"],
        pgStripe: json["pg_stripe"],
        pgStripeId: json["pg_stripe_id"],
        pgStripePublishablekey: json["pg_stripe_publishablekey"],
      );
}
