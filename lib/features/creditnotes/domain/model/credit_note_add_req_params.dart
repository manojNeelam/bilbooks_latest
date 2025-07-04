class CreditNoteAddReqParams {
  final String? id;
  final String? noteNumber;
  final String? projectId;
  final String? desc;
  final String? amount;
  final String? clientId;
  final String? expiryDate;

  CreditNoteAddReqParams({
    this.id,
    this.noteNumber,
    this.projectId,
    this.desc,
    this.amount,
    this.clientId,
    this.expiryDate,
  });

  toJson() {
    return {
      // "id": id == id,
      "note_no": noteNumber,
      "project_id": projectId,
      "description": desc,
      "amount": amount,
      "client_id": clientId,
      "status": "Unused"
    };
  }
}
