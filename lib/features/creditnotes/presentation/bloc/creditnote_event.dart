part of 'creditnote_bloc.dart';

@immutable
sealed class CreditnoteEvent {}

class CreditnoteLoadEvent extends CreditnoteEvent {
  final CreditNoteListReqParams params;

  CreditnoteLoadEvent(this.params);
}

class CreditnoteGetDetailEvent extends CreditnoteEvent {
  final CreditNoteDetailReqParams params;
  CreditnoteGetDetailEvent(this.params);
}

class CreditnoteAddEvent extends CreditnoteEvent {
  final CreditNoteAddReqParams params;
  CreditnoteAddEvent(this.params);
}
