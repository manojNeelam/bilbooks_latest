import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entity/sales_expenses_entity.dart';
import '../../domain/usecase/sales_expenses_usecase.dart';

part 'salesexpenses_event.dart';
part 'salesexpenses_state.dart';

class SalesexpensesBloc extends Bloc<SalesexpensesEvent, SalesexpensesState> {
  final SalesExpensesUsecase _salesExpensesUsecase;

  SalesexpensesBloc({required SalesExpensesUsecase salesExpensesUsecase})
      : _salesExpensesUsecase = salesExpensesUsecase,
        super(SalesexpensesInitial()) {
    on<GetSalesExpensesEvent>((event, emit) async {
      emit(SalesExpensesLoadingState());
      final response = await _salesExpensesUsecase.call(event.params);
      response.fold(
          (l) => emit(SalesExpensesErrorState(errorMessage: l.message)),
          (r) =>
              emit(SalesExpensesSuccessState(salesExpensesMainResEntity: r)));
    });
  }
}
