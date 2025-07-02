import 'package:billbooks_app/core/error/failures.dart';
import 'package:billbooks_app/features/creditnotes/data/datasource/credit_note_datasource.dart';
import 'package:billbooks_app/features/creditnotes/domain/entity/credit_notes_list_entity.dart';
import 'package:billbooks_app/features/creditnotes/domain/model/credit_note_list_req_params.dart';
import 'package:billbooks_app/features/creditnotes/domain/repository/credit_note_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/api/api_exception.dart';

class CreditNoteRepositoryImpl implements CreditNoteRepository {
  final CreditNoteRemoteDataSource remoteDataSource;
  CreditNoteRepositoryImpl(this.remoteDataSource);
  @override
  Future<Either<Failure, CreditNoteListMainResponseEntity>> getList(
      CreditNoteListReqParams params) async {
    try {
      final res = await remoteDataSource.getList(params);
      debugPrint("Credit Note Repository: success");
      return right(res);
    } on ApiException catch (e) {
      debugPrint("Credit Note Repository: api exception error");
      return left(Failure(e.message));
    } catch (e) {
      debugPrint("Credit Note Repository: default error");
      return left(Failure(e.toString()));
    }
  }
}
