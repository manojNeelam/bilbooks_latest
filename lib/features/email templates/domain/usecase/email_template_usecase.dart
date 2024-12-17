import 'package:billbooks_app/core/error/failures.dart';
import 'package:billbooks_app/core/usecase/usecase.dart';
import 'package:billbooks_app/features/email%20templates/domain/entity/update_email_template_entity.dart';
import 'package:billbooks_app/features/email%20templates/domain/repository/email_template_repository.dart';
import 'package:fpdart/fpdart.dart';
import '../../presentation/email_template_page.dart';
import '../entity/email_template_entity.dart';

class EmailTemplateUsecase
    implements
        UseCase<EmailTemplateMainResponseEntity, EmailTemplateReqParams> {
  final EmailTemplateRepository emailTemplateRepository;
  EmailTemplateUsecase({required this.emailTemplateRepository});

  @override
  Future<Either<Failure, EmailTemplateMainResponseEntity>> call(
      EmailTemplateReqParams params) {
    return emailTemplateRepository.getEmailTemplates(params);
  }
}

class EmailTemplateReqParams {}

class UpDateEmailTemplateUsecase
    implements
        UseCase<UpdateEmailTemplateMainResponseEntity,
            UpdateEmailTemplateReqParams> {
  final EmailTemplateRepository emailTemplateRepository;
  UpDateEmailTemplateUsecase({required this.emailTemplateRepository});
  @override
  Future<Either<Failure, UpdateEmailTemplateMainResponseEntity>> call(
      UpdateEmailTemplateReqParams params) {
    return emailTemplateRepository.updateEmailTemplate(params);
  }
}

class UpdateEmailTemplateReqParams {
  String? message, subject;
  final EnumEmailTemplate type;

  UpdateEmailTemplateReqParams({
    required this.type,
    required this.message,
    required this.subject,
  });
}
