import 'package:auto_route/auto_route.dart';
import 'package:billbooks_app/core/theme/app_pallete.dart';
import 'package:billbooks_app/core/widgets/list_empty_search_page.dart';
import 'package:billbooks_app/features/project/domain/entity/project_list_entity.dart';
import 'package:billbooks_app/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_section_list/flutter_section_list.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../core/app_constants.dart';
import '../../../core/theme/app_fonts.dart';
import '../../../core/utils/utils.dart';
import '../../../core/widgets/list_empty_page.dart';
import '../../../core/widgets/searchbar_widget.dart';
import '../../clients/domain/entities/client_list_entity.dart';
import '../../more/expenses/presentation/widgets/expenses_sort_page.dart';
import '../domain/usecase/project_usecase.dart';
import 'bloc/project_bloc.dart';
import 'project_sort_page.dart';
import 'widgets/project_list_card_widget.dart';
import 'widgets/project_type_header_widget.dart';

@RoutePage()
class ProjectListPage extends StatefulWidget {
  final bool isFromMore;
  const ProjectListPage({super.key, this.isFromMore = true});

  @override
  State<ProjectListPage> createState() => _ProjectListPageState();
}

class _ProjectListPageState extends State<ProjectListPage>
    with SectionAdapterMixin {
  TextEditingController searchController = TextEditingController();
  EnumProjectType selectedType = EnumProjectType.active;
  EnumProjectSortBy selectedProjectSortBy = EnumProjectSortBy.name;
  EnumOrderBy selectedOrderBy = EnumOrderBy.ascending;
  //ProjectListEntity? projectListEntity;
  List<ProjectEntity> projects = [];
  String status = "";
  bool isLoading = false;
  ScrollController _scrollController = ScrollController();
  Paging? paging;
  int currentPage = 1;
  bool isFromPagination = false;

  @override
  void initState() {
    _setupScrollController();
    _getProjectList();
    super.initState();
  }

  void _setupScrollController() {
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.offset >=
        _scrollController.position.maxScrollExtent) {
      if (paging == null) {
        return;
      }
      final totalPages = paging?.totalpages ?? 0;
      if (totalPages >= currentPage + 1 && !isFromPagination) {
        currentPage = currentPage + 1;
        isFromPagination = true;
        _getProjectList();
      }
    }
  }

  void _getProjectList() {
    switch (selectedType) {
      case EnumProjectType.all:
        status = "";
      case EnumProjectType.active:
        status = "active";
      case EnumProjectType.inactive:
        status = "inactive";
    }
    debugPrint(status);
    /*
    EnumProjectType selectedType = EnumProjectType.active;
  EnumProjectSortBy selectedProjectSortBy = EnumProjectSortBy.name;
  EnumOrderBy selectedOrderBy = EnumOrderBy.ascending;
    */
    final orderByValue = selectedOrderBy.apiParamsValue; //ASC, DESC
    final sortByValue = selectedProjectSortBy.apiParamsValue;

    context.read<ProjectBloc>().add(GetProjectListEvent(
            projectListParams: ProjectListParams(
          status: status,
          sortColumn: sortByValue,
          sortOder: orderByValue,
          query: searchController.text,
          page: currentPage.toString(),
        )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Projects"),
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(45),
            child: ProjectTypeHeaderWidget(
              selectedType: selectedType,
              callBack: (type) {
                if (type == selectedType) {
                  return;
                }
                selectedType = type;
                currentPage = 1;
                setState(() {});
                _getProjectList();
              },
            )),
        actions: [
          IconButton(
              onPressed: () {
                AutoRouter.of(context).push(ProjectSortPageRoute(
                    callBack: (type, orderBy, sortBy) {
                      selectedOrderBy = orderBy;
                      selectedProjectSortBy = sortBy;
                      selectedType = type;
                      setState(() {});
                      currentPage = 1;
                      _getProjectList();
                    },
                    selectedOrderBy: selectedOrderBy,
                    selectedProjectSortBy: selectedProjectSortBy,
                    selectedType: selectedType));
              },
              icon: const Icon(
                Icons.filter_list_alt,
                color: AppPallete.blueColor,
              )),
          IconButton(
              onPressed: () {
                _openAddProjectScreen();
              },
              icon: const Icon(
                Icons.add,
                color: AppPallete.blueColor,
              )),
        ],
        leading: !widget.isFromMore
            ? IconButton(
                onPressed: () {},
                icon: const Icon(Icons.close, color: AppPallete.blueColor),
              )
            : null,
      ),
      body: Container(
        color: AppPallete.white,
        child: BlocBuilder<ProjectBloc, ProjectState>(
          builder: (context, state) {
            if (state is ProjectListLoading) {
              if (!isFromPagination) isLoading = true;
            } else if (state is ProjectListSuccess) {
              if (currentPage == 1) {
                projects = [];
              }

              final projectList =
                  state.projectMainResEntity.data?.projects ?? [];
              paging = state.projectMainResEntity.data?.paging;
              currentPage = paging?.currentpage ?? 0;
              isFromPagination = false;
              projects.addAll(projectList);
              isLoading = false;
              if (projects.isEmpty) {
                if (searchController.text.isNotEmpty) {
                  return ListEmptySearchPage(
                      buttonTitle: "Refresh",
                      noDataText: "No results for keyword",
                      searchText: searchController.text,
                      iconName: Icons.shopping_bag_outlined,
                      callBack: () {
                        searchController.text = "";
                        _getProjectList();
                      });
                }
                return showEmptyView();
              }
            } else if (state is ProjectListError) {
              isFromPagination = false;
              isLoading = false;
            }

            return SafeArea(
              child: RefreshIndicator.adaptive(
                  onRefresh: _handleRefresh,
                  child: Column(
                    children: [
                      Expanded(
                        child: Skeletonizer(
                            enabled: isLoading,
                            child: SectionListView.builder(
                              adapter: this,
                              controller: _scrollController,
                            )),
                      ),
                      if (isFromPagination)
                        Container(
                          color: AppPallete.clear,
                          width: MediaQuery.of(context).size.width,
                          height: 40,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Loading More...",
                                style: AppFonts.regularStyle(),
                              ),
                              AppConstants.sizeBoxWidth10,
                              const CircularProgressIndicator.adaptive()
                            ],
                          ),
                        ),
                    ],
                  )),
            );
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
    return SearchBarWidget(
      searchController: searchController,
      hintText: "Search Projects",
      onSubmitted: (searchText) {
        _getProjectList();
      },
      dismissKeyboard: () {
        Utils.hideKeyboard();
      },
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
    switch (selectedType) {
      case EnumProjectType.active:
        return "There are no active projects";
      case EnumProjectType.inactive:
        return "There are no inactive rojects";
      case EnumProjectType.all:
        return "There are no projects";
    }
  }

  Future<void> _handleRefresh() async {
    currentPage = 1;
    _getProjectList();
  }

  void _openAddProjectScreen() {
    AutoRouter.of(context).push(AddProjectPageRoute(
        deletedProject: () {},
        updatedProject: () {
          currentPage = 1;
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
          AutoRouter.of(context).push(ProjectDetailPageRoute(
              projectEntity: projectEntity,
              refreshPage: () {
                _getProjectList();
              }));
        },
        child: ProjectListCardWidget(
          projectEntity: projectEntity,
        ));
  }

  @override
  int numberOfItems(int section) {
    return isLoading ? 10 : projects.length;
  }
}
