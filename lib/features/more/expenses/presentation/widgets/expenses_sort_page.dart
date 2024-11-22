// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_route/auto_route.dart';
import 'package:billbooks_app/features/more/expenses/presentation/widgets/expenses_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_section_list/flutter_section_list.dart';

import 'package:billbooks_app/core/theme/app_fonts.dart';
import 'package:billbooks_app/core/theme/app_pallete.dart';
import 'package:billbooks_app/core/widgets/item_separator.dart';

@RoutePage()
class ExpensesSortPage extends StatefulWidget {
  final Function(EnumExpensesType, EnumOrderBy, EnumExpensesSortBy) callBack;
  final EnumExpensesSortBy selectedExpenseSortBy;
  final EnumOrderBy selectedOrderBy;
  final EnumExpensesType selectedType;

  const ExpensesSortPage(
      {Key? key,
      required this.callBack,
      required this.selectedType,
      required this.selectedExpenseSortBy,
      required this.selectedOrderBy})
      : super(key: key);

  @override
  State<ExpensesSortPage> createState() => _ExpensesSortPageState();
}

class _ExpensesSortPageState extends State<ExpensesSortPage>
    with SectionAdapterMixin {
  bool loadOnlyOnce = true;

  List<ExpensesSortBySectionModel> sortBySectionList = [
    ExpensesSortBySectionModel(
        sectionTitle: "Name",
        isShowSection: false,
        expensesSortByModel: [
          ExpensesSortByModel(isSelected: false, type: EnumExpensesSortBy.date),
          ExpensesSortByModel(isSelected: false, type: EnumExpensesSortBy.name),
          ExpensesSortByModel(
              isSelected: false, type: EnumExpensesSortBy.amount)
        ]),
    ExpensesSortBySectionModel(
      sectionTitle: "Order By",
      isShowSection: true,
      orderByList: [
        OrderByModel(isSelected: false, type: EnumOrderBy.ascending),
        OrderByModel(isSelected: false, type: EnumOrderBy.descending)
      ],
    ),
  ];

  // List<ExpensestFilterSectionModel> sortyByList = [
  //   ExpensestFilterSectionModel(
  //       sectionTitle: "Name",
  //       isShowSection: false,
  //       items: [
  //         ExpensesFilterItem(name: "Date", isSelected: true),
  //         ExpensesFilterItem(name: "Number", isSelected: false),
  //         ExpensesFilterItem(name: "Amount", isSelected: false),
  //       ]),
  //   ExpensestFilterSectionModel(
  //       sectionTitle: "ORDER BY",
  //       isShowSection: true,
  //       items: [
  //         ExpensesFilterItem(name: "Ascending", isSelected: true),
  //         ExpensesFilterItem(name: "Descending")
  //       ]),
  // ];

  List<ExpensestFilterSectionModel> filterBy = [
    ExpensestFilterSectionModel(
        sectionTitle: "Name",
        isShowSection: false,
        items: [
          ExpensesFilterItem(name: "All", type: EnumExpensesType.all),
          ExpensesFilterItem(name: "Unbilled", type: EnumExpensesType.unbilled),
          ExpensesFilterItem(name: "Invoiced", type: EnumExpensesType.invoiced),
          ExpensesFilterItem(name: "Billable", type: EnumExpensesType.billable),
          ExpensesFilterItem(
              name: "Non-Billable", type: EnumExpensesType.nonBillable),
          ExpensesFilterItem(
              name: "With Receipts", type: EnumExpensesType.withReceipts),
          ExpensesFilterItem(
              name: "Without Receipts", type: EnumExpensesType.withoutReceipts),
          ExpensesFilterItem(
              name: "Recurring", type: EnumExpensesType.recurring),
        ]),
  ];

  List<Widget> filters = <Widget>[
    const Text('Filter By'),
    const Text('Sort By'),
  ];
  final List<bool> _selectedfilters = <bool>[true, false];

  @override
  void initState() {
    if (loadOnlyOnce) {
      loadOnlyOnce = false;
      filterBy.first.items.map((returnedItem) {
        if (returnedItem.type == widget.selectedType) {
          returnedItem.isSelected = true;
        }
      }).toList();

      sortBySectionList.first.expensesSortByModel!.map((returnedItem) {
        if (returnedItem.type == widget.selectedExpenseSortBy) {
          returnedItem.isSelected = true;
        }
      }).toList();

      sortBySectionList.last.orderByList!.map((returnedItem) {
        if (returnedItem.type == widget.selectedOrderBy) {
          returnedItem.isSelected = true;
        }
      }).toList();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("build(BuildCo");

    return Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
                onPressed: () {
                  getSelectedFilterBy();
                },
                child: Text(
                  "Apply",
                  style: AppFonts.regularStyle(color: AppPallete.blueColor),
                ))
          ],
          title: const Text(
            "Sort & Filter",
          ),
          leading: IconButton(
              onPressed: () {
                AutoRouter.of(context).maybePop();
              },
              icon: const Icon(
                Icons.close,
                color: AppPallete.blueColor,
              )),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: SizedBox(
              height: 50,
              child: Column(
                children: [
                  ToggleButtons(
                    direction: Axis.horizontal,
                    onPressed: (int index) {
                      setState(() {
                        // The button that is tapped is set to true, and the others to false.
                        for (int i = 0; i < _selectedfilters.length; i++) {
                          _selectedfilters[i] = i == index;
                        }
                      });
                    },
                    borderRadius: const BorderRadius.all(Radius.circular(3)),
                    selectedBorderColor: AppPallete.lightBlueColor,
                    selectedColor: AppPallete.textColor,
                    fillColor: AppPallete.lightBlueColor,
                    color: AppPallete.textColor,
                    constraints: const BoxConstraints(
                      minHeight: 35,
                      minWidth: 100.0,
                    ),
                    isSelected: _selectedfilters,
                    children: filters,
                  ),
                  const ItemSeparator()
                ],
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
          child: SectionListView.builder(adapter: this),
        ));
  }

  int getSelectedIndex() {
    int index = _selectedfilters.indexWhere((filter) {
      return filter == true;
    });
    return index;
  }

  bool isSelectedSortBy() {
    int index = getSelectedIndex();
    if (index == 1) {
      return true;
    }
    return false;
  }

  @override
  int numberOfSections() {
    return isSelectedSortBy() ? sortBySectionList.length : filterBy.length;
  }

  void getSelectedFilterBy() {
    List<ExpensesFilterItem> items = filterBy.first.items;
    ExpensesFilterItem filterItem = items.firstWhere((item) {
      return item.isSelected == true;
    });

    List<ExpensesSortByModel> sortByItems =
        sortBySectionList.first.expensesSortByModel!;
    ExpensesSortByModel sortByItem = sortByItems.firstWhere((item) {
      return item.isSelected == true;
    });

    List<OrderByModel> orderByItems = sortBySectionList.last.orderByList!;
    OrderByModel orderByItem = orderByItems.firstWhere((item) {
      return item.isSelected == true;
    });

    //debugPrint(filterItem.name);
    debugPrint(filterItem.type.title);
    widget.callBack(filterItem.type, orderByItem.type, sortByItem.type);
    AutoRouter.of(context).maybePop();
  }

  (String, bool) getTitleandSelectedState(IndexPath indexPath) {
    if (isSelectedSortBy()) {
      if (indexPath.section == 0) {
        List<ExpensesSortByModel> expensesItemList =
            sortBySectionList[indexPath.section].expensesSortByModel!;
        ExpensesSortByModel model = expensesItemList[indexPath.item];
        return (model.type.title, model.isSelected);
      } else {
        List<OrderByModel> orderByList =
            sortBySectionList[indexPath.section].orderByList!;
        OrderByModel model = orderByList[indexPath.item];
        return (model.type.title, model.isSelected);
      }
    } else {
      List<ExpensesFilterItem> filterItemList =
          filterBy[indexPath.section].items;
      ExpensesFilterItem item = filterItemList[indexPath.item];
      return (item.name, item.isSelected);
    }
  }

  @override
  Widget getItem(BuildContext context, IndexPath indexPath) {
    final ss = getTitleandSelectedState(indexPath);
    String name = ss.$1;
    bool isSelected = ss.$2;

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        if (isSelectedSortBy()) {
          if (indexPath.section == 0) {
            List<ExpensesSortByModel> expensesItemList =
                sortBySectionList[indexPath.section].expensesSortByModel!;
            ExpensesSortByModel item = expensesItemList[indexPath.item];
            if (item.isSelected == false) {
              expensesItemList.map((returnedItem) {
                if (returnedItem.type.name == item.type.name) {
                  item.isSelected = true;
                } else {
                  returnedItem.isSelected = false;
                }
              }).toList();
            }
            setState(() {});
          } else {
            List<OrderByModel> orderByList =
                sortBySectionList[indexPath.section].orderByList!;
            OrderByModel item = orderByList[indexPath.item];
            if (item.isSelected == false) {
              orderByList.map((returnedItem) {
                if (returnedItem.type.name == item.type.name) {
                  item.isSelected = true;
                } else {
                  returnedItem.isSelected = false;
                }
              }).toList();
            }
            setState(() {});
          }
        } else {
          List<ExpensesFilterItem> filterItemList =
              filterBy[indexPath.section].items;
          ExpensesFilterItem item = filterItemList[indexPath.item];
          if (item.isSelected == false) {
            filterItemList.map((returnedItem) {
              if (returnedItem.name == item.name) {
                item.isSelected = true;
              } else {
                returnedItem.isSelected = false;
              }
            }).toList();
          }
          setState(() {});
        }
        setState(() {});
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  name,
                  textAlign: TextAlign.start,
                  style: AppFonts.regularStyle(),
                ),
              ),
              if (isSelected)
                const Icon(
                  Icons.check,
                  color: AppPallete.blueColor,
                )
            ],
          ),
          const ItemSeparator(),
        ],
      ),
    );
  }

  @override
  int numberOfItems(int section) {
    if (isSelectedSortBy()) {
      if (section == 0) {
        return sortBySectionList[section].expensesSortByModel!.length;
      } else {
        return sortBySectionList[section].orderByList!.length;
      }
    } else {
      return filterBy[section].items.length;
    }
    // return isSelectedSortBy()
    //     ? sortBySectionList[section].orderByList.length
    //     :
  }

  @override
  bool shouldExistSectionHeader(int section) {
    return isSelectedSortBy()
        ? sortBySectionList[section].isShowSection
        : filterBy[section].isShowSection;
  }

  @override
  Widget getSectionHeader(BuildContext context, int section) {
    String title = isSelectedSortBy()
        ? sortBySectionList[section].sectionTitle
        : filterBy[section].sectionTitle;
    return Container(
      padding: const EdgeInsets.only(top: 30, bottom: 0, left: 0, right: 0),
      child: Text(
        title,
        style: AppFonts.regularStyle(color: AppPallete.k666666, size: 12),
      ),
    );
  }
}

enum EnumExpensesSortBy { date, name, amount }

extension EnumExpensesSortByExtension on EnumExpensesSortBy {
  String get title {
    switch (this) {
      case EnumExpensesSortBy.date:
        return "Date";

      case EnumExpensesSortBy.name:
        return "Name";
      case EnumExpensesSortBy.amount:
        return "Amount";
    }
  }

  String get apiParams {
    switch (this) {
      case EnumExpensesSortBy.date:
        return "date";

      case EnumExpensesSortBy.name:
        return "name";
      case EnumExpensesSortBy.amount:
        return "amount";
    }
  }
}

enum EnumOrderBy { ascending, descending }

extension EnumOrderByExtension on EnumOrderBy {
  String get title {
    switch (this) {
      case EnumOrderBy.ascending:
        return "Ascending";
      case EnumOrderBy.descending:
        return "Descending";
    }
  }

  String get apiParamsValue {
    switch (this) {
      case EnumOrderBy.ascending:
        return "ASC";
      case EnumOrderBy.descending:
        return "DESC";
    }
  }
}

class ExpensesSortByModel {
  bool isSelected;
  EnumExpensesSortBy type;
  ExpensesSortByModel({
    required this.isSelected,
    required this.type,
  });
}

class OrderByModel {
  bool isSelected;
  EnumOrderBy type;
  OrderByModel({required this.isSelected, required this.type});
}

class ExpensesSortBySectionModel {
  String sectionTitle;
  bool isShowSection;
  List<OrderByModel>? orderByList;
  List<ExpensesSortByModel>? expensesSortByModel;

  ExpensesSortBySectionModel(
      {required this.sectionTitle,
      required this.isShowSection,
      this.orderByList,
      this.expensesSortByModel});
}

class ExpensestFilterSectionModel {
  String sectionTitle;
  bool isShowSection;
  List<ExpensesFilterItem> items;

  ExpensestFilterSectionModel(
      {required this.sectionTitle,
      required this.isShowSection,
      required this.items});
}

class ExpensesFilterItem {
  String name;
  bool isSelected;
  EnumExpensesType type;

  ExpensesFilterItem(
      {required this.name,
      this.isSelected = false,
      this.type = EnumExpensesType.all});

  void togleSelectedState() {
    if (isSelected == false) isSelected = !isSelected;
  }
}
