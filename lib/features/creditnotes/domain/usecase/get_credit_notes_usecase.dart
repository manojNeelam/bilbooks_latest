import 'package:billbooks_app/core/error/failures.dart';
import 'package:billbooks_app/core/usecase/usecase.dart';
import 'package:billbooks_app/features/creditnotes/domain/entity/credit_note_details_entity.dart';
import 'package:billbooks_app/features/creditnotes/domain/entity/credit_notes_list_entity.dart';
import 'package:billbooks_app/features/creditnotes/domain/model/credit_note_detail_req_params.dart';
import 'package:fpdart/fpdart.dart';

import '../model/credit_note_list_req_params.dart';
import '../repository/credit_note_repository.dart';

class GetCreditNotesUsecase
    implements
        UseCase<CreditNoteListMainResponseEntity, CreditNoteListReqParams> {
  final CreditNoteRepository repository;
  GetCreditNotesUsecase(this.repository);
  @override
  Future<Either<Failure, CreditNoteListMainResponseEntity>> call(
      CreditNoteListReqParams params) {
    return repository.getList(params);
  }
}

class GetCreditNoteDetailUsecase
    implements
        UseCase<CreditNoteDetailsMainResEntity, CreditNoteDetailReqParams> {
  final CreditNoteRepository repository;
  GetCreditNoteDetailUsecase(this.repository);

  @override
  Future<Either<Failure, CreditNoteDetailsMainResEntity>> call(
      CreditNoteDetailReqParams params) {
    return repository.getCreditNoteDetail(params);
  }
}
