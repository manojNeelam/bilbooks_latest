import 'package:auto_route/auto_route.dart';
import 'package:billbooks_app/core/app_constants.dart';
import 'package:billbooks_app/core/theme/app_pallete.dart';
import 'package:billbooks_app/core/utils/show_toast.dart';
import 'package:billbooks_app/core/utils/utils.dart';
import 'package:billbooks_app/features/clients/domain/entities/client_list_entity.dart';
import 'package:billbooks_app/features/invoice/domain/usecase/invoice_list_usecase.dart';
import 'package:billbooks_app/features/invoice/presentation/add_new_invoice_page.dart';
import 'package:billbooks_app/features/invoice/presentation/bloc/invoice_bloc.dart';
import 'package:billbooks_app/features/invoice/presentation/widgets/invoice_type_header_widget.dart';
import 'package:billbooks_app/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_section_list/flutter_section_list.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:toastification/toastification.dart';
import '../../../core/theme/app_fonts.dart';
import '../../../core/widgets/list_count_header_widget.dart';
import '../../../core/widgets/list_empty_page.dart';
import '../../../core/widgets/list_empty_search_page.dart';
import '../../../core/widgets/loading_page.dart';
import '../../more/expenses/presentation/widgets/expenses_sort_page.dart';
import '../domain/entities/invoice_details_entity.dart';
import '../domain/entities/invoice_list_entity.dart';
import '../domain/usecase/get_document_usecase.dart';
import '../domain/usecase/invoice_usecase.dart';
import 'invoice_sort_page.dart';
import 'send_invoice_estimate_page.dart';
import 'widgets/invoice_list_item.widget.dart';

enum EnumInvoiceSwipeOptions { payment, send, duplicate }

enum EnumInvoiceType {
  all,
  draft,
  unpaid,
  paid,
  partiallyPaid,
  voidType,
  recurring
}

extension EnumInvoiceTypeExtension on EnumInvoiceType {
  //draft, sent,  partial, paid, overdue, unpaid, recurring, billed, void
  String get apiParams {
    switch (this) {
      case EnumInvoiceType.all:
        return "";

      case EnumInvoiceType.draft:
        return "draft";

      case EnumInvoiceType.unpaid:
        return "unpaid";

      case EnumInvoiceType.paid:
        return "paid";

      case EnumInvoiceType.partiallyPaid:
        return "partial";

      case EnumInvoiceType.voidType:
        return "void";

      case EnumInvoiceType.recurring:
        return "recurring";
    }
  }

  String get title {
    switch (this) {
      case EnumInvoiceType.all:
        return "All";

      case EnumInvoiceType.draft:
        return "Draft";

      case EnumInvoiceType.unpaid:
        return "Unpaid";

      case EnumInvoiceType.paid:
        return "Paid";

      case EnumInvoiceType.partiallyPaid:
        return "Partially Paid";

      case EnumInvoiceType.voidType:
        return "Void";

      case EnumInvoiceType.recurring:
        return "Recurring";
    }
  }
}

// ignore: must_be_immutable
class InvoiceListPage extends StatefulWidget {
  const InvoiceListPage({super.key});

  @override
  State<InvoiceListPage> createState() => _InvoiceListPageState();
}

class _InvoiceListPageState extends State<InvoiceListPage>
    with SectionAdapterMixin, AutomaticKeepAliveClientMixin {
  bool isLoading = false;
  TextEditingController searchController = TextEditingController();

  EnumInvoiceType selectedType = EnumInvoiceType.all;
  EnumInvoiceSortBy selectedInvoiceSortBy = EnumInvoiceSortBy.date;
  EnumOrderBy selectedOrderBy = EnumOrderBy.ascending;
  List<InvoiceEntity> invoices = [];
  EnumAllTimes selectedAllTimes = EnumAllTimes.all;
  String allTimesDisplayName = EnumAllTimes.all.displayName.$3;
  bool isIgnoreBlocStates = false;
  EnumInvoiceSwipeOptions? enumInvoiceSwipeOptions;
  ScrollController _scrollController = ScrollController();
  Paging? paging;
  int currentPage = 1;
  bool isFromPagination = false;
  String? startDateReqParams;
  String? endDateReqParams;

  @override
  void initState() {
    _setupScrollController();
    _getInvoiceList();
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
        _getInvoiceList();
      }
    }
  }

  void _getInvoiceList() {
    context.read<InvoiceBloc>().add(GetInvoiceListEvent(
            params: InvoiceListReqParams(
          status: selectedType.apiParams,
          query: searchController.text,
          sortOrder: selectedOrderBy.apiParamsValue,
          columnName: selectedInvoiceSortBy.apiParams,
          page: currentPage.toString(),
          startDate: startDateReqParams,
          endDate: endDateReqParams,
        )));
  }

  @override
  Widget getItem(BuildContext context, IndexPath indexPath) {
    final item = isLoading
        ? InvoiceEntity()
        : invoices[indexPath.item]; //?? InvoiceEntity();
    return GestureDetector(
      child: SwipeActionCell(
        key: ObjectKey(item),
        trailingActions: [
          if (canShowPayments(item))
            SwipeAction(
                closeOnTap: true,
                style: AppFonts.regularStyle(color: AppPallete.white),
                title: "Payment",
                onTap: (CompletionHandler handler) async {
                  await handler(false);
                  if (item.id != null) {
                    enumInvoiceSwipeOptions = EnumInvoiceSwipeOptions.payment;
                    _loadInvoiceDetails(item.id ?? "");
                  }
                },
                color: AppPallete.greenColor),
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
                if (item.id != null) {
                  enumInvoiceSwipeOptions = EnumInvoiceSwipeOptions.duplicate;
                  _loadInvoiceDetails(item.id ?? "");
                }
              },
              color: AppPallete.borderColor),
        ],
        child: InvoiceListItemWidget(
          invoiceEntity: item,
        ),
      ),
      onTap: () {
        isIgnoreBlocStates = true;
        AutoRouter.of(context).push(InvoiceDetailPageRoute(
            invoiceEntity: item,
            type: EnumNewInvoiceEstimateType.invoice,
            startObserveBlocBack: () {
              isIgnoreBlocStates = false;
            },
            refreshList: () {
              isIgnoreBlocStates = false;
              _getInvoiceList();
            },
            estimateTitle: ''));
        // Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        //   return InvoiceDetailPage(
        //     invoiceEntity: item,
        //   );
        // }));
      },
    );
  }

  void _onTapSendDoc(String id) {
    AutoRouter.of(context).push(SendInvoiceEstimatePageRoute(
        params: GetDocumentUsecaseReqParams(
            pageType: EnumSendPageType.send,
            type: EnumDocumentType.invoice,
            id: id)));
  }

  void _loadInvoiceDetails(String id) {
    context.read<InvoiceBloc>().add(GetInvoiceDetails(
        invoiceDetailRequest: InvoiceDetailRequest(
            id: id, type: EnumNewInvoiceEstimateType.invoice)));
  }

  bool canShowPayments(InvoiceEntity invoiceEntity) {
    if (isSent(invoiceEntity) ||
        isPartial(invoiceEntity) ||
        isOverdue(invoiceEntity)) {
      return true;
    }
    return false;
  }

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

  bool isPartial(InvoiceEntity invoiceEntity) {
    final status = invoiceEntity.status ?? "";
    if (status.isNotEmpty && status.toLowerCase() == "partial") {
      return true;
    }
    return false;
  }

  bool isOverdue(InvoiceEntity invoiceEntity) {
    final status = invoiceEntity.status ?? "";
    if (status.isNotEmpty && status.toLowerCase() == "overdue") {
      return true;
    }
    return false;
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
        hintText: "Search Invoices",
        capsuleText: invoiceCountText,
        selectedMenuItem: selectedAllTimes,
        dismissKeyboard: () {
          Utils.hideKeyboard();
        },
        onSubmitted: (val) {
          _getInvoiceList();
        },
        onSelectedMenuItem: (val, displayName, startDate, endDate) {
          selectedAllTimes = val;
          allTimesDisplayName = displayName;
          //Call API

          startDateReqParams = startDate;
          endDateReqParams = endDate;

          showToastification(
              context, "Selected ${val.title}", ToastificationType.info);

          _getInvoiceList();
          setState(() {});
        },
      ),
    );
  }

  @override
  int numberOfItems(int section) {
    return isLoading == true ? 10 : invoices.length;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Invoices"),
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(45),
            child: InvoiceTypeHeaderWidget(
              selectedType: selectedType,
              callBack: (type) {
                selectedType = type;
                setState(() {});
                currentPage = 1;
                _getInvoiceList();
              },
            )),
        actions: [
          IconButton(
              onPressed: () {
                AutoRouter.of(context).push(InvoiceSortPageRoute(
                    callBack: (type, orderBy, sortBy) {
                      selectedType = type;
                      selectedOrderBy = orderBy;
                      selectedInvoiceSortBy = sortBy;
                      setState(() {});
                      currentPage = 1;
                      _getInvoiceList();
                    },
                    selectedType: selectedType,
                    selectedInvoiceSortBy: selectedInvoiceSortBy,
                    selectedOrderBy: selectedOrderBy));
              },
              icon: const Icon(
                Icons.filter_list_alt,
                color: AppPallete.blueColor,
              )),
          IconButton(
              onPressed: () {
                _showAddInvoice();
              },
              icon: const Icon(
                Icons.add,
                color: AppPallete.blueColor,
              ))
        ],
      ),
      body: BlocConsumer<InvoiceBloc, InvoiceState>(
        listener: (context, state) {
          if (isIgnoreBlocStates) {
            return;
          }

          if (state is InvoiceDetailSuccessState) {
            final detailResEntity = state.invoiceDetailResEntity;
            final invoiceEntity = state.invoiceDetailResEntity.invoice;
            if (invoiceEntity != null) {
              if (enumInvoiceSwipeOptions ==
                  EnumInvoiceSwipeOptions.duplicate) {
                _onTapDuplicate(invoiceEntity, detailResEntity);
              } else if (enumInvoiceSwipeOptions ==
                  EnumInvoiceSwipeOptions.payment) {
                _showAddPaymentPage(invoiceEntity);
              }
            } else {
              debugPrint("Its null");
            }
          } else if (state is InvoiceDetailsFailureState) {
            debugPrint("Error occured: ${state.errorMessage}");
            showToastification(
                context, state.errorMessage, ToastificationType.error);
          } else if (state is InvoiceListFailureState) {
            isFromPagination = false;
            showToastification(
                context, state.errorMessage, ToastificationType.error);
          }
        },
        builder: (context, state) {
          if (!isIgnoreBlocStates && state is InvoiceListFailureState) {
            return showEmptyView();
          }
          if (!isIgnoreBlocStates && state is InvoiceDetailsLoadingState) {
            return const LoadingPage(title: "Loading invoice details...");
          }

          if (!isIgnoreBlocStates && state is InvoiceListLoadingState) {
            if (!isFromPagination) isLoading = true;
          }
          if (!isIgnoreBlocStates && state is InvoiceListSuccessState) {
            if (currentPage == 1) {
              invoices = [];
            }
            final invoiceList = state.invoiceListMainResEntity.data?.invoices;
            paging = state.invoiceListMainResEntity.data?.paging;
            currentPage = paging?.currentpage ?? 0;
            isFromPagination = false;
            invoices.addAll(invoiceList ?? []);
            isLoading = false;

            if (invoices.isEmpty) {
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

  void _showAddPaymentPage(InvoiceEntity item) {
    isIgnoreBlocStates = true;
    AutoRouter.of(context).push(AddPaymentPageRoute(
        balanceAmount: item.balance ?? "",
        id: item.id ?? "",
        paymentEntity: null,
        emailList: item.emailtoClientstaff ?? [],
        startObserveBlocBack: () {
          isIgnoreBlocStates = false;
        },
        refreshPage: () {
          isIgnoreBlocStates = false;
          _getInvoiceList();
        }));
  }

  void _onTapDuplicate(
      InvoiceEntity item, InvoiceDetailResEntity detailResEntity) {
    isIgnoreBlocStates = true;
    AutoRouter.of(context).push(AddNewInvoiceEstimatePageRoute(
        invoiceDetailResEntity: null,
        invoiceEntity: item,
        type: EnumNewInvoiceEstimateType.duplicateInvoice,
        startObserveBlocBack: () {
          isIgnoreBlocStates = false;
        },
        refreshCallBack: () {
          isIgnoreBlocStates = false;
        }));
  }

  Future<void> _handleRefresh() async {
    currentPage = 1;
    _getInvoiceList();
  }

  void _showAddInvoice() {
    isIgnoreBlocStates = true;
    AutoRouter.of(context).push(AddNewInvoiceEstimatePageRoute(
        invoiceDetailResEntity: null,
        startObserveBlocBack: () {
          isIgnoreBlocStates = false;
        },
        type: EnumNewInvoiceEstimateType.invoice,
        refreshCallBack: () {
          isIgnoreBlocStates = false;
          _getInvoiceList();
        }));
  }

  Widget showEmptyView() {
    if (searchController.text.isNotEmpty) {
      return ListEmptySearchPage(
          searchText: searchController.text,
          callBack: () {
            searchController.text = "";
            _getInvoiceList();
          });
    }
    return ListEmptyPage(
        buttonTitle: "Add invoice",
        noDataText: "No Invoice Records",
        noDataSubtitle: "",
        iconName: Icons.file_copy,
        callBack: () {
          _showAddInvoice();
        });
  }

  @override
  bool get wantKeepAlive => true;

  String get invoiceCountText {
    final count = invoices.length;
    return "$count Invoices";
  }
}
