import 'package:bloc/bloc.dart';
import 'package:billbooks_app/features/proforma/domain/entities/proforma_details_entity.dart';
import 'package:billbooks_app/features/proforma/domain/entities/proforma_list_entity.dart';
import 'package:billbooks_app/features/proforma/domain/usecase/proforma_list_usecase.dart';
import 'package:meta/meta.dart';

part 'proforma_event.dart';
part 'proforma_state.dart';

class ProformaBloc extends Bloc<ProformaEvent, ProformaState> {
  final ProformaListUsecase _proformaListUsecase;
  final GetProformaDetailsUsecase _getProformaDetailsUsecase;

  ProformaBloc(
      {required ProformaListUsecase proformaListUsecase,
      required GetProformaDetailsUsecase getProformaDetailsUsecase})
      : _proformaListUsecase = proformaListUsecase,
        _getProformaDetailsUsecase = getProformaDetailsUsecase,
        super(ProformaInitial()) {
    on<GetProformaListEvent>((event, emit) async {
      emit(ProformaListLoadingState());
      final response = await _proformaListUsecase.call(event.params);
      response.fold(
        (l) => emit(ProformaListFailureState(errorMessage: l.message)),
        (r) => emit(ProformaListSuccessState(proformaListMainResEntity: r)),
      );
    });

    on<GetProformaDetailsEvent>((event, emit) async {
      emit(ProformaDetailsLoadingState());
      final response = await _getProformaDetailsUsecase.call(event.params);
      response.fold(
        (l) => emit(ProformaDetailsFailureState(errorMessage: l.message)),
        (r) => emit(
          ProformaDetailsSuccessState(proformaDetailResEntity: r.data!),
        ),
      );
    });
  }
}
