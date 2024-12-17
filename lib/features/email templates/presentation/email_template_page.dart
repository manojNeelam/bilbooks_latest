import 'package:auto_route/auto_route.dart';
import 'package:billbooks_app/core/app_constants.dart';
import 'package:billbooks_app/core/theme/app_fonts.dart';
import 'package:billbooks_app/core/theme/app_pallete.dart';
import 'package:billbooks_app/features/email%20templates/domain/usecase/email_template_usecase.dart';
import 'package:billbooks_app/features/email%20templates/presentation/bloc/email_templates_bloc.dart';
import 'package:billbooks_app/features/line%20item/presentation/add_new_line_item_page.dart';
import 'package:billbooks_app/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../domain/entity/email_template_entity.dart';

enum EnumEmailTemplate { invoice, estimate, remainder, thankyou }

extension EnumEmailTemplateExtension on EnumEmailTemplate {
  bool get isSendInvoice {
    return this == EnumEmailTemplate.invoice;
  }

  bool get isSendEstimate {
    return this == EnumEmailTemplate.estimate;
  }

  bool get isPaymentReminder {
    return this == EnumEmailTemplate.remainder;
  }

  bool get isPaymentThankyou {
    return this == EnumEmailTemplate.thankyou;
  }

  //Required sendinvoice/sendestimate/paymentreminder/paymentthankyou
  String get emailTemplate {
    switch (this) {
      case EnumEmailTemplate.invoice:
        return "sendinvoice";

      case EnumEmailTemplate.estimate:
        return "sendestimate";

      case EnumEmailTemplate.remainder:
        return "paymentreminder";

      case EnumEmailTemplate.thankyou:
        return "paymentthankyou";
    }
  }

  (String, String) get titleandDesc {
    switch (this) {
      case EnumEmailTemplate.invoice:
        return (
          "Send Invoice",
          "Email that goes out when you send invoice to your client"
        );
      case EnumEmailTemplate.estimate:
        return (
          "Send Estimate",
          "Email that goes out when you send estimates to your clients"
        );
      case EnumEmailTemplate.remainder:
        return (
          "Payment Remainder",
          "Set message for sending payment remainders"
        );
      case EnumEmailTemplate.thankyou:
        return (
          "Payment Thank-you",
          "Message sent upon receiving a successful payment"
        );
    }
  }
}

@RoutePage()
class EmailTemplatePage extends StatefulWidget {
  const EmailTemplatePage({super.key});

  @override
  State<EmailTemplatePage> createState() => _EmailTemplatePageState();
}

class _EmailTemplatePageState extends State<EmailTemplatePage> {
  bool isLoading = false;
  EmailtemplatesEntity? emailtemplatesEntity;

  @override
  void initState() {
    _getEmailTemplates();
    super.initState();
  }

  void _getEmailTemplates() {
    context
        .read<EmailTemplatesBloc>()
        .add(GetEmailTemplatesEvent(params: EmailTemplateReqParams()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Email Template"),
        bottom: AppConstants.getAppBarDivider,
      ),
      body: BlocConsumer<EmailTemplatesBloc, EmailTemplatesState>(
        listener: (context, state) {
          if (state is EmailTemplatesLoadingState) {
            isLoading = true;
          }
          if (state is EmailTemplatesSuccessState) {
            isLoading = false;
            emailtemplatesEntity = state.emailtemplatesEntity;
          }
          if (state is EmailTemplatesErrorState) {
            isLoading = false;
          }
        },
        builder: (context, state) {
          return Skeletonizer(
            enabled: isLoading,
            child: ListView.builder(
                itemCount: EnumEmailTemplate.values.length,
                itemBuilder: (context, index) {
                  final item = EnumEmailTemplate.values[index];
                  final (String title, String desc) = item.titleandDesc;
                  return GestureDetector(
                      onTap: () {
                        switch (item) {
                          case EnumEmailTemplate.invoice:
                            AutoRouter.of(context).push(
                                UpdateEmailTemplatePageRoute(
                                    title: "Send Invoice",
                                    subject: emailtemplatesEntity
                                            ?.emailSubjectSendinvoice ??
                                        "",
                                    message: emailtemplatesEntity
                                            ?.emailMessageSendinvoice ??
                                        "",
                                    type: EnumEmailTemplate.invoice));
                          case EnumEmailTemplate.estimate:
                            AutoRouter.of(context).push(
                                UpdateEmailTemplatePageRoute(
                                    title: "Send Estimate",
                                    message: emailtemplatesEntity
                                            ?.emailMessageSendestimate ??
                                        "",
                                    subject: emailtemplatesEntity
                                            ?.emailSubjectSendestimate ??
                                        "",
                                    type: EnumEmailTemplate.estimate));
                          case EnumEmailTemplate.remainder:
                            AutoRouter.of(context).push(
                                UpdateEmailTemplatePageRoute(
                                    title: "Payment Reminder",
                                    message: emailtemplatesEntity
                                            ?.emailMessagePaymentreminder ??
                                        "",
                                    subject: emailtemplatesEntity
                                            ?.emailSubjectPaymentreminder ??
                                        "",
                                    type: EnumEmailTemplate.remainder));
                          case EnumEmailTemplate.thankyou:
                            AutoRouter.of(context).push(
                                UpdateEmailTemplatePageRoute(
                                    title: "Payment Thank-you",
                                    message: emailtemplatesEntity
                                            ?.emailMessagePaymentthankyou ??
                                        "",
                                    subject: emailtemplatesEntity
                                            ?.emailSubjectPaymentthankyou ??
                                        "",
                                    type: EnumEmailTemplate.thankyou));
                        }
                      },
                      child: EmailTemplateWidget(title: title, desc: desc));
                }),
          );
        },
      ),
    );
  }
}

class EmailTemplateWidget extends StatelessWidget {
  const EmailTemplateWidget({
    super.key,
    required this.title,
    required this.desc,
  });

  final String title;
  final String desc;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppConstants.horizotal16,
      color: AppPallete.white,
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: AppConstants.verticalPadding10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppFonts.regularStyle(),
                  ),
                  Text(
                    desc,
                    style: AppFonts.regularStyle(
                        color: AppPallete.k666666, size: 14),
                  )
                ],
              ),
            ),
          ),
          AppConstants.sizeBoxWidth10,
          const Icon(
            Icons.chevron_right,
            color: AppPallete.borderColor,
          )
        ],
      ),
    );
  }
}
