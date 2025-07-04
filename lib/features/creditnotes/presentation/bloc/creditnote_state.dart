part of 'creditnote_bloc.dart';

@immutable
sealed class CreditnoteState {}

final class CreditnoteInitial extends CreditnoteState {}

final class CreditnoteLoading extends CreditnoteState {}

final class CreditnoteLoaded extends CreditnoteState {
  final CreditNoteListMainResponseEntity creditNotes;
  CreditnoteLoaded({required this.creditNotes});
}

final class CreditnoteError extends CreditnoteState {
  final String message;
  CreditnoteError({required this.message});
}

final class CreditnoteDetailLoaded extends CreditnoteState {
  final CreditNoteDetailsMainResEntity creditNoteDetails;
  CreditnoteDetailLoaded({required this.creditNoteDetails});
}

final class CreditnoteDetailError extends CreditnoteState {
  final String message;
  CreditnoteDetailError({required this.message});
}

final class CreditnoteDetailLoading extends CreditnoteState {}

final class CreditnoteAddLoading extends CreditnoteState {}

final class CreditnoteAddLoaded extends CreditnoteState {
  final UpdateCreditNoteMainResponseEntity creditNoteDetails;
  CreditnoteAddLoaded({required this.creditNoteDetails});
}

final class CreditnoteAddError extends CreditnoteState {
  final String message;
  CreditnoteAddError({required this.message});
}

final class CreditNoteDeleteLoading extends CreditnoteState {}

final class CreditNoteDeleteSuccess extends CreditnoteState {
  final CreditNoteDeleteMainResEntity creditNoteDeleteMainResEntity;
  CreditNoteDeleteSuccess({required this.creditNoteDeleteMainResEntity});
}

final class CreditNoteDeleteError extends CreditnoteState {
  final String message;
  CreditNoteDeleteError({required this.message});
}
