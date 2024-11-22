// To parse this JSON data, do
//
//     final onlinePaymentMainResponseEntity = onlinePaymentMainResponseEntityFromJson(jsonString);

class OnlinePaymentMainResponseEntity {
  int? success;
  OnlinePaymentDataEntity? data;

  OnlinePaymentMainResponseEntity({
    this.success,
    this.data,
  });
}

class OnlinePaymentDataEntity {
  bool? success;
  OnlinePaymentsEntity? onlinepayments;

  OnlinePaymentDataEntity({
    this.success,
    this.onlinepayments,
  });
}

class OnlinePaymentsEntity {
  bool? pgPaypal;
  String? pgPaypalId;
  bool? pgAuthorize;
  String? pgAuthorizeId;
  String? pgAuthorizeTranskey;
  bool? pg2Co;
  String? pg2CoId;
  String? pg2CoSecret;
  bool? pgBraintree;
  String? pgBraintreeId;
  String? pgBraintreePublickey;
  String? pgBraintreePrivatekey;
  bool? pgStripe;
  String? pgStripeId;
  String? pgStripePublishablekey;

  OnlinePaymentsEntity({
    this.pgPaypal,
    this.pgPaypalId,
    this.pgAuthorize,
    this.pgAuthorizeId,
    this.pgAuthorizeTranskey,
    this.pg2Co,
    this.pg2CoId,
    this.pg2CoSecret,
    this.pgBraintree,
    this.pgBraintreeId,
    this.pgBraintreePublickey,
    this.pgBraintreePrivatekey,
    this.pgStripe,
    this.pgStripeId,
    this.pgStripePublishablekey,
  });
}
