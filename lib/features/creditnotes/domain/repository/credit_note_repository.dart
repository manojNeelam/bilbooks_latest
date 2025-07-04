import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../entity/credit_note_delete_entity.dart';
import '../entity/credit_note_details_entity.dart';
import '../entity/credit_notes_list_entity.dart';
import '../entity/update_credit_note_eitity.dart';
import '../model/credit_note_add_req_params.dart';
import '../model/credit_note_delete_req_params.dart';
import '../model/credit_note_detail_req_params.dart';
import '../model/credit_note_list_req_params.dart';

abstract interface class CreditNoteRepository {
  Future<Either<Failure, CreditNoteListMainResponseEntity>> getList(
      CreditNoteListReqParams params);

  Future<Either<Failure, CreditNoteDetailsMainResEntity>> getCreditNoteDetail(
      CreditNoteDetailReqParams params);

  Future<Either<Failure, UpdateCreditNoteMainResponseEntity>>
      updateCreditNoteDetail(CreditNoteAddReqParams params);
  Future<Either<Failure, CreditNoteDeleteMainResEntity>> deleteCreditNote(
      CreditNoteDeleteReqParams params);
}
