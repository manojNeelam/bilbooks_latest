import 'package:billbooks_app/core/error/failures.dart';
import 'package:billbooks_app/features/email%20templates/domain/entity/email_template_entity.dart';
import 'package:billbooks_app/features/email%20templates/domain/entity/update_email_template_entity.dart';
import 'package:fpdart/fpdart.dart';

import '../usecase/email_template_usecase.dart';

abstract interface class EmailTemplateRepository {
  Future<Either<Failure, EmailTemplateMainResponseEntity>> getEmailTemplates(
      EmailTemplateReqParams params);

  Future<Either<Failure, UpdateEmailTemplateMainResponseEntity>>
      updateEmailTemplate(UpdateEmailTemplateReqParams params);
}
