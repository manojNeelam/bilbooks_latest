import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../domain/entity/total_incomes_entity.dart';
import '../../domain/usecase/total_incomes_usecase.dart';

part 'totalincomes_event.dart';
part 'totalincomes_state.dart';

class TotalincomesBloc extends Bloc<TotalincomesEvent, TotalincomesState> {
  final TotalIncomesUsecase _totalIncomesUsecase;
  TotalincomesBloc({required TotalIncomesUsecase totalIncomesUsecase})
      : _totalIncomesUsecase = totalIncomesUsecase,
        super(TotalincomesInitial()) {
    on<GetTotalIncomesEvent>((event, emit) async {
      emit(TotalIncomesLoadingState());
      final response = await _totalIncomesUsecase.call(event.params);
      response.fold(
          (l) => emit(TotalIncomesErrorState(errorMessage: l.message)),
          (r) => emit(TotalIncomesSuccessState(totalIncomesMainResEntity: r)));
    });
  }
}
