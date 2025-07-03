import 'package:auto_route/auto_route.dart';
import 'package:billbooks_app/core/utils/utils.dart';
import 'package:billbooks_app/features/creditnotes/presentation/model/credit_note_expiry_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/app_constants.dart';
import '../../../core/theme/app_fonts.dart';
import '../../../core/theme/app_pallete.dart';
import '../../../core/widgets/credit_note_expiry_popup_widget.dart';
import '../../../core/widgets/date_picker_widget.dart';
import '../../../core/widgets/input_dropdown_view.dart';
import '../../../core/widgets/input_switch_widget.dart';
import '../../../core/widgets/new_inputview_widget.dart';
import '../../../core/widgets/new_multiline_input_widget.dart';
import '../../../router/app_router.dart';
import '../../clients/domain/entities/client_list_entity.dart';
import '../../project/domain/entity/project_list_entity.dart';

@RoutePage()
class AddCreateNotePage extends StatefulWidget {
  const AddCreateNotePage({super.key});

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
                "Save",
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
        title: Text("Create a Credit Note"),
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            Utils.hideKeyboard();
          },
          child: Container(
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
          ),
        ),
      ),
    );
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
