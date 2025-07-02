import 'package:billbooks_app/features/creditnotes/domain/entity/credit_notes_list_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/model/credit_note_list_req_params.dart';
import '../../domain/usecase/get_credit_notes_usecase.dart';

part 'creditnote_event.dart';
part 'creditnote_state.dart';

class CreditnoteBloc extends Bloc<CreditnoteEvent, CreditnoteState> {
  final GetCreditNotesUsecase _fetchCreditNotes;
  CreditnoteBloc({required GetCreditNotesUsecase fetchCreditNotes})
      : _fetchCreditNotes = fetchCreditNotes,
        super(CreditnoteInitial()) {
    on<CreditnoteLoadEvent>((event, emit) async {
      emit(CreditnoteLoading());
      final response = await _fetchCreditNotes(event.params);
      response.fold((l) => emit(CreditnoteError(message: l.message)),
          (r) => emit(CreditnoteLoaded(creditNotes: r)));
    });
  }
}
