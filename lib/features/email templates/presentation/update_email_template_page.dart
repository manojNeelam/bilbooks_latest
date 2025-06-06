import 'package:auto_route/auto_route.dart';
import 'package:billbooks_app/core/app_constants.dart';
import 'package:billbooks_app/core/theme/app_fonts.dart';
import 'package:billbooks_app/core/theme/app_pallete.dart';
import 'package:billbooks_app/core/utils/show_toast.dart';
import 'package:billbooks_app/core/utils/utils.dart';
import 'package:billbooks_app/features/email%20templates/domain/usecase/email_template_usecase.dart';
import 'package:billbooks_app/features/email%20templates/presentation/bloc/email_templates_bloc.dart';
import 'package:billbooks_app/features/email%20templates/presentation/email_template_page.dart';
import 'package:chip_list/chip_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';

import '../../../core/widgets/loading_page.dart';

@RoutePage()
class UpdateEmailTemplatePage extends StatefulWidget {
  final EnumEmailTemplate type;
  final String title;
  final String subject, message;
  final void Function()? refreshPage;
  const UpdateEmailTemplatePage({
    super.key,
    required this.title,
    required this.message,
    required this.subject,
    required this.type,
    required this.refreshPage,
  });

  @override
  State<UpdateEmailTemplatePage> createState() =>
      _UpdateEmailTemplatePageState();
}

class _UpdateEmailTemplatePageState extends State<UpdateEmailTemplatePage> {
  FocusNode? messageFocusNode;
  FocusNode? subjectFocusNode;

  TextEditingController subjectController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  //final List<String> _filters = [];
  // final List<String> sendInvoiceList = [
  //   'invoice-date',
  //   'invoice-number',
  //   'po-number',
  //   'due-date',
  //   'total-amount',
  //   'shipping-charge',
  //   'balance-due',
  //   'overdue-days',
  //   'invoice-title',
  //   'invoice-notes',
  //   'invoice-url',
  //   'project-name',
  //   'client-name',
  //   'client-contact-name',
  //   'organization-name',
  //   'user-name',
  // ];
  // final List<String> paymentReminder = [
  //   'invoice-date',
  //   'invoice-number',
  //   'po-number',
  //   'due-date',
  //   'total-amount',
  //   'shipping-charge',
  //   'balance-due',
  //   'overdue-days',
  //   'invoice-title',
  //   'invoice-notes',
  //   'invoice-url',
  //   'project-name',
  //   'client-name',
  //   'client-contact-name',
  //   'organization-name',
  //   'user-name',
  // ];
  // final List<String> sendEstimateList = [
  //   'estimate-date',
  //   'estimate-number',
  //   'po-number',
  //   'expiry-date',
  //   'total-amount',
  //   'shipping-charge',
  //   'estimate-title',
  //   'invoice-notes',
  //   'invoice-url',
  //   'project-name',
  //   'client-name',
  //   'client-contact-name',
  //   'organization-name',
  //   'user-name',
  // ];
  // final List<String> paymentThankYouList = [
  //   'invoice-date',
  //   'invoice-number',
  //   'po-number',
  //   'due-date',
  //   'total-amount',
  //   'amount-paid',
  //   'balance-due',
  //   'invoice-title',
  //   'invoice-notes',
  //   'invoice-url',
  //   'project-name',
  //   'payment-date',
  //   'payment-received',
  //   'payment-method',
  //   'payment-refno',
  //   'client-name',
  //   'client-contact-name',
  //   'organization-name',
  //   'user-name',
  // ];
  int _currentIndex = -1;

  @override
  void initState() {
    messageFocusNode = FocusNode();
    subjectFocusNode = FocusNode();
    subjectController.text = widget.subject;
    messageController.text = widget.message;
    super.initState();
  }

  @override
  void dispose() {
    messageFocusNode?.dispose();
    subjectFocusNode?.dispose();
    super.dispose();
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
              if (widget.refreshPage != null) {
                widget.refreshPage!();
              }
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
                constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height),
                //height: MediaQuery.of(context).size.height,
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
                        focusNode: subjectFocusNode,
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
                        focusNode: messageFocusNode,
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: ChipList(
                          //padding: EdgeInsets.all(10),
                          extraOnToggle: (index) {
                            debugPrint(sendInvoiceList[index]);
                            _currentIndex = index;
                            setState(() {});

                            if (messageFocusNode!.hasFocus) {
                              debugPrint("Message is active");
                              final selection = messageController.selection;
                              final offset = selection.baseOffset;
                              messageController.value = messageController.value
                                  .replaced(TextRange.collapsed(offset),
                                      " [${sendInvoiceList[index]}] ");
                            }
                            if (subjectFocusNode!.hasFocus) {
                              debugPrint("Subject is active");
                              final selection = subjectController.selection;
                              final offset = selection.baseOffset;
                              subjectController.value = subjectController.value
                                  .replaced(TextRange.collapsed(offset),
                                      " [${sendInvoiceList[index]}] ");
                            }

                            Future.delayed(Duration(milliseconds: 200), () {
                              _currentIndex = -1;
                              setState(() {});
                            });
                          },
                          widgetSpacing: 2,
                          shouldWrap: true,
                          showCheckmark: false,
                          listOfChipNames: widget.type.emailTemplateList,
                          style: AppFonts.regularStyle(),
                          activeTextColorList: [AppPallete.white],
                          inactiveTextColorList: [AppPallete.blueColor],
                          activeBgColorList: [AppPallete.blueColor],
                          inactiveBgColorList: [AppPallete.kF2F2F2],
                          activeBorderColorList: [AppPallete.blueColor],
                          inactiveBorderColorList: [AppPallete.blueColor],
                          borderRadiiList: [10],
                          listOfChipIndicesCurrentlySelected: [_currentIndex]),
                    )
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
