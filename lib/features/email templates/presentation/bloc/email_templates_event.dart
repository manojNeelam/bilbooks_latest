part of 'email_templates_bloc.dart';

@immutable
sealed class EmailTemplatesEvent {}

class GetEmailTemplatesEvent extends EmailTemplatesEvent {
  final EmailTemplateReqParams params;
  GetEmailTemplatesEvent({required this.params});
}

class SetEmailTemplateEvent extends EmailTemplatesEvent {
  final UpdateEmailTemplateReqParams params;
  SetEmailTemplateEvent({required this.params});
}
