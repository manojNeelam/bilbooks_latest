import 'package:auto_route/auto_route.dart';
import 'package:billbooks_app/core/api/api_endpoint_urls.dart';
import 'package:billbooks_app/core/app_constants.dart';
import 'package:billbooks_app/core/theme/app_fonts.dart';
import 'package:billbooks_app/core/theme/app_pallete.dart';
import 'package:billbooks_app/core/utils/show_toast.dart';
import 'package:billbooks_app/core/widgets/contact_from_popup_widget.dart';
import 'package:billbooks_app/core/widgets/input_dropdown_view.dart';
import 'package:billbooks_app/core/widgets/input_switch_widget.dart';
import 'package:billbooks_app/core/widgets/loading_page.dart';
import 'package:billbooks_app/core/widgets/section_header_widget.dart';
import 'package:billbooks_app/features/invoice/domain/usecase/get_document_usecase.dart';
import 'package:billbooks_app/features/invoice/presentation/bloc/invoice_bloc.dart';
import 'package:billbooks_app/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';

import '../domain/entities/get_document_entity.dart';
import '../domain/usecase/send_document_usecase.dart';

enum EnumSendPageType { send, forward, reminder, thankyou }

extension EnumSendPageTypeExtension on EnumSendPageType {
  String get path {
    switch (this) {
      case EnumSendPageType.send:
      case EnumSendPageType.forward:
        return ApiEndPoints.getDocuments;
      case EnumSendPageType.reminder:
        return ApiEndPoints.sendReminder;
      case EnumSendPageType.thankyou:
        return ApiEndPoints.sendThankYou;
    }
  }

  String get title {
    switch (this) {
      case EnumSendPageType.send:
        return "Email";
      case EnumSendPageType.forward:
        return "Forward";
      case EnumSendPageType.reminder:
        return "Email Reminder";
      case EnumSendPageType.thankyou:
        return "Email Thank You";
    }
  }
}

@RoutePage()
class SendInvoiceEstimatePage extends StatefulWidget {
  final GetDocumentUsecaseReqParams params;
  const SendInvoiceEstimatePage({super.key, required this.params});

  @override
  State<SendInvoiceEstimatePage> createState() =>
      _SendInvoiceEstimatePageState();
}

class _SendInvoiceEstimatePageState extends State<SendInvoiceEstimatePage> {
  TextEditingController subjectController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  TextEditingController forwardSendToController = TextEditingController();
  GetDocumentData? documentData;
  List<ContactEntity> selectedBccMails = [];
  List<ContactEntity> selectedSendTo = [];
  ContactEntity? selectedFrom;
  bool isAttachPDF = false;

  @override
  void initState() {
    context.read<InvoiceBloc>().add(GetDocumentEvent(params: widget.params));
    super.initState();
  }

  bool get isForwardPage => widget.params.pageType == EnumSendPageType.forward;

  bool get isSendPage => widget.params.pageType == EnumSendPageType.send;

  @override
  void dispose() {
    subjectController.dispose();
    messageController.dispose();
    forwardSendToController.dispose();
    super.dispose();
  }

  void _populateData() {
    subjectController.text = documentData?.subject ?? "";
    messageController.text = documentData?.message ?? "";
    isAttachPDF = documentData?.attachPdf ?? false;

    final fromIndex = documentData?.from ?? "";
    if (fromIndex.isNotEmpty) {
      final fromObjIndex = documentData?.fromContacts?.indexWhere((element) {
        return element.id == fromIndex;
      });
      if (fromObjIndex != null && fromObjIndex >= 0) {
        selectedFrom = documentData?.fromContacts?[fromObjIndex];
      }
    }

    selectedSendTo = _resolveSelectedContacts(
      selectedIds: documentData?.sendtoMails ?? [],
      contacts: documentData?.sendtoContacts ?? [],
    );
    selectedBccMails = _resolveSelectedContacts(
      selectedIds: documentData?.bccMails ?? [],
      contacts: documentData?.bccContacts ?? [],
    );

    if (isForwardPage) {
      forwardSendToController.clear();
    }

    setState(() {});
  }

  List<ContactEntity> _resolveSelectedContacts({
    required List<String> selectedIds,
    required List<ContactEntity> contacts,
  }) {
    final List<ContactEntity> selectedContacts = [];

    for (final selectedId in selectedIds) {
      final contactIndex = contacts.indexWhere((contact) {
        return contact.id == selectedId;
      });
      if (contactIndex >= 0) {
        selectedContacts.add(contacts[contactIndex]);
      }
    }

    return selectedContacts;
  }

  String _getBccMailsValue() {
    final totalLength = documentData?.bccContacts?.length ?? 0;
    final selectedLength = selectedBccMails.length;
    return "$selectedLength of $totalLength";
  }

  String _getSendToMailsValue() {
    final totalLength = documentData?.sendtoContacts?.length ?? 0;
    final selectedLength = selectedSendTo.length;
    return "$selectedLength of $totalLength";
  }

  List<ContactEntity> _buildForwardSendToContacts() {
    return forwardSendToController.text
        .split(',')
        .map((email) => email.trim())
        .where((email) => email.isNotEmpty)
        .map((email) => ContactEntity(id: email, email: email, name: email))
        .toList();
  }

  void _sendDocument() {
    final forwardSendTo = isForwardPage ? _buildForwardSendToContacts() : null;

    if (isForwardPage && (forwardSendTo == null || forwardSendTo.isEmpty)) {
      showToastification(
        context,
        'Please enter at least one email address.',
        ToastificationType.error,
      );
      return;
    }

    context.read<InvoiceBloc>().add(SendDocumentEvent(
            params: SendDocumentUsecaseReqParams(
          id: widget.params.id,
          from: selectedFrom?.id ?? "",
          bcc: isForwardPage ? [] : selectedBccMails,
          sendTo: forwardSendTo ?? selectedSendTo,
          message: messageController.text,
          subject: subjectController.text,
          type: widget.params.type,
          isAttachPdf: isAttachPDF,
        )));
  }

  String _getDynamicDocumentTitle() {
    final documentTypeTitle = widget.params.type.title;
    final documentNo = (documentData?.no ?? '').trim();

    if ((!isSendPage && !isForwardPage) || documentNo.isEmpty) {
      return 'Send $documentTypeTitle';
    }

    final actionTitle = isForwardPage ? 'Forward' : 'Send';

    return '$actionTitle $documentTypeTitle ($documentTypeTitle #$documentNo)';
  }

  String _getScreenTitle() {
    switch (widget.params.pageType) {
      case EnumSendPageType.send:
      case EnumSendPageType.forward:
        return _getDynamicDocumentTitle();
      case EnumSendPageType.reminder || EnumSendPageType.thankyou:
        return widget.params.pageType.title;
    }
  }

  String _getPrimaryActionTitle() {
    return isForwardPage ? 'Forward' : 'Send';
  }

  Widget _buildForwardBody() {
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Column(
        children: [
          const SectionHeaderWidget(title: 'Send To'),
          Container(
            color: AppPallete.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
            child: TextField(
              controller: forwardSendToController,
              style: AppFonts.regularStyle(),
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              maxLines: 2,
              minLines: 1,
              decoration: const InputDecoration(
                hintText: 'e.g. email@example.com, email2@example.com',
                border: InputBorder.none,
              ),
            ),
          ),
          const SectionHeaderWidget(title: 'Subject'),
          Container(
            color: AppPallete.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
            child: TextField(
              controller: subjectController,
              style: AppFonts.regularStyle(),
              decoration: const InputDecoration(
                  hintText: 'Subject', border: InputBorder.none),
              textInputAction: TextInputAction.next,
              maxLines: 1,
            ),
          ),
          const SectionHeaderWidget(title: 'Message'),
          Container(
            color: AppPallete.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
            child: TextField(
              controller: messageController,
              style: AppFonts.regularStyle(),
              decoration: const InputDecoration(
                  hintText: 'Message', border: InputBorder.none),
              textInputAction: TextInputAction.newline,
              maxLines: 10,
              minLines: 10,
            ),
          ),
          AppConstants.sizeBoxHeight10,
          InPutSwitchWidget(
              title: 'Attach PDF copy',
              context: context,
              isRecurringOn: isAttachPDF,
              onChanged: (val) {
                isAttachPDF = val;
                setState(() {});
              },
              showDivider: false),
        ],
      ),
    );
  }

  Widget _buildSendBody() {
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Column(
        children: [
          AppConstants.sizeBoxHeight10,
          InputDropdownView(
              title: 'From',
              dropDownImageName: Icons.arrow_drop_down,
              isRequired: true,
              defaultText: 'Tap to Select',
              value: selectedFrom?.name ?? '',
              onPress: () {
                _showContactPopup();
              }),
          InputDropdownView(
              title: 'Send To',
              isRequired: true,
              defaultText: '',
              value: _getSendToMailsValue(),
              dropDownImageName: Icons.chevron_right,
              onPress: () {
                AutoRouter.of(context).push(SendtoBccPageRoute(
                    onpressDone: (list) {
                      selectedSendTo = list;
                      setState(() {});
                    },
                    list: documentData?.sendtoContacts ?? [],
                    selectedList: selectedSendTo));
              }),
          InputDropdownView(
              title: 'Bcc',
              isRequired: false,
              defaultText: '',
              showDivider: false,
              value: _getBccMailsValue(),
              dropDownImageName: Icons.chevron_right,
              onPress: () {
                AutoRouter.of(context).push(SendtoBccPageRoute(
                    onpressDone: (list) {
                      selectedBccMails = list;
                      setState(() {});
                    },
                    list: documentData?.bccContacts ?? [],
                    selectedList: selectedBccMails));
              }),
          const SectionHeaderWidget(title: 'Subject'),
          Container(
            color: AppPallete.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
            child: TextField(
              controller: subjectController,
              style: AppFonts.regularStyle(),
              decoration: const InputDecoration(
                  hintText: 'Subject', border: InputBorder.none),
              textInputAction: TextInputAction.next,
              maxLines: 1,
            ),
          ),
          const SectionHeaderWidget(title: 'Message'),
          Container(
            color: AppPallete.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
            child: TextField(
              controller: messageController,
              style: AppFonts.regularStyle(),
              decoration: const InputDecoration(
                  hintText: 'Message', border: InputBorder.none),
              textInputAction: TextInputAction.newline,
              maxLines: 10,
              minLines: 10,
            ),
          ),
          AppConstants.sizeBoxHeight10,
          InPutSwitchWidget(
              title: 'Attach PDF copy',
              context: context,
              isRecurringOn: isAttachPDF,
              onChanged: (val) {
                isAttachPDF = val;
                setState(() {});
              },
              showDivider: false),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPallete.kF2F2F2,
      appBar: AppBar(
        title: Text(_getScreenTitle()),
        actions: [
          TextButton(
              onPressed: () {
                _sendDocument();
              },
              child: Text(_getPrimaryActionTitle(),
                  style: AppFonts.regularStyle(
                    color: AppPallete.blueColor,
                  ))),
        ],
      ),
      body: BlocConsumer<InvoiceBloc, InvoiceState>(
        listener: (context, state) {
          if (state is SendDocumentSuccessState) {
            showToastification(
                context,
                state.sendDocumentMainResEntity.data?.message ??
                    "Successfully sent.",
                ToastificationType.success);
            AutoRouter.of(context).maybePop();
          }
          if (state is SendDocumentErrorState) {
            showToastification(
                context, state.errorMessage, ToastificationType.error);
          }

          if (state is GetDocumentSuccessState) {
            documentData = state.documentMainResEntity.data?.data;
            _populateData();
          }
          if (state is GetDocumentErrorState) {
            showToastification(
                context, state.errorMessage, ToastificationType.error);
          }
        },
        builder: (context, state) {
          if (state is GetDocumentLoadingState) {
            return const LoadingPage(title: "Loading...");
          }

          if (state is SendDocumentLoadingState) {
            return const LoadingPage(title: "Loading...");
          }
          return isForwardPage ? _buildForwardBody() : _buildSendBody();
        },
      ),
    );
  }

  void _showContactPopup() {
    showDialog(
        context: context,
        builder: (context) {
          return ContactFromPopupWidget(
              contacts: documentData?.fromContacts ?? [],
              defaultContact: selectedFrom,
              callBack: (contact) {
                selectedFrom = contact;
                setState(() {});
              });
        });
  }
}
