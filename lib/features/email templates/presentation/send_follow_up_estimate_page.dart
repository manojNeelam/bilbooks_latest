import 'package:auto_route/auto_route.dart';
import 'package:billbooks_app/core/utils/show_toast.dart';
import 'package:billbooks_app/core/utils/utils.dart';
import 'package:chip_list/chip_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';

import '../../../core/app_constants.dart';
import '../../../core/theme/app_fonts.dart';
import '../../../core/theme/app_pallete.dart';
import '../../../core/widgets/loading_page.dart';
import '../../../router/app_router.dart';
import '../domain/entity/follow_up_estimate_email_template_entity.dart';
import '../domain/usecase/email_template_usecase.dart';
import 'bloc/email_templates_bloc.dart';
import 'email_template_page.dart';
import 'widgets/follow_up_header_widget.dart';

@RoutePage()
class SendFollowUpEstimatePage extends StatefulWidget {
  const SendFollowUpEstimatePage({super.key});

  @override
  State<SendFollowUpEstimatePage> createState() =>
      _SendFollowUpEstimatePageState();
}

class _SendFollowUpEstimatePageState extends State<SendFollowUpEstimatePage> {
  FocusNode? messageFocusNode;
  FocusNode? subjectFocusNode;

  TextEditingController subjectController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  EnumFollowUpEstimateType selectedType = EnumFollowUpEstimateType.email1;
  int currentPage = 1;
  FollowUpEstimateEmailtemplatesEntity? followUpEstimateEmailtemplatesEntity;
  int _currentIndex = -1;

  @override
  void initState() {
    messageFocusNode = FocusNode();
    subjectFocusNode = FocusNode();
    subjectController.text = "Send Follow-Up Estimate";
    messageController.text = "Send Follow-Up Estimate";
    loadData();
    super.initState();
  }

  loadData({String emailType = "followupestimate_1"}) {
    context.read<EmailTemplatesBloc>().add(GetFollowUpEstimateEvent(
        params: GetFollowUpeEstimateEmailTemplateReqParams(type: emailType)));
  }

  updateEmailTemplate({String emailType = "followupestimate_1"}) {
    context
        .read<EmailTemplatesBloc>()
        .add(SetFollowUpEstimateEmailTemplateEvent(
            params: SetFollowUpeEstimateEmailTemplateReqParams(
          emailTemplate: emailType,
          emailSubjectFollowupestimate: subjectController.text,
          emailMessageFollowupestimate: messageController.text,
        )));
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
          title: Text("Follow Up Estimate"),
          bottom: PreferredSize(
              preferredSize: const Size.fromHeight(45),
              child: FollowUpHeaderWidget(
                selectedType: selectedType,
                callBack: (type) {
                  selectedType = type;
                  debugPrint(type.apiParams);
                  loadData(emailType: selectedType.apiParams);
                  setState(() {});
                },
              )),
          actions: [
            TextButton(
                onPressed: () {
                  updateEmailTemplate(emailType: selectedType.apiParams);
                },
                child: Text(
                  "Save",
                  style: AppFonts.regularStyle(),
                ))
          ],
        ),
        body: GestureDetector(
          onTap: () {
            Utils.hideKeyboard();
          },
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
            child: BlocConsumer<EmailTemplatesBloc, EmailTemplatesState>(
              listener: (context, state) {
                if (state is UpdateEmailTemplatesSuccessState) {
                  showToastification(context, "Successfully updated",
                      ToastificationType.success);
                }
                if (state is UpdateEmailTemplatesErrorState) {
                  showToastification(
                      context, state.errorMessage, ToastificationType.error);
                }
                if (state is GetFollowUpEstimateEmailTemplatesSuccessState) {
                  final responseModel = state
                      .followUpEstimateEmailTemplateResponseEntity
                      .data
                      ?.emailtemplates;
                  followUpEstimateEmailtemplatesEntity = responseModel;
                  subjectController.text = followUpEstimateEmailtemplatesEntity
                          ?.emailSubjectFollowupestimate ??
                      "";
                  messageController.text = followUpEstimateEmailtemplatesEntity
                          ?.emailMessageFollowupestimate ??
                      "";
                  setState(() {});
                }
              },
              builder: (context, state) {
                if (state is UpdateEmailTemplateLoadingState) {
                  return Container(
                    constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height - 200),
                    child:
                        Center(child: const LoadingPage(title: "Updating...")),
                  );
                }
                return Container(
                  padding: EdgeInsets.only(bottom: 20),
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
                                messageController.value =
                                    messageController.value.replaced(
                                        TextRange.collapsed(offset),
                                        " [${sendInvoiceList[index]}] ");
                              }
                              if (subjectFocusNode!.hasFocus) {
                                debugPrint("Subject is active");
                                final selection = subjectController.selection;
                                final offset = selection.baseOffset;
                                subjectController.value =
                                    subjectController.value.replaced(
                                        TextRange.collapsed(offset),
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
                            listOfChipNames: EnumEmailTemplate
                                .followUpEstimate.emailTemplateList,
                            style: AppFonts.regularStyle(),
                            activeTextColorList: [
                              AppPallete.white
                            ],
                            inactiveTextColorList: [
                              AppPallete.blueColor
                            ],
                            activeBgColorList: [
                              AppPallete.blueColor
                            ],
                            inactiveBgColorList: [
                              AppPallete.kF2F2F2
                            ],
                            activeBorderColorList: [
                              AppPallete.blueColor
                            ],
                            inactiveBorderColorList: [
                              AppPallete.blueColor
                            ],
                            borderRadiiList: [
                              10
                            ],
                            listOfChipIndicesCurrentlySelected: [
                              _currentIndex
                            ]),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ));
  }
}
