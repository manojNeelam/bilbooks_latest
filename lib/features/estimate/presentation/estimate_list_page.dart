import 'package:auto_route/auto_route.dart';
import 'package:billbooks_app/core/utils/utils.dart';
import 'package:billbooks_app/core/widgets/list_empty_page.dart';
import 'package:billbooks_app/core/widgets/loading_page.dart';
import 'package:billbooks_app/features/clients/domain/entities/client_list_entity.dart';
import 'package:billbooks_app/features/estimate/domain/usecase/estimate_list_usecase.dart';
import 'package:billbooks_app/features/estimate/presentation/bloc/estimate_bloc.dart';
import 'package:billbooks_app/features/estimate/presentation/widgets/estimate_type_header_widget.dart';
import 'package:billbooks_app/features/invoice/domain/entities/invoice_list_entity.dart';
import 'package:billbooks_app/features/invoice/presentation/add_new_invoice_page.dart';
import 'package:billbooks_app/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_section_list/flutter_section_list.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:toastification/toastification.dart';
import '../../../core/app_constants.dart';
import '../../../core/theme/app_fonts.dart';
import '../../../core/theme/app_pallete.dart';
import '../../../core/utils/show_toast.dart';
import '../../../core/widgets/list_count_header_widget.dart';
import '../../../core/widgets/list_empty_search_page.dart';
import '../../invoice/domain/entities/invoice_details_entity.dart';
import '../../invoice/domain/usecase/get_document_usecase.dart';
import '../../invoice/domain/usecase/invoice_usecase.dart';
import '../../invoice/presentation/bloc/invoice_bloc.dart';
import '../../invoice/presentation/send_invoice_estimate_page.dart';
import '../../more/expenses/presentation/widgets/expenses_sort_page.dart';
import '../domain/entity_list_entity.dart';
import 'estimate_sort_page.dart';
import 'widgets/estimate_list_item_widget.dart';

enum EnumEstimateType {
  all,
  draft,
  sent,
  approved,
  invoiced,
  declined,
  expired
}

extension EnumEstimateTypeExtension on EnumEstimateType {
  //draft. sent, approved, invoiced, declined, expired
  String get apiParams {
    switch (this) {
      case EnumEstimateType.all:
        return "";
      case EnumEstimateType.draft:
        return "draft";
      case EnumEstimateType.sent:
        return "sent";
      case EnumEstimateType.approved:
        return "approved";
      case EnumEstimateType.invoiced:
        return "invoiced";
      case EnumEstimateType.declined:
        return "declined";
      case EnumEstimateType.expired:
        return "expired";
    }
  }

  String get title {
    switch (this) {
      case EnumEstimateType.all:
        return "All";
      case EnumEstimateType.draft:
        return "Draft";
      case EnumEstimateType.sent:
        return "Sent";
      case EnumEstimateType.approved:
        return "Approved";
      case EnumEstimateType.invoiced:
        return "Invoiced";
      case EnumEstimateType.declined:
        return "Declined";
      case EnumEstimateType.expired:
        return "Expired";
    }
  }
}

class EstimateListPage extends StatefulWidget {
  const EstimateListPage({super.key});

  @override
  State<EstimateListPage> createState() => _EstimateListPageState();
}

class _EstimateListPageState extends State<EstimateListPage>
    with SectionAdapterMixin, AutomaticKeepAliveClientMixin {
  TextEditingController searchController = TextEditingController();

  EnumEstimateType selectedType = EnumEstimateType.all;
  EnumEstimateSortBy selectedEstimateSortBy = EnumEstimateSortBy.date;
  EnumOrderBy selectedOrderBy = EnumOrderBy.ascending;
  EstimateListDataEntity? estimateListDataEntity;
  List<InvoiceEntity> estimates = [];
  bool isLoading = false;
  EnumAllTimes selectedAllTimes = EnumAllTimes.all;
  String allTimesDisplayName = EnumAllTimes.all.displayName.$3;
  bool isIgnoreBlocStates = false;
  EnumNewInvoiceEstimateType? invoiceEstimateType;
  ScrollController _scrollController = ScrollController();
  bool isFromPagination = false;
  int currentPage = 1;
  Paging? paging;
  String estimateHeading = "Estimate";
  String? startDateReqParams;
  String? endDateReqParams;

  bool isSent(InvoiceEntity invoiceEntity) {
    final status = invoiceEntity.status ?? "";
    if (status.isNotEmpty && status.toLowerCase() == "sent") {
      return true;
    }
    return false;
  }

  bool isDraft(InvoiceEntity invoiceEntity) {
    final status = invoiceEntity.status ?? "";
    if (status.isNotEmpty && status.toLowerCase() == "draft") {
      return true;
    }
    return false;
  }

  bool isInvoiced(InvoiceEntity invoiceEntity) {
    final status = invoiceEntity.status ?? "";
    if (status.isNotEmpty && status.toLowerCase() == "invoiced") {
      return true;
    }
    return false;
  }

  void _setupScrollController() {
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.offset >=
        _scrollController.position.maxScrollExtent) {
      debugPrint("_scrollListener");
      if (paging == null) {
        debugPrint("paging == null");

        return;
      }
      final totalPages = paging?.totalpages ?? 0;
      if (totalPages >= currentPage + 1 && !isFromPagination) {
        currentPage = currentPage + 1;
        isFromPagination = true;
        _loadEstimates();
      }
    }
  }

  @override
  Widget getItem(BuildContext context, IndexPath indexPath) {
    final item = isLoading
        ? InvoiceEntity(
            clientName: "Test Name",
            nettotal: "100",
            date: "DDMMYYYY",
            status: "Status comes here")
        : estimates[indexPath.item];
    return GestureDetector(
      child: SwipeActionCell(
        key: ObjectKey(item),
        trailingActions: [
          if (!isInvoiced(item))
            SwipeAction(
              closeOnTap: true,
              style: AppFonts.regularStyle(color: AppPallete.white),
              title: isDraft(item) ? "Send" : "Invoice",
              onTap: (CompletionHandler handler) async {
                await handler(false);
                if (isDraft(item)) {
                  if (item.id != null) {
                    _onTapSendDoc(item.id!);
                  }
                } else {
                  if (item.id != null) {
                    invoiceEstimateType =
                        EnumNewInvoiceEstimateType.convertEstimateToInvoice;
                    _loadInvoiceDetails(item.id ?? "");
                  }
                }
              },
              color:
                  isDraft(item) ? AppPallete.blueColor : AppPallete.greenColor,
            ),
          SwipeAction(
              closeOnTap: true,
              style: AppFonts.regularStyle(color: AppPallete.white),
              title: "Duplicate",
              onTap: (CompletionHandler handler) async {
                await handler(false);
                if (item.id != null) {
                  invoiceEstimateType =
                      EnumNewInvoiceEstimateType.duplicateEstimate;
                  _loadInvoiceDetails(item.id ?? "");
                }
              },
              color: AppPallete.borderColor),
        ],
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: EstimateListItemWidget(
            estimateEntity: item,
          ),
        ),
      ),
      onTap: () {
        isIgnoreBlocStates = true;
        AutoRouter.of(context).push(InvoiceDetailPageRoute(
            invoiceEntity: item,
            type: EnumNewInvoiceEstimateType.estimate,
            startObserveBlocBack: () {
              isIgnoreBlocStates = false;
            },
            refreshList: () {
              isIgnoreBlocStates = false;
              _loadEstimates();
            },
            estimateTitle: estimateHeading));
      },
    );
  }

  void _onTapSendDoc(String id) {
    AutoRouter.of(context).push(SendInvoiceEstimatePageRoute(
        params: GetDocumentUsecaseReqParams(
            pageType: EnumSendPageType.send,
            type: EnumDocumentType.estimate,
            id: id)));
  }

  void _loadInvoiceDetails(String id) {
    context.read<InvoiceBloc>().add(GetInvoiceDetails(
        invoiceDetailRequest: InvoiceDetailRequest(
            id: id, type: EnumNewInvoiceEstimateType.estimate)));
  }

  void _onTapConvertToInvoice(
      InvoiceEntity item, InvoiceDetailResEntity detailResEntity) {
    isIgnoreBlocStates = true;

    _openAddEstimateInvoicePage(detailResEntity, item,
        EnumNewInvoiceEstimateType.convertEstimateToInvoice);

    // AutoRouter.of(context).push(AddNewInvoiceEstimatePageRoute(
    //     invoiceDetailResEntity: detailResEntity,
    //     invoiceEntity: item,
    //     type: EnumNewInvoiceEstimateType.convertEstimateToInvoice,
    //     startObserveBlocBack: () {
    //       isIgnoreBlocStates = false;
    //     },
    //     refreshCallBack: () {
    //       isIgnoreBlocStates = false;
    //     }));
  }

  void _onTapDuplicate(
      InvoiceEntity item, InvoiceDetailResEntity detailResEntity) {
    isIgnoreBlocStates = true;

    _openAddEstimateInvoicePage(
        null, item, EnumNewInvoiceEstimateType.duplicateEstimate);

    // AutoRouter.of(context).push(AddNewInvoiceEstimatePageRoute(
    //     invoiceDetailResEntity: null,
    //     invoiceEntity: item,
    //     type: EnumNewInvoiceEstimateType.duplicateEstimate,
    //     startObserveBlocBack: () {
    //       isIgnoreBlocStates = false;
    //     },
    //     refreshCallBack: () {
    //       isIgnoreBlocStates = false;
    //     }));
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
      child: FutureBuilder(
        future: estimateTitle(),
        builder: (context, snapshot) {
          return ListCountHeader(
            controller: searchController,
            hintText: "Search ${snapshot.data ?? "Estimates"}",
            capsuleText: "${estimates.length} ${snapshot.data ?? "Estimates"}",
            onSubmitted: (val) {
              _loadEstimates();
            },
            dismissKeyboard: () {
              Utils.hideKeyboard();
            },
            onSelectedMenuItem: (val, displayName, startDate, endDate) {
              selectedAllTimes = val;
              allTimesDisplayName = displayName;

              startDateReqParams = startDate;
              endDateReqParams = endDate;

              showToastification(
                  context, "Selected ${val.title}", ToastificationType.info);

              _loadEstimates();
              setState(() {});
            },
          );
        },
      ),
    );
  }

  @override
  int numberOfItems(int section) {
    debugPrint("Estimate Length: ${estimates.length}");
    return isLoading ? 10 : estimates.length;
  }

  void _openAddEstimateInvoicePage(InvoiceDetailResEntity? detailResEntity,
      InvoiceEntity? item, EnumNewInvoiceEstimateType type) {
    AutoRouter.of(context).push(AddNewInvoiceEstimatePageRoute(
        invoiceDetailResEntity: detailResEntity,
        invoiceEntity: item,
        type: type,
        estimateTitle: estimateHeading,
        startObserveBlocBack: () {
          isIgnoreBlocStates = false;
        },
        refreshCallBack: () {
          isIgnoreBlocStates = false;
          _loadEstimates();
        }));

    // AutoRouter.of(context).push(AddNewInvoiceEstimatePageRoute(
    //     invoiceDetailResEntity: null,
    //     startObserveBlocBack: () {
    //       isIgnoreBlocStates = false;
    //     },
    //     type: EnumNewInvoiceEstimateType.estimate,
    //     refreshCallBack: () {
    //       isIgnoreBlocStates = false;
    //       _loadEstimates();
    //     }));
  }

  void _addNewEstimate() {
    isIgnoreBlocStates = true;
    _openAddEstimateInvoicePage(
        null, null, EnumNewInvoiceEstimateType.estimate);
  }

  @override
  void initState() {
    _setupScrollController();
    _loadEstimates();
    super.initState();
  }

  void _loadEstimates() {
    context.read<EstimateBloc>().add(GetEstimateListEvent(
            estimateListReqParams: EstimateListReqParams(
          query: searchController.text,
          status: selectedType.apiParams,
          columnName: "date",
          sortOrder: selectedOrderBy.apiParamsValue,
          page: currentPage.toString(),
          endDateStr: endDateReqParams,
          startDateStr: startDateReqParams,
        )));
  }

  Future<String> estimateTitle() async {
    estimateHeading = await Utils.getEstimate() ?? "Estimates";
    return estimateHeading;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder(
          future: estimateTitle(),
          initialData: "Estimates",
          builder: (context, snapshot) {
            return Text(snapshot.data ?? "Estimates");
          },
        ),
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(45),
            child: EstimateTypeHeaderWidget(
              selectedType: selectedType,
              callBack: (type) {
                selectedType = type;
                setState(() {});
                currentPage = 1;
                _loadEstimates();
              },
            )),
        actions: [
          IconButton(
              onPressed: () {
                AutoRouter.of(context).push(EstimateSortPageRoute(
                    callBack: (selectType, orderby, sortBy) {
                      selectedType = selectType;
                      selectedOrderBy = orderby;
                      selectedEstimateSortBy = sortBy;
                      setState(() {});
                      currentPage = 1;
                      _loadEstimates();
                    },
                    selectedEstimateSortBy: selectedEstimateSortBy,
                    selectedOrderBy: selectedOrderBy,
                    selectedType: selectedType));
              },
              icon: const Icon(
                Icons.filter_list_alt,
                color: AppPallete.blueColor,
              )),
          IconButton(
              onPressed: () {
                _addNewEstimate();
              },
              icon: const Icon(
                Icons.add,
                color: AppPallete.blueColor,
              ))
        ],
      ),
      body: BlocConsumer<EstimateBloc, EstimateState>(
        listener: (context, state) {
          if (state is EstimateListErrorState) {
            isFromPagination = false;
            showToastification(
                context, state.errorMessage, ToastificationType.error);
          }
          if (state is EstimateListSuccessState) {
            if (currentPage == 1) {
              estimates = [];
            }
            estimateListDataEntity = state.estimateListMainResEntity.data;
            final estimateList = estimateListDataEntity?.estimates ?? [];
            paging = state.estimateListMainResEntity.data?.paging;
            currentPage = paging?.currentpage ?? 0;
            isFromPagination = false;

            estimates.addAll(estimateList);
            isLoading = false;
          }
          if (state is EstimateListLoadingState) {
            if (!isFromPagination) isLoading = true;
          }
        },
        builder: (context, state) {
          if (state is EstimateListErrorState) {
            return showEmptyView();
          }
          if (state is EstimateListSuccessState) {
            final list = state.estimateListMainResEntity.data?.estimates ?? [];
            if (list.isEmpty) {
              return showEmptyView();
            }
          }
          return BlocConsumer<InvoiceBloc, InvoiceState>(
            listener: (context, state) {
              if (isIgnoreBlocStates) {
                return;
              }
              if (state is InvoiceDetailSuccessState) {
                final detailResEntity = state.invoiceDetailResEntity;
                final invoiceEntity = state.invoiceDetailResEntity.estimate;
                if (invoiceEntity != null) {
                  if (invoiceEstimateType ==
                      EnumNewInvoiceEstimateType.duplicateEstimate) {
                    _onTapDuplicate(invoiceEntity, detailResEntity);
                  } else if (invoiceEstimateType ==
                      EnumNewInvoiceEstimateType.convertEstimateToInvoice) {
                    _onTapConvertToInvoice(invoiceEntity, detailResEntity);
                  }
                } else {
                  debugPrint("Its null");
                }
              } else if (state is InvoiceDetailsFailureState) {
                debugPrint("Error occured: ${state.errorMessage}");
                showToastification(
                    context, state.errorMessage, ToastificationType.error);
              }
            },
            builder: (context, state) {
              if (!isIgnoreBlocStates && state is InvoiceDetailsLoadingState) {
                return const LoadingPage(title: "Loading estimate details...");
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
                        ),
                      ),
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
          );
        },
      ),
    );
  }

  Widget showEmptyView() {
    if (searchController.text.isNotEmpty) {
      return ListEmptySearchPage(
          searchText: searchController.text,
          callBack: () {
            searchController.text = "";
            _loadEstimates();
          });
    }
    return FutureBuilder<String>(
      future: estimateTitle(),
      builder: (context, snapshot) {
        String title = snapshot.data ?? "estimate";
        return ListEmptyPage(
            buttonTitle: "Add $title",
            noDataText: "No $title Records",
            noDataSubtitle: "",
            iconName: Icons.file_copy,
            callBack: () {
              _addNewEstimate();
            });
      },
    );
  }

  Future<void> _handleRefresh() async {
    currentPage = 1;
    _loadEstimates();
  }

  @override
  bool get wantKeepAlive => true;

  String get estimateCountText {
    final count = estimates.length;
    return "$count Estimates";
  }
}
