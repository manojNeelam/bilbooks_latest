import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entity/subscription_entity.dart';
import '../../domain/usecase/subscription_usecase.dart';

part 'subscription_event.dart';
part 'subscription_state.dart';

class SubscriptionBloc extends Bloc<SubscriptionEvent, SubscriptionState> {
  final GetSubscriptionUsecase _getSubscriptionUsecase;

  SubscriptionBloc({required GetSubscriptionUsecase getSubscriptionUsecase})
      : _getSubscriptionUsecase = getSubscriptionUsecase,
        super(SubscriptionInitial()) {
    on<GetSubscriptionEvent>((event, emit) async {
      emit(SubscriptionLoadingState());
      final response = await _getSubscriptionUsecase.call(event.params);
      response.fold(
        (l) => emit(SubscriptionErrorState(errorMessage: l.message)),
        (r) => emit(SubscriptionSuccessState(subscriptionEntity: r)),
      );
    });
  }
}
