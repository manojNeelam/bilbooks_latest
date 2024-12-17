part of 'email_templates_bloc.dart';

@immutable
sealed class EmailTemplatesState {}

final class EmailTemplatesInitial extends EmailTemplatesState {}

final class EmailTemplatesLoadingState extends EmailTemplatesState {}

final class EmailTemplatesErrorState extends EmailTemplatesState {
  final String errorMessage;
  EmailTemplatesErrorState({required this.errorMessage});
}

final class EmailTemplatesSuccessState extends EmailTemplatesState {
  final EmailtemplatesEntity emailtemplatesEntity;
  EmailTemplatesSuccessState({required this.emailtemplatesEntity});
}

final class UpdateEmailTemplateLoadingState extends EmailTemplatesState {}

final class UpdateEmailTemplatesErrorState extends EmailTemplatesState {
  final String errorMessage;
  UpdateEmailTemplatesErrorState({required this.errorMessage});
}

final class UpdateEmailTemplatesSuccessState extends EmailTemplatesState {
  final UpdateEmailTemplateMainResponseEntity updateEmailTemplateEntity;
  UpdateEmailTemplatesSuccessState({required this.updateEmailTemplateEntity});
}
