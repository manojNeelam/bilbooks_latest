import 'package:billbooks_app/features/estimate/domain/entity_list_entity.dart';
import 'package:billbooks_app/features/estimate/domain/usecase/estimate_detail_usecase.dart';
import 'package:billbooks_app/features/estimate/domain/usecase/estimate_list_usecase.dart';
import 'package:billbooks_app/features/invoice/domain/entities/invoice_details_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'estimate_event.dart';
part 'estimate_state.dart';

class EstimateBloc extends Bloc<EstimateEvent, EstimateState> {
  final EstimateListUsecase _estimateListUsecase;
  final EstimateDetailUsecase _estimateDetailUsecase;

  EstimateBloc(
      {required EstimateListUsecase estimateListUsecase,
      required EstimateDetailUsecase estimateDetailUsecase})
      : _estimateListUsecase = estimateListUsecase,
        _estimateDetailUsecase = estimateDetailUsecase,
        super(EstimateInitial()) {
    on<GetEstimateListEvent>((event, emit) async {
      emit(EstimateListLoadingState());
      final res = await _estimateListUsecase.call(event.estimateListReqParams);
      res.fold((l) => emit(EstimateListErrorState(errorMessage: l.message)),
          (r) => emit(EstimateListSuccessState(estimateListMainResEntity: r)));
    });

    on<GetEstimateDetailsEvent>((event, emit) async {
      emit(EstimateDetailsLoadingState());
      final res = await _estimateDetailUsecase
          .call(event.estimateDetailUsecaseReqParams);
      res.fold(
          (l) => emit(EstimateDetailsErrorState(errorMessage: l.message)),
          (r) => emit(
              EstimateDetailsSuccessState(invoiceDetailsResponseEntity: r)));
    });
  }
}
