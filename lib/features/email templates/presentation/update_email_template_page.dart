import 'package:auto_route/auto_route.dart';
import 'package:billbooks_app/core/app_constants.dart';
import 'package:billbooks_app/core/theme/app_fonts.dart';
import 'package:billbooks_app/core/theme/app_pallete.dart';
import 'package:billbooks_app/core/utils/show_toast.dart';
import 'package:billbooks_app/core/utils/utils.dart';
import 'package:billbooks_app/features/email%20templates/domain/usecase/email_template_usecase.dart';
import 'package:billbooks_app/features/email%20templates/presentation/bloc/email_templates_bloc.dart';
import 'package:billbooks_app/features/email%20templates/presentation/email_template_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';

import '../../../core/widgets/loading_page.dart';

@RoutePage()
class UpdateEmailTemplatePage extends StatefulWidget {
  final EnumEmailTemplate type;
  final String title;
  final String subject, message;
  const UpdateEmailTemplatePage(
      {super.key,
      required this.title,
      required this.message,
      required this.subject,
      required this.type});

  @override
  State<UpdateEmailTemplatePage> createState() =>
      _UpdateEmailTemplatePageState();
}

class _UpdateEmailTemplatePageState extends State<UpdateEmailTemplatePage> {
  TextEditingController subjectController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  @override
  void initState() {
    subjectController.text = widget.subject;
    messageController.text = widget.message;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: AppConstants.getAppBarDivider,
        title: Text(widget.title),
        actions: [
          TextButton(
              onPressed: () {
                context.read<EmailTemplatesBloc>().add(SetEmailTemplateEvent(
                    params: UpdateEmailTemplateReqParams(
                        type: widget.type,
                        message: messageController.text,
                        subject: subjectController.text)));
              },
              child: Text(
                "Save",
                style: AppFonts.regularStyle(color: AppPallete.blueColor),
              ))
        ],
      ),
      body: GestureDetector(
        onTap: () {
          Utils.hideKeyboard();
        },
        child: BlocConsumer<EmailTemplatesBloc, EmailTemplatesState>(
          listener: (context, state) {
            // TODO: implement listener
            if (state is UpdateEmailTemplatesSuccessState) {
              showToastification(
                  context,
                  state.updateEmailTemplateEntity.data?.message ??
                      "Email templates saved successfully",
                  ToastificationType.success);
              AutoRouter.of(context).maybePop();
            }
            if (state is UpdateEmailTemplatesErrorState) {
              showToastification(
                  context, state.errorMessage, ToastificationType.error);
            }
            if (state is UpdateEmailTemplateLoadingState) {
              debugPrint("Loading");
            }
          },
          builder: (context, state) {
            if (state is UpdateEmailTemplateLoadingState) {
              return const LoadingPage(title: "Updating email template...");
            }
            return SingleChildScrollView(
              child: Container(
                color: AppPallete.kF2F2F2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color: AppPallete.kF2F2F2,
                      padding: AppConstants.horizonta16lVerticalPadding10,
                      child: Text(
                        "Subject",
                        style: AppFonts.regularStyle(),
                      ),
                    ),
                    Container(
                      color: AppPallete.white,
                      padding: AppConstants.horizotal16,
                      child: TextField(
                        controller: subjectController,
                        style: AppFonts.regularStyle(),
                        decoration: InputDecoration(
                            hintText: "Subject",
                            isDense: true,
                            contentPadding: AppConstants.contentViewPadding,
                            fillColor: AppPallete.white,
                            filled: true,
                            border: InputBorder.none,
                            hintStyle: AppFonts.hintStyle()),
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                    Container(
                      color: AppPallete.kF2F2F2,
                      padding: AppConstants.horizonta16lVerticalPadding10,
                      child: Text(
                        "Message",
                        style: AppFonts.regularStyle(),
                      ),
                    ),
                    Container(
                      color: AppPallete.white,
                      padding: AppConstants.horizotal16,
                      child: TextField(
                        controller: messageController,
                        minLines: 8,
                        maxLines: 12,
                        style: AppFonts.regularStyle(),
                        decoration: InputDecoration(
                            hintText: "Message",
                            isDense: true,
                            contentPadding: AppConstants.contentViewPadding,
                            fillColor: AppPallete.white,
                            filled: true,
                            border: InputBorder.none,
                            hintStyle: AppFonts.hintStyle()),
                        textInputAction: TextInputAction.newline,
                      ),
                    ),
                    Container(
                      padding: AppConstants.horizonta16lVerticalPadding10,
                      child: Text(
                        "Placeholder",
                        style: AppFonts.regularStyle(),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
