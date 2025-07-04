import 'package:billbooks_app/core/error/failures.dart';
import 'package:billbooks_app/core/usecase/usecase.dart';
import 'package:fpdart/src/either.dart';

import '../entity/credit_note_delete_entity.dart';
import '../model/credit_note_delete_req_params.dart';
import '../repository/credit_note_repository.dart';

class DeleteCreditNoteUsecase
    implements
        UseCase<CreditNoteDeleteMainResEntity, CreditNoteDeleteReqParams> {
  final CreditNoteRepository repository;
  DeleteCreditNoteUsecase({required this.repository});

  @override
  Future<Either<Failure, CreditNoteDeleteMainResEntity>> call(
      CreditNoteDeleteReqParams params) {
    return repository.deleteCreditNote(params);
  }
}
