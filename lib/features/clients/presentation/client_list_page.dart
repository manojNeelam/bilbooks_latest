import 'package:auto_route/auto_route.dart';
import 'package:billbooks_app/core/app_constants.dart';
import 'package:billbooks_app/core/theme/app_pallete.dart';
import 'package:billbooks_app/core/widgets/list_empty_search_page.dart';
import 'package:billbooks_app/features/clients/domain/entities/client_list_entity.dart';
import 'package:billbooks_app/features/clients/domain/usecase/client_usecase.dart';
import 'package:billbooks_app/features/clients/presentation/bloc/client_bloc.dart';
import 'package:billbooks_app/features/clients/presentation/widgets/client_item_widget.dart';
import 'package:billbooks_app/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_section_list/flutter_section_list.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:toastification/toastification.dart';

import '../../../core/theme/app_fonts.dart';
import '../../../core/utils/show_toast.dart';
import '../../../core/utils/utils.dart';
import '../../../core/widgets/list_empty_page.dart';
import '../../../core/widgets/searchbar_widget.dart';
import '../../more/expenses/presentation/widgets/expenses_sort_page.dart';
import 'client_sort_page.dart';

@RoutePage()
class ClientListPage extends StatefulWidget {
  const ClientListPage({super.key});

  @override
  State<ClientListPage> createState() => _ClientListPageState();
}

class _ClientListPageState extends State<ClientListPage>
    with SectionAdapterMixin, AutomaticKeepAliveClientMixin {
  TextEditingController searchController = TextEditingController();
  List<ClientEntity> clientList = [];
  bool isLoading = false;
  EnumClientType selectedType = EnumClientType.all;
  EnumClientSortBy selectedClientSortBy = EnumClientSortBy.name;
  EnumOrderBy selectedOrderBy = EnumOrderBy.ascending;
  ScrollController _scrollController = ScrollController();
  Paging? paging;
  int currentPage = 1;
  bool isFromPagination = false;

  @override
  void initState() {
    debugPrint("Client List Init state");
    _setupScrollController();
    if (clientList.isEmpty) {
      _getClientList();
    }
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
        _getClientList();
      }
    }
  }

  void _getClientList() {
    context.read<ClientBloc>().add(GetList(
            clientListParams: ClientListParams(
          query: searchController.text,
          status: selectedType.apiParams,
          columnName: "name",
          sortOrder: selectedOrderBy.apiParamsValue,
          page: currentPage.toString(),
        )));
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
      hintText: "Search Clients",
      onSubmitted: (searchText) {
        _getClientList();
      },
      dismissKeyboard: () {
        Utils.hideKeyboard();
      },
    );
  }

  Future<void> _handleRefresh() async {
    currentPage = 1;
    _getClientList();
  }

  @override
  Widget build(BuildContext context) {
    //debugPrint("Font Family: ${DefaultTextStyle.of(context).style.fontFamily}");

    super.build(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Clients"),
        bottom: AppConstants.getAppBarDivider,
        actions: [
          IconButton(
              onPressed: () {
                AutoRouter.of(context).push(ClientSortPageRoute(
                  callBack: (type, order, sortby) {
                    selectedType = type;
                    selectedOrderBy = order;
                    selectedClientSortBy = sortby;
                    currentPage = 1;
                    _getClientList();
                  },
                  selectedOrderBy: selectedOrderBy,
                  selectedType: selectedType,
                  selectedClientSortBy: selectedClientSortBy,
                ));
              },
              icon: const Icon(
                Icons.filter_list_alt,
                color: AppPallete.blueColor,
              )),
          IconButton(
              onPressed: () {
                AutoRouter.of(context)
                    .push(NewClientPageRoute(clientRemoved: () {}));
              },
              icon: const Icon(
                Icons.add,
                color: AppPallete.blueColor,
              ))
        ],
      ),
      body: BlocConsumer<ClientBloc, ClientState>(
        listener: (context, state) {
          if (state is ClientLoading) {
            if (!isFromPagination) isLoading = true;
          }

          if (state is ClientError) {
            isLoading = false;
            isFromPagination = false;
            showToastification(context, "", ToastificationType.error);
          }
        },
        builder: (context, state) {
          if (state is ClientSuccess) {
            if (currentPage == 1) {
              clientList = [];
            }
            paging = state.clientResDataEntity?.paging;
            currentPage = paging?.currentpage ?? 0;
            isFromPagination = false;
            final clients = state.clientResDataEntity?.clients ?? [];
            clientList.addAll(clients);
            isLoading = false;

            if (clientList.isEmpty) {
              if (searchController.text.isNotEmpty) {
                return ListEmptySearchPage(
                    searchText: searchController.text,
                    callBack: () {
                      searchController.text = "";
                      _getClientList();
                    });
              }
              return showEmptyView();
            }
          }
          return RefreshIndicator.adaptive(
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
            ),
          );
        },
      ),
    );
  }

  Widget showEmptyView() {
    return ListEmptyPage(
      buttonTitle: "Create new client",
      noDataText: "Business without clients isn't easy.",
      iconName: Icons.people_alt_outlined,
      noDataSubtitle: "Create and manage your contacts, all in one place",
      callBack: () {
        AutoRouter.of(context).push(NewClientPageRoute(refreshClient: () {
          _getClientList();
        }, clientRemoved: () {
          _getClientList();
        }));
      },
    );
  }

  @override
  Widget getItem(BuildContext context, IndexPath indexPath) {
    final clientEntity = isLoading
        ? ClientEntity(
            name: "Test User",
            address: "This is placeholder address",
            status: "active")
        : clientList[indexPath.item];
    return GestureDetector(
        onTap: () {
          AutoRouter.of(context).push(ClientDetailPageRoute(
              clientEntity: clientEntity,
              refreshList: () {
                currentPage = 1;
                _getClientList();
              }));
        },
        child: ClientItemWidget(
          clientEntity: clientEntity,
        ));
  }

  @override
  int numberOfItems(int section) {
    return isLoading == true ? 10 : clientList.length;
  }

  @override
  bool get wantKeepAlive => false;
}
