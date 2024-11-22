import 'package:billbooks_app/features/taxes/domain/models/add_tax_entity.dart';
import 'package:billbooks_app/features/taxes/domain/models/tax_delete_entity.dart';
import 'package:billbooks_app/features/taxes/domain/models/tax_list_entity.dart';
import 'package:billbooks_app/features/taxes/domain/usecase/tax_list_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tax_event.dart';
part 'tax_state.dart';

class TaxBloc extends Bloc<TaxEvent, TaxState> {
  final TaxListUsecase _taxListUsecase;
  final AddTaxUseCase _addTaxUseCase;
  final TaxDeleteUseCase _deleteTaxUseCase;

  TaxBloc(
      {required TaxListUsecase taxListUsecase,
      required AddTaxUseCase addTaxUseCase,
      required TaxDeleteUseCase deleteTaxUseCase})
      : _taxListUsecase = taxListUsecase,
        _addTaxUseCase = addTaxUseCase,
        _deleteTaxUseCase = deleteTaxUseCase,
        super(TaxInitial()) {
    on<TaxEvent>((event, emit) {});

    on<GetTaxList>((event, emit) async {
      emit(TaxListLoadingState());
      final response = await _taxListUsecase.call(TaxListRequestModel());
      response.fold((l) => emit(TaxListErrorState(errorMessage: l.message)),
          (r) => emit(TaxListSuccessState(taxListResEntity: r)));
    });

    on<AddTaxEvent>((event, emit) async {
      emit(AddTaxLoadState());
      final response = await _addTaxUseCase.call(AddTaxRequestModel(
          name: event.taxName, rate: event.rate, id: event.id));
      response.fold((l) => emit(AddTaxErrorState(errorMessage: l.message)),
          (r) => emit(SuccessAddTax(taxAddMainResEntity: r)));
    });

    on<DeleteTaxEvent>((event, emit) async {
      emit(TaxDeleteWaitingState());
      final response = await _deleteTaxUseCase
          .call(DeleteTaxRequestModel(taxId: event.taxId));
      response.fold((l) => emit(TaxDeleteErrorState(errorMessage: l.message)),
          (r) => emit(SuccessDeleteTax(taxDeleteMainResEnity: r)));
    });
  }
}
