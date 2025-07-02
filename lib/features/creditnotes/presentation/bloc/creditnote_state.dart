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
