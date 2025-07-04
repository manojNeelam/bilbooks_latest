import 'package:billbooks_app/features/creditnotes/domain/entity/credit_note_details_entity.dart';
import 'package:billbooks_app/features/creditnotes/domain/entity/credit_notes_list_entity.dart';
import 'package:billbooks_app/features/creditnotes/domain/model/credit_note_detail_req_params.dart';
import 'package:billbooks_app/features/creditnotes/domain/usecase/delete_credit_note_usecase.dart';
import 'package:billbooks_app/features/more/expenses/domain/usecase/delete_expense_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entity/credit_note_delete_entity.dart';
import '../../domain/entity/update_credit_note_eitity.dart';
import '../../domain/model/credit_note_add_req_params.dart';
import '../../domain/model/credit_note_delete_req_params.dart';
import '../../domain/model/credit_note_list_req_params.dart';
import '../../domain/usecase/add_credit_note_usecase.dart'
    show AddCreditNoteUsecase;
import '../../domain/usecase/get_credit_notes_usecase.dart';

part 'creditnote_event.dart';
part 'creditnote_state.dart';

class CreditnoteBloc extends Bloc<CreditnoteEvent, CreditnoteState> {
  final GetCreditNotesUsecase _fetchCreditNotes;
  final GetCreditNoteDetailUsecase _fetchCreditNoteDetail;
  final AddCreditNoteUsecase _addCreditNote;
  final DeleteCreditNoteUsecase _deleteCreditNoteUsecase;

  CreditnoteBloc({
    required GetCreditNotesUsecase fetchCreditNotes,
    required GetCreditNoteDetailUsecase fetchCreditNoteDetail,
    required AddCreditNoteUsecase addCreditNote,
    required DeleteCreditNoteUsecase deleteCreditNoteUsecase,
  })  : _fetchCreditNotes = fetchCreditNotes,
        _fetchCreditNoteDetail = fetchCreditNoteDetail,
        _addCreditNote = addCreditNote,
        _deleteCreditNoteUsecase = deleteCreditNoteUsecase,
        super(CreditnoteInitial()) {
    on<CreditnoteLoadEvent>((event, emit) async {
      emit(CreditnoteLoading());
      final response = await _fetchCreditNotes(event.params);
      response.fold((l) => emit(CreditnoteError(message: l.message)),
          (r) => emit(CreditnoteLoaded(creditNotes: r)));
    });

    on<CreditnoteGetDetailEvent>((event, emit) async {
      emit(CreditnoteDetailLoading());
      final response = await _fetchCreditNoteDetail.call(event.params);
      response.fold((l) => emit(CreditnoteDetailError(message: l.message)),
          (r) => emit(CreditnoteDetailLoaded(creditNoteDetails: r)));
    });

    on<CreditnoteAddEvent>((event, emit) async {
      emit(CreditnoteAddLoading());
      final response = await _addCreditNote.call(event.params);
      response.fold((l) => emit(CreditnoteAddError(message: l.message)),
          (r) => emit(CreditnoteAddLoaded(creditNoteDetails: r)));
    });

    on<CreditnoteDeleteEvent>((event, emit) async {
      emit(CreditNoteDeleteLoading());

      final response = await _deleteCreditNoteUsecase.call(event.params);
      response.fold(
          (l) => emit(CreditNoteDeleteError(message: l.message)),
          (r) =>
              emit(CreditNoteDeleteSuccess(creditNoteDeleteMainResEntity: r)));
    });
  }
}
