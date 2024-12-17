import 'package:billbooks_app/core/error/failures.dart';
import 'package:billbooks_app/features/email%20templates/data/datasource/remote/email_template_remotedatasource.dart';

import 'package:billbooks_app/features/email%20templates/domain/entity/email_template_entity.dart';
import 'package:billbooks_app/features/email%20templates/domain/entity/update_email_template_entity.dart';
import 'package:billbooks_app/features/email%20templates/domain/usecase/email_template_usecase.dart';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/api/api_exception.dart';
import '../../domain/repository/email_template_repository.dart';

class EmailTemplateRepositoryImpl implements EmailTemplateRepository {
  final EmailTemplateRemotedatasource emailTemplateRemotedatasource;
  EmailTemplateRepositoryImpl({required this.emailTemplateRemotedatasource});

  @override
  Future<Either<Failure, EmailTemplateMainResponseEntity>> getEmailTemplates(
      EmailTemplateReqParams params) async {
    try {
      final res =
          await emailTemplateRemotedatasource.getEmaillTemplates(params);
      debugPrint("Email Templates Repository: success");
      return right(res);
    } on ApiException catch (e) {
      debugPrint("Email Templates: api exception error");
      return left(Failure(e.message));
    } catch (e) {
      debugPrint("Email Templates Repository: default error");
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UpdateEmailTemplateMainResponseEntity>>
      updateEmailTemplate(UpdateEmailTemplateReqParams params) async {
    try {
      final res =
          await emailTemplateRemotedatasource.updateEmailTemplate(params);
      debugPrint("Email Templates Repository: success");
      return right(res);
    } on ApiException catch (e) {
      debugPrint("Email Templates: api exception error");
      return left(Failure(e.message));
    } catch (e) {
      debugPrint("Email Templates Repository: default error");
      return left(Failure(e.toString()));
    }
  }
}
