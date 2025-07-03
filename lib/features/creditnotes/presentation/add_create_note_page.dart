import 'package:auto_route/auto_route.dart';
import 'package:billbooks_app/core/utils/show_toast.dart';
import 'package:billbooks_app/core/utils/utils.dart';
import 'package:billbooks_app/features/creditnotes/domain/model/credit_note_add_req_params.dart';
import 'package:billbooks_app/features/creditnotes/domain/model/credit_note_detail_req_params.dart';
import 'package:billbooks_app/features/creditnotes/presentation/model/credit_note_expiry_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:toastification/toastification.dart';

import '../../../core/app_constants.dart';
import '../../../core/theme/app_fonts.dart';
import '../../../core/theme/app_pallete.dart';
import '../../../core/widgets/credit_note_expiry_popup_widget.dart';
import '../../../core/widgets/date_picker_widget.dart';
import '../../../core/widgets/input_dropdown_view.dart';
import '../../../core/widgets/input_switch_widget.dart';
import '../../../core/widgets/loading_page.dart';
import '../../../core/widgets/new_inputview_widget.dart';
import '../../../core/widgets/new_multiline_input_widget.dart';
import '../../../router/app_router.dart';
import '../../clients/domain/entities/client_list_entity.dart';
import '../../project/domain/entity/project_list_entity.dart';
import 'bloc/creditnote_bloc.dart';

enum CreditNoteScreenType {
  create,
  edit,
}

@RoutePage()
class AddCreateNotePage extends StatefulWidget {
  final CreditNoteScreenType screenType;
  final String creditNoteId;
  const AddCreateNotePage({
    super.key,
    required this.screenType,
    this.creditNoteId = "0",
  });

  @override
  State<AddCreateNotePage> createState() => _AddCreateNotePageState();
}

class _AddCreateNotePageState extends State<AddCreateNotePage> {
  TextEditingController descriptionController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController creditNoteController = TextEditingController();
  ClientEntity? selectedClient;
  ProjectEntity? selectedProject;
  DateTime? selectedDate;
  String dateAsString = "";
  bool isSetExpiry = false;
  List<CreditNoteExpiryModel> creditExpiryList = [];
  CreditNoteExpiryModel? selectedExpiry;

  @override
  void initState() {
    _loadNoteNumber();

    // if (widget.screenType == CreditNoteScreenType.create) {
    //   // Load existing data if editing
    //   // For example, you can fetch the credit note details and set the controllers
    //   // creditNoteController.text = existingCreditNote.creditNoteNo;
    //   // descriptionController.text = existingCreditNote.description;
    //   // amountController.text = existingCreditNote.amount.toString();
    //   // selectedClient = existingCreditNote.client;
    //   // selectedProject = existingCreditNote.project;
    //   // selectedDate = existingCreditNote.expiryDate;
    // }

    _loadExpiryModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPallete.kF2F2F2,
      appBar: AppBar(
        //title: Text("ghghghfhghgh"),
        actions: [
          TextButton(
              onPressed: () {},
              child: Text(
                widget.screenType == CreditNoteScreenType.create
                    ? "Save"
                    : "Update",
                style: AppFonts.regularStyle(color: AppPallete.blueColor),
              ))
        ],
        leading: IconButton(
            onPressed: () {
              AutoRouter.of(context).maybePop();
            },
            icon: const Icon(
              Icons.close,
              color: AppPallete.blueColor,
            )),
        title: Text(
            "${widget.screenType == CreditNoteScreenType.create ? "Create" : "Edit"} a Credit Note"),
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            Utils.hideKeyboard();
          },
          child: BlocConsumer<CreditnoteBloc, CreditnoteState>(
            listener: (context, state) {
              if (state is CreditnoteAddLoaded) {
                showToastification(
                    context,
                    state.creditNoteDetails.data?.message ??
                        "Successfully Added.",
                    ToastificationType.success);
              }

              if (state is CreditnoteAddError) {
                showToastification(
                    context, state.message, ToastificationType.error);
              }

              if (state is CreditnoteDetailLoaded) {
                if (state.creditNoteDetails.data?.creditNotes != null) {
                  final detail = state.creditNoteDetails.data?.creditNotes;
                  creditNoteController.text = detail?.noteNo ?? "";
                  descriptionController.text = detail?.description ?? "";
                  amountController.text = detail?.amount ?? "";
                  selectedClient = ClientEntity(
                    clientId: detail?.clientId,
                    name: detail?.clientName,
                  );
                  selectedProject = ProjectEntity(
                    id: detail?.projectId,
                    name: detail?.projectName,
                  );
                  isSetExpiry = detail?.expiryDate != null;
                  selectedExpiry = creditExpiryList.firstWhere(
                    (element) => element.value == detail?.days,
                    orElse: () => CreditNoteExpiryModel(
                        label: "Custom Date", value: "-1"),
                  );
                  if (selectedExpiry?.value == "-1") {
                    selectedDate = detail?.expiryDate ?? DateTime.now();
                  } else {
                    // If expiry is set to a specific number of days, calculate the date
                    selectedDate = DateTime.now().add(
                      Duration(days: int.parse(selectedExpiry?.value ?? "0")),
                    );
                  }
                  dateAsString = getSelectedDateAsString();
                } else {
                  // If no credit note details are found, initialize with default values
                  creditNoteController.text = "";
                  descriptionController.text = "";
                  amountController.text = "";
                  selectedClient = null;
                  selectedProject = null;
                  isSetExpiry = false;
                  selectedExpiry = null;
                  selectedDate = DateTime.now();
                  dateAsString = getSelectedDateAsString();
                }

                rerenderUI();
              } else if (state is CreditnoteDetailError) {
                showToastification(
                    context, state.message, ToastificationType.error);
                // Handle error state, maybe show a snackbar or dialog
              }
            },
            builder: (context, state) {
              if (state is CreditnoteAddLoading) {
                return LoadingPage(title: "Adding credit notes...");
              }
              return Container(
                height: MediaQuery.of(context).size.height,
                color: AppPallete.clear,
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height,
                    ),
                    child: IntrinsicHeight(
                      child: Column(
                        children: [
                          AppConstants.sizeBoxHeight10,
                          NewInputViewWidget(
                            isRequired: true,
                            title: 'Credit note #',
                            hintText: '#CN001',
                            controller: creditNoteController,
                            textCapitalization: TextCapitalization.words,
                          ),
                          InputDropdownView(
                            title: 'Client',
                            dropDownImageName: Icons.chevron_right,
                            isRequired: false,
                            defaultText: 'Tap to select',
                            value: selectedClient?.name ?? "",
                            onPress: () {
                              _openClient();
                            },
                          ),
                          if (selectedClient != null)
                            InputDropdownView(
                              isRequired: false,
                              title: 'Projects',
                              defaultText: 'Select Project',
                              value: selectedProject?.name ?? "",
                              onPress: () {
                                _openProject();
                              },
                            ),
                          NewMultilineInputWidget(
                            controller: descriptionController,
                            title: 'Description',
                            hintText: 'Tap to Enter',
                            textCapitalization: TextCapitalization.words,
                            isRequired: false,
                          ),
                          NewInputViewWidget(
                              isRequired: true,
                              title: "Amount",
                              hintText: "0.00",
                              inputType: const TextInputType.numberWithOptions(
                                  decimal: true),
                              inputAction: TextInputAction.next,
                              controller: amountController),
                          AppConstants.sizeBoxHeight10,
                          InPutSwitchWidget(
                              title: "Set Expiry",
                              context: context,
                              isRecurringOn: isSetExpiry,
                              onChanged: (val) {
                                if (val != isSetExpiry) {
                                  isSetExpiry = val;
                                  setState(() {});
                                }
                              },
                              showDivider: isSetExpiry),
                          if (isSetExpiry)
                            InputDropdownView(
                                title: "Select Expiry Range",
                                defaultText: "Tap to Select",
                                value: selectedExpiry?.label ?? "",
                                onPress: () {
                                  _showExpiryRangePopup();
                                }),
                          if (isSetExpiry &&
                              selectedExpiry != null &&
                              selectedExpiry?.value == "-1")
                            InputDropdownView(
                                title: "Expiry Date",
                                defaultText: "select date",
                                isRequired: true,
                                showDropdownIcon: false,
                                value: getSelectedDateAsString(
                                    formatter: "dd MMM yyyy"),
                                onPress: () async {
                                  final date = await buildMaterialDatePicker(
                                      context, selectedDate);
                                  if (date != null) selectedDate = date;
                                  rerenderUI();
                                }),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  _loadNoteNumber() {
    context.read<CreditnoteBloc>().add(CreditnoteGetDetailEvent(
        CreditNoteDetailReqParams(creditNoteId: widget.creditNoteId)));
  }

  updateCreditNote() {
    CreditNoteAddReqParams params = CreditNoteAddReqParams(
      id: widget.creditNoteId,
      noteNumber: creditNoteController.text,
      projectId: selectedProject?.id,
      clientId: selectedClient?.clientId,
      desc: descriptionController.text,
      amount: amountController.text,
      expiryDate: dateAsString,
    );

    context.read<CreditnoteBloc>().add(CreditnoteAddEvent(params));
  }

  _loadExpiryModel() {
    List<CreditNoteExpiryModel> list = [
      CreditNoteExpiryModel(label: "7 Days", value: "7"),
      CreditNoteExpiryModel(label: "15 Days", value: "15"),
      CreditNoteExpiryModel(label: "30 Days", value: "30"),
      CreditNoteExpiryModel(label: "60 Days", value: "60"),
      CreditNoteExpiryModel(label: "90 Days", value: "90"),
      CreditNoteExpiryModel(label: "Custom Date", value: "-1"),
    ];
    creditExpiryList = list;
  }

  String getSelectedDateAsString({String formatter = 'dd-MMM-yyyy'}) {
    if (selectedDate != null) {
      final date = selectedDate ?? DateTime.now();
      dateAsString = DateFormat(formatter).format(date);
      return dateAsString;
    }
    return "";
  }

  void _showExpiryRangePopup() {
    showDialog(
        context: context,
        builder: (context) {
          return CreditNoteExpiryPopupWidget(
              expiryRanges: creditExpiryList,
              defaultExpiry: selectedExpiry,
              callBack: (terms) {
                selectedExpiry = terms;
                setState(() {});
              });
        });
  }

  void rerenderUI() {
    setState(() {});
  }

  void _openClient() {
    AutoRouter.of(context).push(ClientPopupRoute(
        selectedClient: selectedClient,
        onSelectClient: (client) {
          if (selectedClient?.clientId != client?.clientId) {
            selectedProject = null;
            selectedClient = client;
            rerenderUI();
          }
        }));
  }

  void _openProject() {
    AutoRouter.of(context).push(ProjectPopupRoute(
        clientId: selectedClient?.clientId,
        selectedClient: selectedClient,
        selectedProject: selectedProject,
        onSelectProject: (project) {
          selectedProject = project;
          setState(() {});
        }));
  }
}
