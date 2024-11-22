part of 'online_payments_bloc.dart';

@immutable
sealed class OnlinePaymentsEvent {}

class GetOnlinePaymentDetails extends OnlinePaymentsEvent {
  final OnlinePaymentDetailsReqParms onlinePaymentDetailsReqParms;
  GetOnlinePaymentDetails({required this.onlinePaymentDetailsReqParms});
}

class UpDatePayPalDetailsEvents extends OnlinePaymentsEvent {
  final PaypalUsecaseReqParams paypalUsecaseReqParams;
  UpDatePayPalDetailsEvents({required this.paypalUsecaseReqParams});
}

class UpDateAuthoriseDetailsEvents extends OnlinePaymentsEvent {
  final AuthorizeUsecaseReqParams authorizeUsecaseReqParams;
  UpDateAuthoriseDetailsEvents({required this.authorizeUsecaseReqParams});
}

class UpDateBraintreeDetailsEvents extends OnlinePaymentsEvent {
  final BrainTreeUseCaseUsecaseReqParams brainTreeUseCaseUsecaseReqParams;
  UpDateBraintreeDetailsEvents(
      {required this.brainTreeUseCaseUsecaseReqParams});
}

class UpdateCheckoutDetailsEvents extends OnlinePaymentsEvent {
  final CheckoutUseCaseUsecaseReqParams checkoutUseCaseUsecaseReqParams;
  UpdateCheckoutDetailsEvents({required this.checkoutUseCaseUsecaseReqParams});
}

class UpdateStripeDetailsEvents extends OnlinePaymentsEvent {
  final StripeUseCaseReqParams stripeUseCaseReqParams;
  UpdateStripeDetailsEvents({required this.stripeUseCaseReqParams});
}
