import 'package:billbooks_app/core/error/failures.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/usecase/usecase.dart';
import '../entity/update_credit_note_eitity.dart';
import '../model/credit_note_add_req_params.dart';
import '../repository/credit_note_repository.dart';

class AddCreditNoteUsecase
    implements
        UseCase<UpdateCreditNoteMainResponseEntity, CreditNoteAddReqParams> {
  final CreditNoteRepository repository;
  AddCreditNoteUsecase(this.repository);

  @override
  Future<Either<Failure, UpdateCreditNoteMainResponseEntity>> call(
      CreditNoteAddReqParams params) {
    return repository.updateCreditNoteDetail(params);
  }
}
