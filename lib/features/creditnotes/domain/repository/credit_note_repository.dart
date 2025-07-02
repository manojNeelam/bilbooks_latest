import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../entity/credit_notes_list_entity.dart';
import '../model/credit_note_list_req_params.dart';

abstract interface class CreditNoteRepository {
  Future<Either<Failure, CreditNoteListMainResponseEntity>> getList(
      CreditNoteListReqParams params);
}
