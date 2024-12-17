import 'package:billbooks_app/features/email%20templates/domain/entity/email_template_entity.dart';
import 'package:billbooks_app/features/email%20templates/domain/usecase/email_template_usecase.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entity/update_email_template_entity.dart';

part 'email_templates_event.dart';
part 'email_templates_state.dart';

class EmailTemplatesBloc
    extends Bloc<EmailTemplatesEvent, EmailTemplatesState> {
  final EmailTemplateUsecase _emailTemplateUsecase;
  final UpDateEmailTemplateUsecase _upDateEmailTemplateUsecase;

  EmailTemplatesBloc(
      {required EmailTemplateUsecase emailTemplateUsecase,
      required UpDateEmailTemplateUsecase upDateEmailTemplateUsecase})
      : _emailTemplateUsecase = emailTemplateUsecase,
        _upDateEmailTemplateUsecase = upDateEmailTemplateUsecase,
        super(EmailTemplatesInitial()) {
    on<GetEmailTemplatesEvent>((event, emit) async {
      emit(EmailTemplatesLoadingState());
      final response = await _emailTemplateUsecase.call(event.params);
      response.fold(
          (l) => emit(EmailTemplatesErrorState(errorMessage: l.message)),
          (r) => emit(EmailTemplatesSuccessState(
              emailtemplatesEntity: r.data!.emailtemplates!)));
    });

    on<SetEmailTemplateEvent>((event, emit) async {
      emit(UpdateEmailTemplateLoadingState());
      final response = await _upDateEmailTemplateUsecase.call(event.params);
      response.fold(
          (l) => emit(UpdateEmailTemplatesErrorState(errorMessage: l.message)),
          (r) => emit(
              UpdateEmailTemplatesSuccessState(updateEmailTemplateEntity: r)));
    });
  }
}
