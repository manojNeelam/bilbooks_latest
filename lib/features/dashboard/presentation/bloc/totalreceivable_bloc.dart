import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../domain/entity/total_receivables_entity.dart';
import '../../domain/usecase/total_receivables_usecase.dart';

part 'totalreceivable_event.dart';
part 'totalreceivable_state.dart';

class TotalreceivableBloc
    extends Bloc<TotalreceivableEvent, TotalreceivableState> {
  final TotalReceivablesUsecase _totalReceivablesUsecase;

  TotalreceivableBloc({
    required TotalReceivablesUsecase totalReceivablesUsecase,
  })  : _totalReceivablesUsecase = totalReceivablesUsecase,
        super(TotalreceivableInitial()) {
    on<GetTotalReceivablesEvent>((event, emit) async {
      emit(TotalReceivablesLoadingState());
      final response = await _totalReceivablesUsecase.call(event.params);
      response.fold(
          (l) => emit(TotalReceivablesErrorState(errorMessage: l.message)),
          (r) => emit(
              TotalReceivablesSuccessState(totalReceivablesMainResEntity: r)));
    });
  }
}
