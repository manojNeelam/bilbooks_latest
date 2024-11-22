import 'package:billbooks_app/features/integrations/domain/entity/online_payment_details_entity.dart';
import 'package:billbooks_app/features/integrations/domain/usecase/online_payment_details_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entity/update_online_payment_entity.dart';

part 'online_payments_event.dart';
part 'online_payments_state.dart';

class OnlinePaymentsBloc
    extends Bloc<OnlinePaymentsEvent, OnlinePaymentsState> {
  final OnlinePaymentDetailsUsecase _onlinePaymentDetailsUsecase;
  final PaypalUsecase _paypalUsecase;
  final AuthorizeUseCase _authorizeUseCase;
  final BrainTreeUseCase _brainTreeUseCase;
  final CheckoutUseCase _checkoutUseCase;
  final StripeUseCase _stripeUseCase;

  OnlinePaymentsBloc(
    OnlinePaymentDetailsUsecase onlinePaymentDetailsUsecase,
    PaypalUsecase paypalUsecase,
    AuthorizeUseCase authorizeUseCase,
    BrainTreeUseCase brainTreeUseCase,
    CheckoutUseCase checkoutUseCase,
    StripeUseCase stripeUseCase,
  )   : _onlinePaymentDetailsUsecase = onlinePaymentDetailsUsecase,
        _authorizeUseCase = authorizeUseCase,
        _checkoutUseCase = checkoutUseCase,
        _paypalUsecase = paypalUsecase,
        _brainTreeUseCase = brainTreeUseCase,
        _stripeUseCase = stripeUseCase,
        super(OnlinePaymentsInitial()) {
    on<GetOnlinePaymentDetails>((event, emit) async {
      emit(OnlinePaymentDeatilsLoadingState());
      final response = await _onlinePaymentDetailsUsecase
          .call(event.onlinePaymentDetailsReqParms);
      response.fold(
          (l) => emit(OnlinePaymentDeatilsErrorState(errorMessage: l.message)),
          (r) => emit(OnlinePaymentDeatilsSuccessState(
              onlinePaymentMainResponseEntity: r)));
    });

    on<UpDatePayPalDetailsEvents>((event, emit) async {
      emit(UpdatePaypalDeatilsLoadingState());
      final response = await _paypalUsecase.call(event.paypalUsecaseReqParams);
      response.fold(
          (l) => emit(UpdatePaypalDeatilsErrorState(errorMessage: l.message)),
          (r) => emit(UpdatePaypalDeatilsSuccessState(
              updateOnlinePaymentMainResEntity: r)));
    });

    on<UpDateAuthoriseDetailsEvents>((event, emit) async {
      emit(UpdateAuthoriseDeatilsLoadingState());
      final response =
          await _authorizeUseCase.call(event.authorizeUsecaseReqParams);
      response.fold(
          (l) =>
              emit(UpdateAuthoriseDeatilsErrorState(errorMessage: l.message)),
          (r) => emit(UpdateAuthoriseDeatilsSuccessState(
              updateOnlinePaymentMainResEntity: r)));
    });

    on<UpDateBraintreeDetailsEvents>((event, emit) async {
      emit(UpdateBraintreeDeatilsLoadingState());
      final response =
          await _brainTreeUseCase.call(event.brainTreeUseCaseUsecaseReqParams);
      response.fold(
          (l) =>
              emit(UpdateBraintreeDeatilsErrorState(errorMessage: l.message)),
          (r) => emit(UpdateBraintreeDeatilsSuccessState(
              updateOnlinePaymentMainResEntity: r)));
    });

    on<UpdateCheckoutDetailsEvents>((event, emit) async {
      emit(UpdateCheckoutDeatilsLoadingState());
      final response =
          await _checkoutUseCase.call(event.checkoutUseCaseUsecaseReqParams);
      response.fold(
          (l) => emit(UpdateCheckoutDeatilsErrorState(errorMessage: l.message)),
          (r) => emit(UpdateCheckoutDeatilsSuccessState(
              updateOnlinePaymentMainResEntity: r)));
    });

    on<UpdateStripeDetailsEvents>((event, emit) async {
      emit(UpdateStripeDeatilsLoadingState());
      final response = await _stripeUseCase.call(event.stripeUseCaseReqParams);
      response.fold(
          (l) => emit(UpdateStripeDeatilsErrorState(errorMessage: l.message)),
          (r) => emit(UpdateStripeDeatilsSuccessState(
              updateOnlinePaymentMainResEntity: r)));
    });
  }
}
