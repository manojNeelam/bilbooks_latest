import 'dart:async';

import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';
import 'package:auto_route/auto_route.dart';
import 'package:billbooks_app/core/app_constants.dart';
import 'package:billbooks_app/core/widgets/app_alert_widget.dart';
import 'package:billbooks_app/core/widgets/input_dropdown_view.dart';
import 'package:billbooks_app/core/widgets/loading_page.dart';
import 'package:billbooks_app/core/widgets/section_header_widget.dart';
import 'package:billbooks_app/features/project/domain/usecase/project_usecase.dart';
import 'package:billbooks_app/features/project/presentation/bloc/project_bloc.dart';
import 'package:billbooks_app/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';

import '../../../core/constants/assets.dart';
import '../../../core/theme/app_fonts.dart';
import '../../../core/theme/app_pallete.dart';
import '../../../core/utils/show_toast.dart';
import '../domain/entity/project_list_entity.dart';

enum ProjectActionButtonType { edit, createNew, more }

extension ProjectActionButtonTypeExt on ProjectActionButtonType {
  String get name {
    switch (this) {
      case ProjectActionButtonType.edit:
        return "Edit";
      case ProjectActionButtonType.createNew:
        return "Create New";
      case ProjectActionButtonType.more:
        return "More";
    }
  }

  IconData get iconData {
    switch (this) {
      case ProjectActionButtonType.edit:
        return Icons.edit;
      case ProjectActionButtonType.createNew:
        return Icons.add;
      case ProjectActionButtonType.more:
        return Icons.more_horiz;
    }
  }

  String get imageName {
    switch (this) {
      case ProjectActionButtonType.edit:
        return Assets.assetsImagesIcMessage;
      case ProjectActionButtonType.createNew:
        return Assets.assetsImagesIcCall;
      case ProjectActionButtonType.more:
        return Assets.assetsImagesIcMore;
    }
  }
}

@RoutePage()
class ProjectDetailPage extends StatefulWidget {
  final ProjectEntity projectEntity;
  final Function() refreshPage;
  const ProjectDetailPage(
      {super.key, required this.projectEntity, required this.refreshPage});

  @override
  State<ProjectDetailPage> createState() => _ProjectDetailPageState();
}

class _ProjectDetailPageState extends State<ProjectDetailPage> {
  BuildContext? mainContext;
  ProjectEntity? projectEntity;
  bool removeObservingBloc = false;
  bool refreshListPage = false;

  @override
  void initState() {
    mainContext = context;
    _getProjectDetails();
    super.initState();
  }

  void _getProjectDetails() {
    context.read<ProjectBloc>().add(GetProjectDetailEvent(
        projectDetailReqParams:
            ProjectDetailReqParams(id: widget.projectEntity.id ?? "")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppPallete.lightBlueColor,
          title: const Text("Project"),
          leading: IconButton(
            onPressed: () {
              onTapBack();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: AppPallete.blueColor,
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  _openUpdateProjectScreen();
                },
                child: Text(
                  "Edit",
                  style: AppFonts.regularStyle(color: AppPallete.blueColor),
                ))
          ],
        ),
        body: BlocConsumer<ProjectBloc, ProjectState>(
          listener: (context, state) {
            if (removeObservingBloc == false) {
              if (state is ProjectDetailSuccessState) {
                projectEntity =
                    state.projectDetailMainResEntity.data?.project ??
                        ProjectEntity();
              }

              if (state is DeleteProjectErrorState) {
                showToastification(
                    context, state.errorMessage, ToastificationType.error);
              }
              if (state is UpdateProjectStatusErrorState) {
                showToastification(
                    context, state.errorMessage, ToastificationType.error);
              }
              if (state is UpdateProjectStatusSuccessState) {
                debugPrint("UpdateProjectStatusSuccessState");
                showToastification(
                    context,
                    "Successfully marked item as ${isActive() ? "inactive" : "active"}.",
                    ToastificationType.success);
                refreshListPage = true;
                _getProjectDetails();
                //widget.refreshPage();
              }
              if (state is DeleteProjectSuccessState) {
                refreshListPage = true;
                showToastification(context, "Successfully deleted.",
                    ToastificationType.success);
                onTapBack();
              }
            }
          },
          builder: (context, state) {
            if (removeObservingBloc == false) {
              if (state is ProjectDetailLoadingState) {
                return const LoadingPage(title: "Loading..");
              }
              if (state is UpdateProjectStatusLoadingState) {
                debugPrint("UpdateProjectStatusLoadingStat");

                return LoadingPage(
                    title:
                        isActive() ? "Mark as Inactive.." : "Mark as active..");
              }

              if (state is DeleteProjectLoadingState) {
                return const LoadingPage(title: "Deleting project..");
              }
            }

            return Column(
              children: [
                headerCell(context),
                Column(
                  children: [
                    Padding(
                      padding: AppConstants.horizonta16lVerticalPadding10,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Description",
                                  style: AppFonts.regularStyle(
                                      color: AppPallete.k666666),
                                ),
                                Text(
                                  projectEntity?.description ?? "",
                                  style: AppFonts.regularStyle(),
                                )
                              ],
                            ),
                          ),
                          AppConstants.sizeBoxWidth10,
                          Column(
                            children: [
                              Text(
                                "Status",
                                style: AppFonts.regularStyle(
                                    color: AppPallete.k666666),
                              ),
                              Text(
                                getStatusTitle(),
                                style: AppFonts.regularStyle(
                                    color: isActive()
                                        ? AppPallete.greenColor
                                        : AppPallete.red),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    const SectionHeaderWidget(title: "Activity"),
                    InputDropdownView(
                        isRequired: false,
                        title: "Invoices",
                        defaultText: "${projectEntity?.invoicecount ?? 0}",
                        value: "${projectEntity?.invoicecount ?? 0}",
                        dropDownImageName: Icons.chevron_right,
                        onPress: () {}),
                    InputDropdownView(
                        isRequired: false,
                        title: "Estimates",
                        defaultText: "${projectEntity?.estimatecount ?? 0}",
                        value: "${projectEntity?.estimatecount ?? 0}",
                        dropDownImageName: Icons.chevron_right,
                        onPress: () {}),
                    InputDropdownView(
                        isRequired: false,
                        showDivider: false,
                        title: "Expenses",
                        defaultText: "${projectEntity?.expensescount ?? 0}",
                        value: "${projectEntity?.estimatecount ?? 0}",
                        dropDownImageName: Icons.chevron_right,
                        onPress: () {}),
                  ],
                )
              ],
            );
          },
        ));
  }

  bool isActive() {
    final status = projectEntity?.status;
    if (status != null &&
        status.isNotEmpty &&
        status.toLowerCase() == "active") {
      return true;
    }
    return false;
  }

  String getStatusTitle() {
    if (isActive()) {
      return "Active";
    }
    return "Inactive";
  }

  Widget headerCell(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: AppPallete.lightBlueColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            projectEntity?.name ?? "",
            style: AppFonts.mediumStyle(color: AppPallete.blueColor, size: 22),
          ),
          if (isActive())
            Column(
              children: [
                const SizedBox(
                  height: 5,
                ),
                Text(
                  projectEntity?.clientName ?? "",
                  style:
                      AppFonts.regularStyle(color: AppPallete.black, size: 16),
                ),
              ],
            ),
          // const SizedBox(
          //   height: 10,
          // ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    _openUpdateProjectScreen();
                  },
                  child: headerActionCell(context,
                      actionButtonType: ProjectActionButtonType.edit),
                ),
                GestureDetector(
                  onTap: () {
                    showAdaptiveActionSheet(
                      context: context,
                      useRootNavigator: true,
                      androidBorderRadius: 30,
                      isDismissible: true,
                      actions: <BottomSheetAction>[
                        BottomSheetAction(
                            title: Text(
                              "Create Invoice",
                              style: AppFonts.regularStyle(
                                  color: AppPallete.blueColor, size: 16),
                            ),
                            onPressed: (context) {
                              dismissPopup(context);
                            }),
                        BottomSheetAction(
                            title: Text(
                              "Create Estimate",
                              style: AppFonts.regularStyle(
                                  color: AppPallete.blueColor, size: 16),
                            ),
                            onPressed: (context) {
                              dismissPopup(context);
                            }),
                      ],
                      cancelAction: CancelAction(
                          title: Text(
                        'Cancel',
                        style: AppFonts.mediumStyle(
                            color: AppPallete.blueColor, size: 16),
                      )), // onPressed parameter is optional by default will dismiss the ActionSheet
                    );
                  },
                  child: headerActionCell(context,
                      actionButtonType: ProjectActionButtonType.createNew),
                ),
                GestureDetector(
                  child: headerActionCell(context,
                      actionButtonType: ProjectActionButtonType.more),
                  onTap: () {
                    debugPrint("on tap more icon");
                    showAdaptiveActionSheet(
                      context: context,
                      useRootNavigator: true,
                      androidBorderRadius: 30,
                      isDismissible: true,
                      actions: <BottomSheetAction>[
                        BottomSheetAction(
                            title: Text(
                              isActive()
                                  ? "Mark as Inactive"
                                  : "Mark as Active",
                              style: AppFonts.regularStyle(
                                  color: AppPallete.blueColor, size: 16),
                            ),
                            onPressed: (context) {
                              dismissPopup(context);
                              _showUpdateStatusProjectAlert();
                            }),
                        BottomSheetAction(
                            title: Text(
                              "Delete",
                              style: AppFonts.regularStyle(
                                  color: AppPallete.red, size: 16),
                            ),
                            onPressed: (context) {
                              dismissPopup(context);
                              showDeleteAlert();
                            }),
                      ],
                      cancelAction: CancelAction(
                          title: Text(
                        'Cancel',
                        style: AppFonts.mediumStyle(
                            color: AppPallete.blueColor, size: 16),
                      )), // onPressed parameter is optional by default will dismiss the ActionSheet
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void onTapBack() {
    if (refreshListPage) {
      widget.refreshPage();
    }
    AutoRouter.of(context).maybePop();
  }

  void dismissPopup(context) {
    Navigator.of(context).pop();
  }

  void _showUpdateStatusProjectAlert() {
    showDialog(
        context: mainContext!,
        builder: (BuildContext context) {
          return AppAlertWidget(
            title: isActive() ? "Mark as Inactive" : "Mark as Active",
            message:
                "Are you sure you want to ${isActive() ? "inactive" : "active"} this project?",
            onTapDelete: () {
              dismissPopup(context);
              context.read<ProjectBloc>().add(UpdateProjectStatusEvent(
                  updateProjectStatusParams: UpdateProjectStatusParams(
                      id: projectEntity?.id ?? "", isActive: isActive())));
            },
            alertType: EnumAppAlertType.ok,
          );
        });
  }

  void showAlert() {
    showDialog(
        context: mainContext!,
        builder: (BuildContext context) {
          return AppAlertWidget(
            title: "Delete Project",
            message: "Are you sure you want to delete this project?",
            onTapDelete: () {
              dismissPopup(context);
              context.read<ProjectBloc>().add(DeleteProjectEvent(
                  deleteProjectParams:
                      DeleteProjectParams(id: projectEntity?.id ?? "")));
            },
            alertType: EnumAppAlertType.delete,
          );
        });
  }

  void _openUpdateProjectScreen() {
    removeObservingBloc = true;
    AutoRouter.of(context).push(AddProjectPageRoute(
        projectEntity: projectEntity,
        updatedProject: () {
          removeObservingBloc = false;
          refreshListPage = true;
          _getProjectDetails();
        },
        popBack: () {
          removeObservingBloc = false;
        },
        deletedProject: () {
          removeObservingBloc = false;
          debugPrint("_openUpdateProjectScreen");
          //widget.refreshPage();
          refreshListPage = true;
          onTapBack();
        }));
  }

  void showDeleteAlert() {
    Timer(const Duration(milliseconds: 500), () {
      showAlert();
    });
  }

  Widget headerActionCell(BuildContext context,
      {required ProjectActionButtonType actionButtonType}) {
    return Container(
      decoration: const BoxDecoration(color: AppPallete.lightBlueColor),
      child: Column(
        children: [
          Container(
            width: 35,
            height: 35,
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: AppPallete.blueColor),
            child: Center(
                child: Icon(
              actionButtonType.iconData,
              color: AppPallete.white,
            )),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            actionButtonType.name,
            style: AppFonts.regularStyle(size: 14, color: AppPallete.blueColor),
          ),
        ],
      ),
    );
  }
}
