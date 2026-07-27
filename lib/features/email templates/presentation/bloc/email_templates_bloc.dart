import 'package:billbooks_app/features/email%20templates/domain/entity/email_template_entity.dart';
import 'package:billbooks_app/features/email%20templates/domain/usecase/email_template_usecase.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entity/follow_up_estimate_email_template_entity.dart';
import '../../domain/entity/update_email_template_entity.dart';

part 'email_templates_event.dart';
part 'email_templates_state.dart';

class EmailTemplatesBloc
    extends Bloc<EmailTemplatesEvent, EmailTemplatesState> {
  final EmailTemplateUsecase _emailTemplateUsecase;
  final UpDateEmailTemplateUsecase _upDateEmailTemplateUsecase;
  final GetFollowUpeEstimateEmailTemplateUseCase
      _getFollowUpeEstimateEmailTemplateUseCase;
  final SetFollowUpeEstimateEmailTemplateUseCase
      _setFollowUpeEstimateEmailTemplateUseCase;

  EmailTemplatesBloc(
      {required EmailTemplateUsecase emailTemplateUsecase,
      required UpDateEmailTemplateUsecase upDateEmailTemplateUsecase,
      required GetFollowUpeEstimateEmailTemplateUseCase
          getFollowUpeEstimateEmailTemplateUseCase,
      required SetFollowUpeEstimateEmailTemplateUseCase
          setFollowUpeEstimateEmailTemplateUseCase})
      : _emailTemplateUsecase = emailTemplateUsecase,
        _upDateEmailTemplateUsecase = upDateEmailTemplateUsecase,
        _getFollowUpeEstimateEmailTemplateUseCase =
            getFollowUpeEstimateEmailTemplateUseCase,
        _setFollowUpeEstimateEmailTemplateUseCase =
            setFollowUpeEstimateEmailTemplateUseCase,
        super(EmailTemplatesInitial()) {
    on<GetEmailTemplatesEvent>((event, emit) async {
      emit(EmailTemplatesLoadingState());
      final response = await _emailTemplateUsecase.call(event.params);
      response.fold(
          (l) => emit(EmailTemplatesErrorState(errorMessage: l.message)),
          (r) => emit(EmailTemplatesSuccessState(
              emailtemplatesEntity: r.data!.emailtemplates!)));
    });

    on<GetFollowUpEstimateEvent>((event, emit) async {
      emit(GetFollowUpEstimateEmailTemplateLoadingState());
      final response =
          await _getFollowUpeEstimateEmailTemplateUseCase.call(event.params);
      response.fold(
          (l) => emit(GetFollowUpEstimateEmailTemplatesErrorState(
              errorMessage: l.message)),
          (r) => emit(GetFollowUpEstimateEmailTemplatesSuccessState(
              followUpEstimateEmailTemplateResponseEntity: r)));
    });

    on<SetFollowUpEstimateEmailTemplateEvent>((event, emit) async {
      emit(UpdateEmailTemplateLoadingState());
      final response =
          await _setFollowUpeEstimateEmailTemplateUseCase.call(event.params);
      response.fold(
          (l) => emit(UpdateEmailTemplatesErrorState(errorMessage: l.message)),
          (r) => emit(
              UpdateEmailTemplatesSuccessState(updateEmailTemplateEntity: r)));
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
