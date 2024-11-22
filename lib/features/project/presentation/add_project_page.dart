import 'package:auto_route/auto_route.dart';
import 'package:billbooks_app/core/app_constants.dart';
import 'package:billbooks_app/core/theme/app_fonts.dart';
import 'package:billbooks_app/core/theme/app_pallete.dart';
import 'package:billbooks_app/core/utils/show_toast.dart';
import 'package:billbooks_app/core/widgets/input_dropdown_view.dart';
import 'package:billbooks_app/core/widgets/new_inputview_widget.dart';
import 'package:billbooks_app/features/clients/domain/entities/client_list_entity.dart';
import 'package:billbooks_app/features/project/domain/entity/project_list_entity.dart';
import 'package:billbooks_app/features/project/domain/usecase/project_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';

import '../../../core/widgets/app_alert_widget.dart';
import '../../../core/widgets/app_single_selection_popup.dart';
import '../../../core/widgets/item_separator.dart';
import '../../../core/widgets/loading_page.dart';
import '../../../router/app_router.dart';
import 'bloc/project_bloc.dart';

@RoutePage()
class AddProjectPage extends StatefulWidget {
  final ClientEntity? clientEntity;
  final Function() deletedProject;
  final Function() updatedProject;
  final ProjectEntity? projectEntity;
  const AddProjectPage(
      {super.key,
      this.projectEntity,
      required this.deletedProject,
      required this.updatedProject,
      this.clientEntity});

  @override
  State<AddProjectPage> createState() => _AddProjectPageState();
}

class _AddProjectPageState extends State<AddProjectPage> {
  TextEditingController projectNameController = TextEditingController();
  TextEditingController descController = TextEditingController();
  String screenTitle = "Add Project";
  bool isFormValid = false;
  List<String> statusList = ["Active", "Inactive"];
  String? selectedStatus;
  ClientEntity? selectedClient;
  bool isClientDisabled = false;

  @override
  void initState() {
    populateData();
    validateForm();
    super.initState();
  }

  void populateData() {
    if (isEdit()) {
      screenTitle = "Edit Project";
      final ProjectEntity projectEntity = widget.projectEntity!;
      projectNameController.text = projectEntity.name ?? "";
      descController.text = projectEntity.description ?? "";
      selectedStatus = _isActive() ? "Active" : "Inactive";
      selectedClient = ClientEntity(
          clientId: projectEntity.clientId, name: projectEntity.clientName);
    }
    if (widget.clientEntity != null) {
      isClientDisabled = true;
      selectedClient = widget.clientEntity;
    }
  }

  void validateForm() {
    // ignore: no_leading_underscores_for_local_identifiers
    bool _isFormValid = false;
    final name = projectNameController.text;
    if (name.isNotEmpty) {
      _isFormValid = true;
    }
    if (isFormValid != _isFormValid) {
      isFormValid = _isFormValid;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPallete.kF2F2F2,
      appBar: AppBar(
        title: Text(screenTitle),
        actions: [
          TextButton(
              onPressed: isFormValid
                  ? () {
                      context.read<ProjectBloc>().add(AddProjectEvent(
                          addProjectParams: AddProjectParams(
                              name: projectNameController.text,
                              description: descController.text,
                              client: selectedClient?.clientId ?? "",
                              status: selectedStatus ?? "active",
                              id: widget.projectEntity?.id)));
                    }
                  : null,
              child: Text(
                "Save",
                style: AppFonts.regularStyle(
                    color: isFormValid
                        ? AppPallete.blueColor
                        : AppPallete.blueColor.withOpacity(0.3)),
              ))
        ],
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.close,
              color: AppPallete.blueColor,
            )),
      ),
      body: BlocConsumer<ProjectBloc, ProjectState>(
        listener: (context, state) {
          if (state is AddProjectSuccess) {
            showToastification(
                context,
                "Successfully ${isEdit() ? "updated" : "added"} project.",
                ToastificationType.success);
            widget.updatedProject();
            AutoRouter.of(context).maybePop();
          }
          if (state is AddProjectError) {
            showToastification(
                context, state.errorMessage, ToastificationType.error);
          }
          if (state is DeleteProjectErrorState) {
            showToastification(
                context, state.errorMessage, ToastificationType.error);
          }
          if (state is DeleteProjectSuccessState) {
            showToastification(context, "Successfully deleted project.",
                ToastificationType.error);
            widget.deletedProject();
            debugPrint("Refresh detail screen");
            AutoRouter.of(context)
                .popUntilRouteWithName(ProjectListPageRoute.name);
          }
        },
        builder: (context, state) {
          if (state is AddProjectLoading) {
            return LoadingPage(
                title: isEdit() ? "Updating project..." : "Adding project...");
          }

          if (state is DeleteProjectLoadingState) {
            return const LoadingPage(title: "Deleting project...");
          }
          return Column(
            children: [
              AppConstants.sizeBoxHeight10,
              NewInputViewWidget(
                title: "Project Name",
                hintText: "Project Name",
                isRequired: true,
                showDivider: true,
                controller: projectNameController,
                onChanged: (val) {
                  validateForm();
                },
              ),
              NewInputViewWidget(
                title: "Description",
                hintText: "Tap to enter",
                isRequired: false,
                showDivider: false,
                inputType: TextInputType.text,
                inputAction: TextInputAction.done,
                controller: descController,
                onChanged: (val) {},
              ),
              AppConstants.sizeBoxHeight10,
              InputDropdownView(
                  title: "Client",
                  isRequired: true,
                  showDivider: false,
                  isDisabled: isClientDisabled,
                  defaultText: "Tap to select",
                  value: selectedClient?.name ?? "Tap to select",
                  dropDownImageName: Icons.chevron_right,
                  onPress: () {
                    AutoRouter.of(context).push(ClientPopupRoute(
                        selectedClient: selectedClient,
                        onSelectClient: (client) {
                          debugPrint("Client Name: ${client?.name ?? ""}");
                          debugPrint(
                              "Client Client Id: ${client?.clientId ?? ""}");
                          debugPrint("Client Id : ${client?.id ?? ""}");
                          selectedClient = client;
                          rerenderUI();
                        }));
                  }),
              AppConstants.sizeBoxHeight10,
              if (isEdit())
                InputDropdownView(
                    title: "Status",
                    isRequired: false,
                    showDivider: false,
                    defaultText: "Tap to Select",
                    value: selectedStatus ?? "",
                    onPress: () {
                      _showStatusPopup();
                    }),
              if (isEdit()) AppConstants.sizeBoxHeight10,
              if (isEdit())
                Container(
                  width: MediaQuery.of(context).size.width,
                  color: AppPallete.white,
                  child: Column(
                    children: [
                      TextButton(
                          onPressed: () {
                            _showDeleteProjectAlert(context);
                          },
                          child: Text(
                            "Delete",
                            style: AppFonts.regularStyle(color: AppPallete.red),
                          ))
                    ],
                  ),
                )
            ],
          );
        },
      ),
    );
  }

  bool isEdit() {
    return widget.projectEntity != null;
  }

  void _showDeleteProjectAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AppAlertWidget(
            title: "Delete Project",
            message: "Are you sure you want to delete this project?",
            onTapDelete: () {
              _dismissPopup(context);
              context.read<ProjectBloc>().add(DeleteProjectEvent(
                  deleteProjectParams:
                      DeleteProjectParams(id: widget.projectEntity?.id ?? "")));
            },
            alertType: EnumAppAlertType.delete,
          );
        });
  }

  void _dismissPopup(context) {
    Navigator.of(context).pop();
  }

  bool _isActive() {
    if (widget.projectEntity?.status?.toLowerCase() == "active") {
      return true;
    }
    return false;
  }

  void _showStatusPopup() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AppSingleSelectionPopupWidget(
            defaultSelectedItem: selectedStatus,
            data: statusList,
            title: "Status",
            selectedOk: (val) {
              selectedStatus = val;
              setState(() {});
            },
            itemBuilder: (item, seletedItem) {
              selectedStatus = seletedItem;
              return Container(
                padding: AppConstants.horizotal16,
                child: Column(
                  children: [
                    Padding(
                      padding: AppConstants.verticalPadding10,
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              item,
                              style: AppFonts.regularStyle(
                                  color: selectedStatus == item
                                      ? AppPallete.blueColor
                                      : AppPallete.textColor),
                            ),
                          ),
                          AppConstants.sizeBoxWidth10,
                          if (selectedStatus == item)
                            const Icon(
                              Icons.check,
                              color: AppPallete.blueColor,
                            )
                        ],
                      ),
                    ),
                    const ItemSeparator()
                  ],
                ),
              );
            },
          );
        });
  }

  void rerenderUI() {
    setState(() {});
  }
}
