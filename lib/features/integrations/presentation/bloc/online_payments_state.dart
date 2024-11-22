part of 'online_payments_bloc.dart';

@immutable
sealed class OnlinePaymentsState {}

final class OnlinePaymentsInitial extends OnlinePaymentsState {}

//Start Get Online Payments
class OnlinePaymentDeatilsLoadingState extends OnlinePaymentsState {}

class OnlinePaymentDeatilsErrorState extends OnlinePaymentsState {
  final String errorMessage;
  OnlinePaymentDeatilsErrorState({required this.errorMessage});
}

class OnlinePaymentDeatilsSuccessState extends OnlinePaymentsState {
  final OnlinePaymentMainResponseEntity onlinePaymentMainResponseEntity;
  OnlinePaymentDeatilsSuccessState(
      {required this.onlinePaymentMainResponseEntity});
}
//End Get Online Payments

//Start Update Paypal Payments
class UpdatePaypalDeatilsLoadingState extends OnlinePaymentsState {}

class UpdatePaypalDeatilsErrorState extends OnlinePaymentsState {
  final String errorMessage;
  UpdatePaypalDeatilsErrorState({required this.errorMessage});
}

class UpdatePaypalDeatilsSuccessState extends OnlinePaymentsState {
  final UpdateOnlinePaymentMainResEntity updateOnlinePaymentMainResEntity;
  UpdatePaypalDeatilsSuccessState(
      {required this.updateOnlinePaymentMainResEntity});
}
//End Update Paypal Payments

//Start Update Paypal Payments

class UpdateAuthoriseDeatilsLoadingState extends OnlinePaymentsState {}

class UpdateAuthoriseDeatilsErrorState extends OnlinePaymentsState {
  final String errorMessage;
  UpdateAuthoriseDeatilsErrorState({required this.errorMessage});
}

class UpdateAuthoriseDeatilsSuccessState extends OnlinePaymentsState {
  final UpdateOnlinePaymentMainResEntity updateOnlinePaymentMainResEntity;
  UpdateAuthoriseDeatilsSuccessState(
      {required this.updateOnlinePaymentMainResEntity});
}
//End Update Paypal Payments

//Start Update Braintree Payments

class UpdateBraintreeDeatilsLoadingState extends OnlinePaymentsState {}

class UpdateBraintreeDeatilsErrorState extends OnlinePaymentsState {
  final String errorMessage;
  UpdateBraintreeDeatilsErrorState({required this.errorMessage});
}

class UpdateBraintreeDeatilsSuccessState extends OnlinePaymentsState {
  final UpdateOnlinePaymentMainResEntity updateOnlinePaymentMainResEntity;
  UpdateBraintreeDeatilsSuccessState(
      {required this.updateOnlinePaymentMainResEntity});
}
//End Update Braintree Payments

//Start Update checkout Payments
class UpdateCheckoutDeatilsLoadingState extends OnlinePaymentsState {}

class UpdateCheckoutDeatilsErrorState extends OnlinePaymentsState {
  final String errorMessage;
  UpdateCheckoutDeatilsErrorState({required this.errorMessage});
}

class UpdateCheckoutDeatilsSuccessState extends OnlinePaymentsState {
  final UpdateOnlinePaymentMainResEntity updateOnlinePaymentMainResEntity;
  UpdateCheckoutDeatilsSuccessState(
      {required this.updateOnlinePaymentMainResEntity});
}
//End Update checkout Payments

//Start Update stripe Payments
class UpdateStripeDeatilsLoadingState extends OnlinePaymentsState {}

class UpdateStripeDeatilsErrorState extends OnlinePaymentsState {
  final String errorMessage;
  UpdateStripeDeatilsErrorState({required this.errorMessage});
}

class UpdateStripeDeatilsSuccessState extends OnlinePaymentsState {
  final UpdateOnlinePaymentMainResEntity updateOnlinePaymentMainResEntity;
  UpdateStripeDeatilsSuccessState(
      {required this.updateOnlinePaymentMainResEntity});
}
//End Update stripe Payments