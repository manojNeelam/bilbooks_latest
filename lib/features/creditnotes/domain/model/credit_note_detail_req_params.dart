class CreditNoteDetailReqParams {
  final String creditNoteId;
  CreditNoteDetailReqParams({required this.creditNoteId});
  Map<String, dynamic> toJson() {
    return {
      'id': creditNoteId,
    };
  }
}
