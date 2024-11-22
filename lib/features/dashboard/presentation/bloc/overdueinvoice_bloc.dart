import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../domain/entity/overdue_invoice_entity.dart';
import '../../domain/usecase/overdue_invoice_usecase.dart';

part 'overdueinvoice_event.dart';
part 'overdueinvoice_state.dart';

class OverdueinvoiceBloc
    extends Bloc<OverdueinvoiceEvent, OverdueinvoiceState> {
  final OverdueInvoiceUsecase _overdueInvoiceUsecase;

  OverdueinvoiceBloc({
    required OverdueInvoiceUsecase overdueInvoiceUsecase,
  })  : _overdueInvoiceUsecase = overdueInvoiceUsecase,
        super(OverdueinvoiceInitial()) {
    on<GetOverdueInvoicesEvent>((event, emit) async {
      emit(OverdueInvoicesLoadingState());
      final response = await _overdueInvoiceUsecase.call(event.params);
      response.fold(
          (l) => emit(OverdueInvoicesErrorState(errorMessage: l.message)),
          (r) => emit(
              OverdueInvoicesSuccessState(overdueInvoiceMainResEntity: r)));
    });
  }
}
