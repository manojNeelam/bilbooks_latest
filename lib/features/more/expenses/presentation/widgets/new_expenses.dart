import 'package:auto_route/auto_route.dart';
import 'package:billbooks_app/core/app_constants.dart';
import 'package:billbooks_app/core/utils/show_toast.dart';
import 'package:billbooks_app/core/widgets/date_picker_widget.dart';
import 'package:billbooks_app/core/widgets/loading_page.dart';
import 'package:billbooks_app/core/widgets/repeat_every_popup_widget.dart';
import 'package:billbooks_app/features/categories/domain/entities/category_main_res_entity.dart';
import 'package:billbooks_app/features/clients/domain/entities/client_list_entity.dart';
import 'package:billbooks_app/features/more/expenses/domain/usecase/delete_expense_usecase.dart';
import 'package:billbooks_app/features/project/domain/entity/project_list_entity.dart';
import 'package:billbooks_app/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:toastification/toastification.dart';

import '../../../../../core/theme/app_fonts.dart';
import '../../../../../core/theme/app_pallete.dart';
import '../../../../../core/widgets/app_alert_widget.dart';
import '../../../../../core/widgets/input_dropdown_view.dart';
import '../../../../../core/widgets/input_switch_widget.dart';
import '../../../../../core/widgets/item_separator.dart';
import '../../../../../core/widgets/new_inputview_widget.dart';
import '../../../../../core/widgets/notes_widget.dart';
import '../../../../../core/widgets/section_header_widget.dart';
import '../../../../invoice/domain/entities/repeat_every_model.dart';
import '../../domain/entities/expenses_list_entity.dart';
import '../../domain/usecase/new_expenses_usecase.dart';
import '../bloc/expenses_bloc.dart';

enum EnumExpenseScreenType { newExpense, duplicate, edit }

@RoutePage()
class NewExpenses extends StatefulWidget {
  final EnumExpenseScreenType expenseScreenType;
  final ExpenseEntity? expenseEntity;

  final Function()? refreshPage;

  const NewExpenses({
    super.key,
    required this.expenseScreenType,
    this.refreshPage,
    this.expenseEntity,
  });

  @override
  State<NewExpenses> createState() => _NewExpensesState();
}

class _NewExpensesState extends State<NewExpenses> {
  //TextEditingController dateController = TextEditingController();
  TextEditingController vendorController = TextEditingController();
  TextEditingController referenceController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  TextEditingController remainingController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  CategoryEntity? selectedCategoryEntity;
  DateTime? selectedDate;
  ClientEntity? selectedClient;
  RepeatEvery? selectedRepeatEvery;
  ProjectEntity? selectedProject;
  bool billables = false;
  bool recurrings = false;
  bool isInfinite = false;
  List<RepeatEvery> items = [];
  ExpenseEntity? updateExpenseEntity;
  bool isEdit = false;
  String dateAsString = "";

  String getSelectedDateAsString({String formatter = 'dd-MMM-yyyy'}) {
    final date = selectedDate ?? DateTime.now();
    dateAsString = DateFormat(formatter).format(date);
    return dateAsString;
  }

  @override
  void initState() {
    readRepeatEvery();
    populateData();
    super.initState();
  }

  NewExpensesParams createReq() {
    final expenseReq = NewExpensesParams(
      dateAsString,
      referenceController.text,
      selectedCategoryEntity?.id ?? "",
      vendorController.text,
      amountController.text,
      "",
      notesController.text,
      selectedClient?.clientId ?? "",
      billables == true ? "true" : "false",
      selectedProject?.id ?? "",
      "",
      recurrings == true ? "true" : "false",
      recurrings
          ? isInfinite
              ? ""
              : remainingController.text
          : "",
      recurrings ? selectedRepeatEvery?.value ?? "" : "",
      isEdit ? updateExpenseEntity?.id ?? "" : "",
    );
    debugPrint(expenseReq.toString());
    return expenseReq;
  }

  bool isRecurring(String? status) {
    return status != null && status.toLowerCase() == "recurring";
  }

  void populateData() {
    isEdit = widget.expenseScreenType == EnumExpenseScreenType.edit;
    if (widget.expenseEntity != null) {
      updateExpenseEntity = widget.expenseEntity;

      if (updateExpenseEntity?.dateYmd != null) {
        final dateYMD = updateExpenseEntity?.dateYmd ?? DateTime.now();
        selectedDate = dateYMD;
        dateAsString = dateYMD.getDateString();
      }
      amountController.text = updateExpenseEntity?.amount ?? "";
      recurrings = isRecurring(updateExpenseEntity?.status);
      //updateExpenseEntity.dateYmd.getDateString();
      //dateController.text = updateExpenseEntity?.date ?? "";
      vendorController.text = updateExpenseEntity?.vendor ?? "";
      referenceController.text = updateExpenseEntity?.refno ?? "";
      notesController.text = updateExpenseEntity?.notes ?? "";
      remainingController.text = updateExpenseEntity?.recurringCount ?? "";
      selectedProject = ProjectEntity(
          id: updateExpenseEntity?.projectId,
          name: updateExpenseEntity?.projectName);
      selectedClient = ClientEntity(
          clientId: updateExpenseEntity?.clientId,
          name: updateExpenseEntity?.clientName);
      selectedCategoryEntity = CategoryEntity(
          id: updateExpenseEntity?.categoryId,
          name: updateExpenseEntity?.categoryName);
      //selectedRepeatEvery = RepeatEvery(value: "", label: "");
      //recurrings =
      billables = updateExpenseEntity?.isBillable ?? false;
      if (recurrings) {
        final howMany = updateExpenseEntity?.howmany ?? "";
        isInfinite = howMany.isEmpty;
        remainingController.text = howMany;
        if (updateExpenseEntity?.frequency != null && items.isNotEmpty) {
          selectedRepeatEvery ??= items.firstWhere((returnedTerms) {
            return returnedTerms.value?.toLowerCase() ==
                updateExpenseEntity?.frequency;
          });
        }
      }
    } else {
      selectedDate = DateTime.now();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPallete.kF2F2F2,
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                //createReq();
                context
                    .read<ExpensesBloc>()
                    .add(AddExpensesEvent(params: createReq()));
              },
              child: Text(
                "Save",
                style: AppFonts.regularStyle(color: AppPallete.blueColor),
              ))
        ],
        title: Text(
          widget.expenseScreenType == EnumExpenseScreenType.edit
              ? "Edit Expense"
              : "New Expense",
        ),
        leading: IconButton(
            onPressed: () {
              AutoRouter.of(context).maybePop();
            },
            icon: const Icon(
              Icons.close,
              color: AppPallete.blueColor,
            )),
        centerTitle: true,
      ),
      body: BlocConsumer<ExpensesBloc, ExpensesState>(
        listener: (context, state) {
          if (state is AddExpensesErrorState) {
            showToastification(
                context, state.errorMessage, ToastificationType.error);
          }
          if (state is DeleteExpensesErrorState) {
            showToastification(
                context, state.errorMessage, ToastificationType.error);
          }
          if (state is AddExpensesSuccessState) {
            showToastification(
                context,
                "Successfully ${isEdit ? "updated" : "added"} expenses",
                ToastificationType.success);
            if (widget.refreshPage != null) {
              widget.refreshPage!();
            }
            AutoRouter.of(context).maybePop();
          }

          if (state is DeleteExpensesSuccessState) {
            showToastification(context, "Successfully deleted expenses",
                ToastificationType.success);
            if (widget.refreshPage != null) {
              widget.refreshPage!();
            }
            AutoRouter.of(context).maybePop();
          }
        },
        builder: (context, state) {
          if (state is AddExpensesLoadingState) {
            return LoadingPage(
                title: "${isEdit ? "Updating" : "Adding"} expenses...");
          }

          if (state is DeleteExpensesLoadingState) {
            return const LoadingPage(title: "Deleting expenses...");
          }

          return SafeArea(
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Column(
                children: [
                  AppConstants.sizeBoxHeight10,
                  InputDropdownView(
                      title: "Date",
                      defaultText: "date",
                      isRequired: true,
                      showDropdownIcon: false,
                      value: getSelectedDateAsString(formatter: "dd MMM yyyy"),
                      onPress: () async {
                        final date = await buildMaterialDatePicker(
                            context, DateTime.now());
                        selectedDate = date;
                        rerenderUI();
                      }),
                  InputDropdownView(
                    dropDownImageName: Icons.chevron_right,
                    title: 'Category',
                    value: selectedCategoryEntity?.name ?? "",
                    defaultText:
                        selectedCategoryEntity?.name ?? "Tap to Select",
                    onPress: () {
                      AutoRouter.of(context).push(CategoryListPageRoute(
                          categoryEntity: selectedCategoryEntity,
                          onSelectCategory: (category) {
                            selectedCategoryEntity = category;
                            rerenderUI();
                          }));
                    },
                  ),
                  NewInputViewWidget(
                      isRequired: true,
                      title: "Amount",
                      hintText: "0.00",
                      inputType:
                          const TextInputType.numberWithOptions(decimal: true),
                      inputAction: TextInputAction.next,
                      controller: amountController),
                  NewInputViewWidget(
                    isRequired: false,
                    title: 'Vendor Name',
                    hintText: 'Vendor Name',
                    controller: vendorController,
                  ),
                  NewInputViewWidget(
                    isRequired: false,
                    title: 'Reference #',
                    hintText: 'Reference #',
                    controller: referenceController,
                  ),
                  NotesWidget(
                    controller: notesController,
                    title: 'Notes',
                    hintText: 'Tap to Enter',
                  ),
                  AppConstants.sizeBoxHeight10,
                  InputDropdownView(
                    title: 'Client',
                    dropDownImageName: Icons.chevron_right,
                    isRequired: false,
                    defaultText: 'Tap to select',
                    showDivider: selectedClient != null,
                    value: selectedClient?.name ?? "",
                    onPress: () {
                      AutoRouter.of(context).push(ClientPopupRoute(
                          selectedClient: selectedClient,
                          onSelectClient: (client) {
                            selectedClient = client;
                            rerenderUI();
                          }));
                    },
                  ),
                  if (selectedClient != null)
                    Column(
                      children: [
                        InPutSwitchWidget(
                          title: 'Billable',
                          context: context,
                          isRecurringOn: billables,
                          showDivider: true,
                          onChanged: (p1) {
                            billables = p1;
                            rerenderUI();
                          },
                        ),
                        InputDropdownView(
                          title: 'Project',
                          isRequired: false,
                          dropDownImageName: Icons.chevron_right,
                          defaultText: 'Tap to select',
                          showDivider: false,
                          value: selectedProject?.name ?? "",
                          onPress: () {
                            AutoRouter.of(context).push(ProjectPopupRoute(
                                selectedClient: selectedClient,
                                clientId: selectedClient?.clientId,
                                selectedProject: selectedProject,
                                onSelectProject: (project) {
                                  selectedProject = project;
                                  rerenderUI();
                                }));
                          },
                        ),
                      ],
                    ),
                  AppConstants.sizeBoxHeight10,
                  InPutSwitchWidget(
                    title: 'Recurring',
                    context: context,
                    isRecurringOn: recurrings,
                    showDivider: false,
                    onChanged: (p1) {
                      recurrings = p1;
                      rerenderUI();
                    },
                  ),
                  if (recurrings)
                    Column(children: [
                      const ItemSeparator(),
                      InputDropdownView(
                          title: "Repeat Every",
                          defaultText:
                              selectedRepeatEvery?.label ?? "Tap to Select",
                          showDivider: false,
                          isRequired: false,
                          value: selectedRepeatEvery?.label ?? "",
                          onPress: () {
                            print("On press dropdown");
                            _showRepeatEveryPopup();
                          }),
                      const SectionHeaderWidget(title: "How Many?"),
                      InPutSwitchWidget(
                          title: "Infinite",
                          showDivider: true,
                          context: context,
                          isRecurringOn: isInfinite,
                          onChanged: (val) {
                            isInfinite = val;
                            debugPrint("Infinite: $val");
                            rerenderUI();
                          }),
                      if (!isInfinite)
                        NewInputViewWidget(
                          title: 'Remaining',
                          hintText: "Remaining",
                          isRequired: false,
                          showDivider: false,
                          controller: remainingController,
                          inputType: TextInputType.number,
                          inputAction: TextInputAction.done,
                        ),
                      if (isEdit) AppConstants.sizeBoxHeight10,
                    ]),
                  if (isEdit) AppConstants.sizeBoxHeight10,
                  if (isEdit)
                    Container(
                      width: MediaQuery.of(context).size.width,
                      color: AppPallete.white,
                      child: Column(
                        children: [
                          TextButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AppAlertWidget(
                                        title: "Delete Expense",
                                        message:
                                            "Are you sure you want to delete this expense?",
                                        onTapDelete: () {
                                          debugPrint("on tap delete item");
                                          AutoRouter.of(context).maybePop();

                                          context.read<ExpensesBloc>().add(
                                              DeleteExpenseEvent(
                                                  params:
                                                      DeleteExpenseReqParams(
                                                          id: widget
                                                                  .expenseEntity
                                                                  ?.id ??
                                                              "")));
                                        },
                                      );
                                    });
                              },
                              child: Text(
                                "Delete",
                                style: AppFonts.regularStyle(
                                    color: AppPallete.red),
                              ))
                        ],
                      ),
                    )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void rerenderUI() {
    setState(() {});
  }

  Future<void> readRepeatEvery() async {
    final String response =
        await rootBundle.loadString('assets/files/repeat_every.json');
    items = repeatEveryResModelFromJson(response).items ?? [];
    if (widget.expenseEntity?.frequency != null) {
      selectedRepeatEvery ??= items.firstWhere((returnedTerms) {
        return returnedTerms.value?.toLowerCase() ==
            updateExpenseEntity?.frequency;
      });
    } else {
      selectedRepeatEvery ??= items.firstWhere((returnedTerms) {
        return returnedTerms.label?.toLowerCase() == "week" ||
            returnedTerms.value == "0";
      });
    }
    rerenderUI();
  }

  void _showRepeatEveryPopup() {
    showDialog(
        context: context,
        builder: (context) {
          return RepeatEveryPopupWidget(
              defaultRepeatEvery: selectedRepeatEvery,
              repeatEvery: items,
              callBack: (repeatEvery) {
                selectedRepeatEvery = repeatEvery;
                rerenderUI();
              });
        });
  }
}
