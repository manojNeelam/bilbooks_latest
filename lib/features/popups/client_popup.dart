import 'package:auto_route/auto_route.dart';
import 'package:billbooks_app/core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_section_list/flutter_section_list.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../core/app_constants.dart';
import '../../core/theme/app_fonts.dart';
import '../../core/theme/app_pallete.dart';
import '../../core/widgets/item_separator.dart';
import '../../core/widgets/list_empty_page.dart';
import '../../core/widgets/list_empty_search_page.dart';
import '../../core/widgets/searchbar_widget.dart';
import '../../router/app_router.dart';
import '../clients/domain/entities/client_list_entity.dart';
import '../clients/domain/usecase/client_usecase.dart';
import '../clients/presentation/bloc/client_bloc.dart';
import '../clients/presentation/widgets/client_item_widget.dart';

@RoutePage()
class ClientPopup extends StatefulWidget {
  final List<ClientEntity>? clientListFromParentClass;
  final ClientEntity? selectedClient;
  final Function(ClientEntity?)? onSelectClient;
  const ClientPopup(
      {super.key,
      this.selectedClient,
      this.onSelectClient,
      this.clientListFromParentClass});

  @override
  State<ClientPopup> createState() => _ClientPopupState();
}

class _ClientPopupState extends State<ClientPopup> with SectionAdapterMixin {
  TextEditingController searchController = TextEditingController();
  List<ClientEntity> clientList = [];
  bool isLoading = false;
  ClientEntity? client;

  @override
  void initState() {
    debugPrint("Client List Init state");
    debugPrint("clientID: ${client?.clientId}");
    debugPrint("widget.selectedClient: ${widget.selectedClient?.clientId}");
    debugPrint("Client lENGTH: ${widget.clientListFromParentClass?.length}");

    client = widget.selectedClient;
    // if (widget.clientListFromParentClass != null &&
    //     widget.clientListFromParentClass!.isNotEmpty) {
    //   clientList = widget.clientListFromParentClass ?? [];
    // } else {
    //   _getClientList();
    // }
    _getClientList();
    super.initState();
  }

  void _getClientList() {
    context.read<ClientBloc>().add(GetList(
            clientListParams: ClientListParams(
          query: searchController.text,
          status: "",
          columnName: "name",
          sortOrder: "ASC",
          page: "1",
        )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Clients"),
        bottom: AppConstants.getAppBarDivider,
        actions: [
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
            isLoading = true;
          }
          if (state is ClientError) {
            isLoading = false;
            debugPrint("Error");
            debugPrint(state.toString());
          }
        },
        builder: (context, state) {
          if (state is ClientSuccess) {
            isLoading = false;
            clientList = state.clientResDataEntity?.clients ?? [];
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
          return Skeletonizer(
              enabled: isLoading,
              child: SectionListView.builder(adapter: this));
        },
      ),
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
    //debugPrint("clientEntity name: ${clientEntity.name}");
    debugPrint("Client ID: ${client?.clientId}");
    debugPrint("Current Client ID: ${clientEntity.clientId}");

    return GestureDetector(
      onTap: () {
        onSelectClient(clientEntity);
      },
      // child: Text(
      //   clientEntity.name ?? "No Name",
      //   style: AppFonts.regularStyle(),
      // ),
      child: ClientItemWidget(
        clientEntity: clientEntity,
        selectedClientEntity: client,
      ),
    );
  }

  @override
  int numberOfItems(int section) {
    debugPrint("Count: ${clientList.length}");
    return isLoading == true ? 10 : clientList.length;
  }

  Widget showEmptyView() {
    return ListEmptyPage(
      buttonTitle: "Create new client",
      noDataText: "Business without clients isn't easy.",
      iconName: Icons.people_alt_outlined,
      noDataSubtitle: "Create and manage your contacts, all in one place",
      callBack: () {
        AutoRouter.of(context).push(NewClientPageRoute(clientRemoved: () {}));
      },
    );
  }

  @override
  Widget getSectionHeader(BuildContext context, int section) {
    return Column(
      children: [
        SearchBarWidget(
          searchController: searchController,
          hintText: "Search Clients",
          dismissKeyboard: () {
            Utils.hideKeyboard();
          },
          onSubmitted: (searchText) {
            _getClientList();
          },
        ),
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            onSelectClient(null);
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
                      if (client == null)
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
        ),
      ],
    );
  }

  @override
  bool shouldExistSectionHeader(int section) {
    return true;
  }

  void onSelectClient(ClientEntity? clientEntity) {
    client = clientEntity;
    setState(() {});
    if (widget.onSelectClient != null) {
      widget.onSelectClient!(clientEntity);
    }
    AutoRouter.of(context).maybePop();
  }
}
