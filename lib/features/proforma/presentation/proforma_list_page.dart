import 'package:auto_route/auto_route.dart';
import 'package:billbooks_app/core/app_constants.dart';
import 'package:billbooks_app/core/theme/app_pallete.dart';
import 'package:billbooks_app/core/utils/show_toast.dart';
import 'package:billbooks_app/core/utils/utils.dart';
import 'package:billbooks_app/features/proforma/presentation/bloc/proforma_bloc.dart';
import 'package:billbooks_app/features/proforma/presentation/widgets/proforma_type_header_widget.dart';
import 'package:billbooks_app/main.dart';
import 'package:billbooks_app/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_section_list/flutter_section_list.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:toastification/toastification.dart';
import '../../../../core/theme/app_fonts.dart';
import '../../../../core/utils/trial_expiry_widget.dart';
import '../../../../core/widgets/list_count_header_widget.dart';
import '../../../../core/widgets/list_empty_page.dart';
import '../../../../core/widgets/list_empty_search_page.dart';
import '../../clients/domain/entities/client_list_entity.dart';
import '../../invoice/domain/entities/invoice_list_entity.dart';
import '../../invoice/domain/usecase/get_document_usecase.dart';
import '../../invoice/presentation/send_invoice_estimate_page.dart';
import '../../invoice/presentation/widgets/invoice_list_item.widget.dart';
import '../domain/entities/proforma_list_entity.dart';
import '../domain/usecase/proforma_list_usecase.dart';
import 'add_proforma_page.dart';

enum EnumProformaSwipeOptions { send, duplicate }

typedef ProformaListBuilder = void Function(
    BuildContext context, Function() refreshList);

class ProformaListPage extends StatefulWidget {
  final InvoiceListBuilder builder;
  const ProformaListPage({
    super.key,
    required this.builder,
  });

  @override
  State<ProformaListPage> createState() => _ProformaListPageState();
}

class _ProformaListPageState extends State<ProformaListPage>
    with SectionAdapterMixin, AutomaticKeepAliveClientMixin {
  bool isLoading = false;
  TextEditingController searchController = TextEditingController();

  EnumProformaType selectedType = EnumProformaType.all;
  List<ProformaEntity> proformas = [];
  EnumAllTimes selectedAllTimes = EnumAllTimes.all;
  String allTimesDisplayName = "All";
  bool isIgnoreBlocStates = false;
  ScrollController _scrollController = ScrollController();
  Paging? paging;
  int currentPage = 1;
  bool isFromPagination = false;
  String? startDateReqParams;
  String? endDateReqParams;
  bool isFromAddNewProforma = false;
  ProformaListMainResEntity? proformaListMainResEntity;
  Map<EnumProformaType, int> counts = {};

  @override
  void initState() {
    _setupScrollController();
    _getProformaList();
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
        _getProformaList();
      }
    }
  }

  void _getProformaList() {
    context.read<ProformaBloc>().add(GetProformaListEvent(
            params: ProformaListReqParams(
          status: selectedType.apiParams,
          query: searchController.text,
          sortOrder: "desc",
          columnName: "date",
          page: currentPage.toString(),
          startDate: startDateReqParams,
          endDate: endDateReqParams,
        )));
  }

  Map<EnumProformaType, int> getProformaCounts() {
    final statusCount =
        proformaListMainResEntity?.data?.statusCount?.firstOrNull;

    if (statusCount == null) {
      return {
        EnumProformaType.all: 0,
        EnumProformaType.draft: 0,
        EnumProformaType.sent: 0,
        EnumProformaType.approved: 0,
        EnumProformaType.declined: 0,
      };
    }

    return {
      EnumProformaType.all: int.tryParse(statusCount.allcount ?? "") ?? 0,
      EnumProformaType.draft: int.tryParse(statusCount.draft ?? "") ?? 0,
      EnumProformaType.sent: int.tryParse(statusCount.sent ?? "") ?? 0,
      EnumProformaType.approved: int.tryParse(statusCount.approved ?? "") ?? 0,
      EnumProformaType.declined: int.tryParse(statusCount.declined ?? "") ?? 0,
    };
  }

  bool isDraft(ProformaEntity proformaEntity) {
    final status = proformaEntity.status ?? "";
    if (status.isNotEmpty && status.toLowerCase() == "draft") {
      return true;
    }
    return false;
  }

  bool isSent(ProformaEntity proformaEntity) {
    final status = proformaEntity.status ?? "";
    if (status.isNotEmpty && status.toLowerCase() == "sent") {
      return true;
    }
    return false;
  }

  void _onTapSendDoc(String id) {
    AutoRouter.of(context).push(SendInvoiceEstimatePageRoute(
        params: GetDocumentUsecaseReqParams(
            pageType: EnumSendPageType.send,
            type: EnumDocumentType.invoice,
            id: id)));
  }

  String get invoiceCountText {
    final total = counts[EnumProformaType.all] ?? 0;
    return "$total Proformas";
  }

  Widget showEmptyView() {
    if (selectedAllTimes != EnumAllTimes.all) {
      return ListEmptySearchPage(
          searchText: allTimesDisplayName,
          buttonTitle: "Reset",
          noDataText: "No results found for",
          callBack: () {
            selectedAllTimes = EnumAllTimes.all;
            allTimesDisplayName = "";
            startDateReqParams = null;
            endDateReqParams = null;
            _getProformaList();
          });
    }

    if (searchController.text.isNotEmpty) {
      return ListEmptySearchPage(
          searchText: searchController.text,
          callBack: () {
            searchController.text = "";
            _getProformaList();
          });
    }

    return ListEmptyPage(
        buttonTitle: "Add New Proforma",
        noDataText: "No record found",
        noDataSubtitle:
            "A proforma invoice is a preliminary, non-binding document sent by sellers to buyers before a sale is finalized, detailing goods/services, prices, and shipping info. Note: Proforma invoice amounts are not accounted for in reports or dashboard.",
        iconName: Icons.file_copy,
        callBack: () {
          _showAddProforma();
        });
  }

  @override
  Widget getItem(BuildContext context, IndexPath indexPath) {
    final item = isLoading
        ? ProformaEntity.fromInvoiceEntity(InvoiceEntity.mock)
        : proformas[indexPath.item];
    return GestureDetector(
      child: SwipeActionCell(
        key: ObjectKey(item),
        trailingActions: [
          if (isDraft(item))
            SwipeAction(
                closeOnTap: true,
                style: AppFonts.regularStyle(color: AppPallete.white),
                title: "Send",
                onTap: (CompletionHandler handler) async {
                  await handler(false);
                  if (isDraft(item)) {
                    if (item.id != null) {
                      _onTapSendDoc(item.id!);
                    }
                  }
                },
                color: AppPallete.blueColor),
          SwipeAction(
              closeOnTap: true,
              style: AppFonts.regularStyle(color: AppPallete.white),
              title: "Duplicate",
              onTap: (CompletionHandler handler) async {
                handler(false);
                if (item.id != null) {
                  _onTapDuplicate(item.toInvoiceEntity());
                }
              },
              color: AppPallete.borderColor),
        ],
        child: InvoiceListItemWidget(
          invoiceEntity: item.toInvoiceEntity(),
        ),
      ),
      onTap: () {
        isIgnoreBlocStates = true;
        AutoRouter.of(context).push(AddProformaPageRoute(
            proformaEntity: item.toInvoiceEntity(),
            type: EnumNewProformaType.editProforma,
            startObserveBlocBack: () {
              isFromAddNewProforma = true;
              isIgnoreBlocStates = false;
              setState(() {});
            },
            deletedItem: () {
              _getProformaList();
            },
            refreshCallBack: () {
              isIgnoreBlocStates = false;
              _getProformaList();
            }));
      },
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
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      child: ListCountHeader(
        controller: searchController,
        hintText: "Search Proformas",
        capsuleText: invoiceCountText,
        selectedMenuItem: selectedAllTimes,
        dismissKeyboard: () {
          Utils.hideKeyboard();
        },
        onSubmitted: (val) {
          _getProformaList();
        },
        onSelectedMenuItem: (val, displayName, startDate, endDate) {
          selectedAllTimes = val;
          allTimesDisplayName = displayName;
          startDateReqParams = startDate;
          endDateReqParams = endDate;

          showToastification(
              context, "Selected ${val.title}", ToastificationType.info);

          _getProformaList();
          setState(() {});
        },
      ),
    );
  }

  @override
  int numberOfItems(int section) {
    return isLoading == true ? 10 : proformas.length;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Proformas"),
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(45),
            child: ProformaTypeHeaderWidget(
              selectedType: selectedType,
              counts: counts,
              callBack: (type) {
                selectedType = type;
                setState(() {});
                currentPage = 1;
                _getProformaList();
              },
            )),
        actions: [
          IconButton(
              onPressed: () {
                _showAddProforma();
              },
              icon: const Icon(
                Icons.add,
                color: AppPallete.blueColor,
              ))
        ],
      ),
      body: BlocConsumer<ProformaBloc, ProformaState>(
        listener: (context, state) {
          if (isIgnoreBlocStates) {
            return;
          }

          if (state is ProformaListSuccessState) {
            setState(() {
              proformaListMainResEntity = state.proformaListMainResEntity;
              final proformaList =
                  state.proformaListMainResEntity.data?.proformas ?? [];

              if (currentPage == 1) {
                proformas = proformaList;
              } else {
                proformas.addAll(proformaList);
              }

              paging = state.proformaListMainResEntity.data?.paging;
              currentPage = paging?.currentpage ?? currentPage;
              isFromPagination = false;
              isLoading = false;
              counts = getProformaCounts();
            });
          }

          if (state is ProformaListFailureState) {
            isFromPagination = false;
            showToastification(
                context, state.errorMessage, ToastificationType.error);
          }
        },
        builder: (context, state) {
          if (!isIgnoreBlocStates) {
            if (state is ProformaListFailureState && proformas.isEmpty) {
              return showEmptyView();
            }

            if (state is ProformaListSuccessState && proformas.isEmpty) {
              return showEmptyView();
            }

            if (state is ProformaListLoadingState) {
              if (!isFromPagination) isLoading = true;
            }
          }

          if (isLoading == false && isFromAddNewProforma) {
            if (proformas.isEmpty) {
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

  void _onTapDuplicate(InvoiceEntity item) {
    isIgnoreBlocStates = true;
    AutoRouter.of(context).push(AddProformaPageRoute(
        proformaEntity:
            ProformaEntity.fromInvoiceEntity(item).toInvoiceEntity(),
        type: EnumNewProformaType.duplicateProforma,
        startObserveBlocBack: () {
          isFromAddNewProforma = true;
          isIgnoreBlocStates = false;
          setState(() {});
        },
        deletedItem: () {},
        refreshCallBack: () {
          isIgnoreBlocStates = false;
        }));
  }

  void _forceRefreshList() {
    currentPage = 1;
    _getProformaList();
  }

  Future<void> _handleRefresh() async {
    _forceRefreshList();
  }

  void _showAddProforma() async {
    var isPremiumUser = await Utils.getIsPremiumUser();
    if (isPremiumUser ?? false) {
      isIgnoreBlocStates = true;
      AutoRouter.of(context).push(AddProformaPageRoute(
          proformaEntity: null,
          type: EnumNewProformaType.new_proforma,
          startObserveBlocBack: () {
            isFromAddNewProforma = true;
            isIgnoreBlocStates = false;
          },
          deletedItem: () {},
          refreshCallBack: () {
            isIgnoreBlocStates = false;
            _getProformaList();
          }));
    } else {
      TrialService.checkTrialStatus(context: context, mounted: mounted);
    }
  }

  @override
  bool get wantKeepAlive => true;
}
