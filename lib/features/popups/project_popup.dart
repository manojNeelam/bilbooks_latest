import 'package:auto_route/auto_route.dart';
import 'package:billbooks_app/features/clients/domain/entities/client_list_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_section_list/flutter_section_list.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../core/app_constants.dart';
import '../../core/theme/app_fonts.dart';
import '../../core/theme/app_pallete.dart';
import '../../core/widgets/item_separator.dart';
import '../../core/widgets/list_empty_page.dart';
import '../../router/app_router.dart';
import '../project/domain/entity/project_list_entity.dart';
import '../project/domain/usecase/project_usecase.dart';
import '../project/presentation/bloc/project_bloc.dart';

@RoutePage()
class ProjectPopup extends StatefulWidget {
  final ClientEntity? selectedClient;
  final String? clientId;
  final Function(ProjectEntity?)? onSelectProject;
  final ProjectEntity? selectedProject;
  const ProjectPopup(
      {super.key,
      this.onSelectProject,
      this.selectedProject,
      this.clientId,
      this.selectedClient});

  @override
  State<ProjectPopup> createState() => _ProjectPopupState();
}

class _ProjectPopupState extends State<ProjectPopup> with SectionAdapterMixin {
  ProjectEntity? project;
  List<ProjectEntity> projects = [];
  String status = "";
  bool isLoading = false;

  @override
  void initState() {
    project = widget.selectedProject;
    _getProjectList();
    super.initState();
  }

  void _getProjectList() {
    context.read<ProjectBloc>().add(GetProjectListEvent(
            projectListParams: ProjectListParams(
          status: status,
          sortColumn: "name",
          sortOder: "ASC",
          query: "",
          clientId: widget.clientId,
          page: "1",
        )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Projects"),
        bottom: AppConstants.getAppBarDivider,
        actions: [
          IconButton(
              onPressed: () {
                _openAddProjectScreen();
              },
              icon: const Icon(
                Icons.add,
                color: AppPallete.blueColor,
              )),
        ],
      ),
      body: Container(
        color: AppPallete.white,
        child: BlocBuilder<ProjectBloc, ProjectState>(
          builder: (context, state) {
            if (state is ProjectListLoading) {
              isLoading = true;
            } else if (state is ProjectListSuccess) {
              isLoading = false;
              projects = state.projectMainResEntity.data?.projects ?? [];
              if (projects.isEmpty) {
                return showEmptyView();
              }
            } else if (state is ProjectListError) {
              isLoading = false;
            }

            return RefreshIndicator.adaptive(
                onRefresh: _handleRefresh,
                child: Skeletonizer(
                    enabled: isLoading,
                    child: SectionListView.builder(adapter: this)));
          },
        ),
      ),
    );
  }

  @override
  int numberOfSections() {
    return 1;
  }

  @override
  bool shouldExistSectionHeader(int section) {
    return true;
  }

  @override
  Widget getSectionHeader(BuildContext context, int section) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        onSelectProject(null);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: AppConstants.verticalPadding13,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "None",
                    style: AppFonts.regularStyle(),
                  ),
                  if (project == null)
                    const Icon(
                      Icons.check,
                      color: AppPallete.blueColor,
                    )
                ],
              ),
            ),
            const ItemSeparator(),
          ],
        ),
      ),
    );
  }

  Widget showEmptyView() {
    return ListEmptyPage(
      buttonTitle: "Create new project",
      noDataText: getNoDataText(),
      iconName: Icons.rocket_launch,
      noDataSubtitle: "",
      callBack: () {
        _openAddProjectScreen();
      },
    );
  }

  String getNoDataText() {
    return "There are no projects";
  }

  Future<void> _handleRefresh() async {
    _getProjectList();
  }

  void _openAddProjectScreen() {
    AutoRouter.of(context).push(AddProjectPageRoute(
        clientEntity: widget.selectedClient,
        deletedProject: () {},
        updatedProject: () {
          _getProjectList();
        }));
  }

  @override
  Widget getItem(BuildContext context, IndexPath indexPath) {
    ProjectEntity projectEntity = isLoading
        ? ProjectEntity(
            clientName: "Client Name",
            name: "Name comes here",
            status: "active")
        : projects[indexPath.item];
    return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          onSelectProject(projectEntity);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: AppConstants.verticalPadding13,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        projectEntity.name ?? "",
                        style: AppFonts.regularStyle(),
                      ),
                    ),
                    if (projectEntity.id == project?.id)
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
        ));
  }

  @override
  int numberOfItems(int section) {
    return isLoading ? 10 : projects.length;
  }

  void onSelectProject(ProjectEntity? projectEntity) {
    project = projectEntity;
    setState(() {});
    if (widget.onSelectProject != null) {
      widget.onSelectProject!(project);
    }
    AutoRouter.of(context).maybePop();
  }
}
