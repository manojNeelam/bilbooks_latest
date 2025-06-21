import 'package:auto_route/auto_route.dart';
import 'package:billbooks_app/core/theme/app_pallete.dart';
import 'package:billbooks_app/core/utils/utils.dart';
import 'package:billbooks_app/features/more/expenses/domain/usecase/expenses_list_usecase.dart';
import 'package:billbooks_app/features/more/expenses/presentation/bloc/expenses_bloc.dart';
import 'package:billbooks_app/features/more/expenses/presentation/widgets/expenses_sort_page.dart';
import 'package:billbooks_app/features/more/expenses/presentation/widgets/expenses_type_header_widget.dart';
import 'package:billbooks_app/features/more/expenses/presentation/widgets/new_expenses.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_section_list/flutter_section_list.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:toastification/toastification.dart';

import '../../../../../core/app_constants.dart';
import '../../../../../core/theme/app_fonts.dart';
import '../../../../../core/utils/show_toast.dart';
import '../../../../../core/widgets/list_count_header_widget.dart';
import '../../../../../core/widgets/list_empty_page.dart';
import '../../../../../core/widgets/list_empty_search_page.dart';
import '../../../../../router/app_router.dart';
import '../../../../clients/domain/entities/client_list_entity.dart';
import '../../domain/entities/expenses_list_entity.dart';
import 'expenses_list_item.widget.dart';

enum EnumExpensesType {
  all,
  unbilled,
  invoiced,
  billable,
  nonBillable,
  withReceipts,
  withoutReceipts,
  recurring
}

extension EnumExpensesTypeExtension on EnumExpensesType {
  String get apiParams {
    switch (this) {
      case EnumExpensesType.all:
        return "";

      case EnumExpensesType.unbilled:
        return "unbilled";

      case EnumExpensesType.invoiced:
        return "invoiced";

      case EnumExpensesType.billable:
        return "billable";

      case EnumExpensesType.nonBillable:
        return "non-billable";

      case EnumExpensesType.withReceipts:
        return "withreceipts";

      case EnumExpensesType.withoutReceipts:
        return "withoutreceipts";

      case EnumExpensesType.recurring:
        return "recurring";
    }
  }

  String get title {
    switch (this) {
      case EnumExpensesType.all:
        return "All";

      case EnumExpensesType.unbilled:
        return "Unbilled";

      case EnumExpensesType.invoiced:
        return "Invoiced";

      case EnumExpensesType.billable:
        return "Billable";

      case EnumExpensesType.nonBillable:
        return "Non-Billable";

      case EnumExpensesType.withReceipts:
        return "With Receipts";

      case EnumExpensesType.withoutReceipts:
        return "Without Receipts";

      case EnumExpensesType.recurring:
        return "Recurring";
    }
  }
}

// ignore: must_be_immutable
@RoutePage()
class ExpensesListPage extends StatefulWidget {
  const ExpensesListPage({super.key});

  @override
  State<ExpensesListPage> createState() => _ExpensesListPageState();
}

class _ExpensesListPageState extends State<ExpensesListPage>
    with SectionAdapterMixin {
  TextEditingController searchController = TextEditingController();

  EnumExpensesType selectedType = EnumExpensesType.all;
  EnumExpensesSortBy selectedExpenseSortBy = EnumExpensesSortBy.date;
  EnumOrderBy selectedOrderBy = EnumOrderBy.ascending;
  List<ExpenseEntity> expensesList = [];
  bool isLoading = false;
  EnumAllTimes selectedAllTimes = EnumAllTimes.all;
  String allTimesDisplayName = EnumAllTimes.all.displayName.$3;
  ScrollController _scrollController = ScrollController();
  Paging? paging;
  int currentPage = 1;
  bool isFromPagination = false;
  String? startDateReqParams;
  String? endDateReqParams;

  @override
  void initState() {
    _setupScrollController();
    _getExpensesList();
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
        _getExpensesList();
      }
    }
  }

  void _getExpensesList() {
    context.read<ExpensesBloc>().add(GetExpensesList(
            params: ExpensesListRequestParams(
          query: searchController.text,
          status: selectedType.apiParams,
          sortBy: selectedExpenseSortBy.apiParams,
          orderBy: selectedOrderBy.apiParamsValue,
          page: currentPage.toString(),
          endDate: endDateReqParams,
          startDate: startDateReqParams,
        )));
  }

  @override
  Widget getItem(BuildContext context, IndexPath indexPath) {
    final item = isLoading
        ? ExpenseEntity(
            clientName: "Client Name",
            amount: "1000",
            projectName: "Project Name",
            categoryName: "Test category name",
            vendor: "Test Vendor",
            refno: "123123",
            frequencyName: "Frequency Name",
            howmany: "123",
            dateYmd: DateTime.now(),
            status: "Non-Billable")
        : expensesList[indexPath.item];
    return GestureDetector(
      child: SwipeActionCell(
        key: ObjectKey(item),
        trailingActions: [
          SwipeAction(
              closeOnTap: true,
              style: AppFonts.regularStyle(color: AppPallete.white),
              title: "Duplicate",
              onTap: (CompletionHandler handler) async {
                await handler(false);
                _showAddExpenses(item, EnumExpenseScreenType.duplicate);
              },
              color: AppPallete.borderColor)
        ],
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ExpensesListItemWidget(
            expenseEntity: item,
          ),
        ),
      ),
      onTap: () {
        _showAddExpenses(item, EnumExpenseScreenType.edit);

        //AutoRouter.of(context).push(CategoryListPageRoute());

        // Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        //   return InvoiceDetailPage(); //edit
        // }));
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
          hintText: "Search Expenses",
          capsuleText: "${expensesList.length} Expenses",
          selectedMenuItem: selectedAllTimes,
          onSelectedMenuItem: (val, displayName, startDate, endDate) {
            selectedAllTimes = val;
            allTimesDisplayName = displayName;

            startDateReqParams = startDate;
            endDateReqParams = endDate;

            showToastification(
                context, "Selected ${val.title}", ToastificationType.info);

            setState(() {});

            _getExpensesList();
          },
          dismissKeyboard: () {
            Utils.hideKeyboard();
          },
          onSubmitted: (val) {
            _getExpensesList();
          }),
    );
  }

  @override
  int numberOfItems(int section) {
    return isLoading ? 10 : expensesList.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Expenses"),
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(45),
            child: ExpensesTypeHeaderWidget(
              selectedType: selectedType,
              callBack: (type) {
                selectedType = type;
                setState(() {});
                currentPage = 1;
                _getExpensesList();
              },
            )),
        actions: [
          IconButton(
              onPressed: () {
                AutoRouter.of(context).push(ExpensesSortPageRoute(
                    selectedType: selectedType,
                    selectedExpenseSortBy: selectedExpenseSortBy,
                    selectedOrderBy: selectedOrderBy,
                    callBack: (type, orderBy, expenses) {
                      selectedType = type;
                      selectedOrderBy = orderBy;
                      selectedExpenseSortBy = expenses;
                      setState(() {});
                      currentPage = 1;
                      _getExpensesList();
                    }));
              },
              icon: const Icon(
                Icons.filter_list_alt,
                color: AppPallete.blueColor,
              )),
          IconButton(
              onPressed: () {
                //

                _showAddExpenses(null, EnumExpenseScreenType.newExpense);

                // Navigator.of(context).push(MaterialPageRoute(
                //     builder: (context) => AddNewInvoicePage()));
              },
              icon: const Icon(
                Icons.add,
                color: AppPallete.blueColor,
              ))
        ],
      ),
      body: BlocConsumer<ExpensesBloc, ExpensesState>(
        listener: (context, state) {
          if (state is ExpensesListErrorState) {
            isFromPagination = false;
            showToastification(
                context, state.errorMessage, ToastificationType.error);
            isLoading = false;
          }
          if (state is ExpensesListLoadingState) {
            if (!isFromPagination) isLoading = true;
          }
        },
        builder: (context, state) {
          if (state is ExpensesListSuccessState) {
            if (currentPage == 1) {
              expensesList = [];
            }
            final list = state.expensesListMainResEntity.data?.expenses ?? [];
            paging = state.expensesListMainResEntity.data?.paging;
            currentPage = paging?.currentpage ?? 0;
            isFromPagination = false;
            expensesList.addAll(list);
            isLoading = false;

            if (expensesList.isEmpty) {
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
                      _getExpensesList();
                    });
              }

              if (searchController.text.isNotEmpty) {
                return _showNoSearchResultFound();
              }
              return _showEmptyView();
            }
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
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _handleRefresh() async {
    currentPage = 1;
    _getExpensesList();
  }

  Widget _showNoSearchResultFound() {
    return ListEmptySearchPage(
        searchText: searchController.text,
        callBack: () {
          searchController.text = "";
          _getExpensesList();
        });
  }

  Widget _showEmptyView() {
    return ListEmptyPage(
      buttonTitle: "Create new expense",
      noDataText: "No expenses yet?",
      iconName: Icons.people_alt_outlined,
      noDataSubtitle:
          "Having expenses like rent, electricity, travel can help you claim for a tax benefit. It's really easy to create expenses. Try it.",
      callBack: () {
        _showAddExpenses(null, EnumExpenseScreenType.newExpense);
      },
    );
  }

  void _showAddExpenses(ExpenseEntity? entity, EnumExpenseScreenType type) {
    AutoRouter.of(context).push(NewExpensesRoute(
        expenseScreenType: type,
        expenseEntity: entity,
        refreshPage: () {
          _getExpensesList();
        }));
  }
}
