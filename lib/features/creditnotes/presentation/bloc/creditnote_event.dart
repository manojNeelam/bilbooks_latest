part of 'creditnote_bloc.dart';

@immutable
sealed class CreditnoteEvent {}

class CreditnoteLoadEvent extends CreditnoteEvent {
  final CreditNoteListReqParams params;

  CreditnoteLoadEvent(this.params);
}
