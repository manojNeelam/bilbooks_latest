import 'package:billbooks_app/core/error/failures.dart';
import 'package:billbooks_app/core/usecase/usecase.dart';
import 'package:billbooks_app/features/email%20templates/domain/entity/update_email_template_entity.dart';
import 'package:billbooks_app/features/email%20templates/domain/repository/email_template_repository.dart';
import 'package:fpdart/fpdart.dart';
import '../../presentation/email_template_page.dart';
import '../entity/email_template_entity.dart';
import '../entity/follow_up_estimate_email_template_entity.dart';

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
  final String? templateKey;
  final String? subjectFieldKey;
  final String? messageFieldKey;

  UpdateEmailTemplateReqParams({
    required this.type,
    required this.message,
    required this.subject,
    this.templateKey,
    this.subjectFieldKey,
    this.messageFieldKey,
  });
}

class GetFollowUpeEstimateEmailTemplateUseCase
    implements
        UseCase<FollowUpEstimateEmailTemplateResponseEntity,
            GetFollowUpeEstimateEmailTemplateReqParams> {
  final EmailTemplateRepository emailTemplateRepository;
  GetFollowUpeEstimateEmailTemplateUseCase(
      {required this.emailTemplateRepository});
  @override
  Future<Either<Failure, FollowUpEstimateEmailTemplateResponseEntity>> call(
      GetFollowUpeEstimateEmailTemplateReqParams params) {
    return emailTemplateRepository.getFollowUpEstimateEmailTemplate(params);
  }
}

class GetFollowUpeEstimateEmailTemplateReqParams {
  final String type;
  GetFollowUpeEstimateEmailTemplateReqParams({required this.type});
}

class SetFollowUpeEstimateEmailTemplateUseCase
    implements
        UseCase<UpdateEmailTemplateMainResponseEntity,
            SetFollowUpeEstimateEmailTemplateReqParams> {
  final EmailTemplateRepository emailTemplateRepository;
  SetFollowUpeEstimateEmailTemplateUseCase(
      {required this.emailTemplateRepository});

  @override
  Future<Either<Failure, UpdateEmailTemplateMainResponseEntity>> call(
      SetFollowUpeEstimateEmailTemplateReqParams params) {
    return emailTemplateRepository.updateFollowUpEstimateEmailTemplate(params);
  }
}

class SetFollowUpeEstimateEmailTemplateReqParams {
  final String emailTemplate;
  final String emailSubjectFollowupestimate;
  final String emailMessageFollowupestimate;
  SetFollowUpeEstimateEmailTemplateReqParams(
      {required this.emailTemplate,
      required this.emailSubjectFollowupestimate,
      required this.emailMessageFollowupestimate});
}
