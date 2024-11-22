import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_section_list/flutter_section_list.dart';

import '../../../core/theme/app_fonts.dart';
import '../../../core/theme/app_pallete.dart';
import '../../../core/widgets/item_separator.dart';
import '../../more/expenses/presentation/widgets/expenses_sort_page.dart';
import 'invoice_list_page.dart';

@RoutePage()
class InvoiceSortPage extends StatefulWidget {
  final Function(EnumInvoiceType, EnumOrderBy, EnumInvoiceSortBy) callBack;
  final EnumInvoiceSortBy selectedInvoiceSortBy;
  final EnumOrderBy selectedOrderBy;
  final EnumInvoiceType selectedType;

  const InvoiceSortPage(
      {Key? key,
      required this.callBack,
      required this.selectedType,
      required this.selectedInvoiceSortBy,
      required this.selectedOrderBy})
      : super(key: key);

  @override
  State<InvoiceSortPage> createState() => _InvoiceSortPageState();
}

class _InvoiceSortPageState extends State<InvoiceSortPage>
    with SectionAdapterMixin {
  bool loadOnlyOnce = true;

  List<InvoiceSortBySectionModel> sortBySectionList = [
    InvoiceSortBySectionModel(
        sectionTitle: "Name",
        isShowSection: false,
        invoiceSortByModel: [
          InvoiceSortByModel(isSelected: false, type: EnumInvoiceSortBy.date),
          InvoiceSortByModel(isSelected: false, type: EnumInvoiceSortBy.number),
          InvoiceSortByModel(isSelected: false, type: EnumInvoiceSortBy.amount)
        ]),
    InvoiceSortBySectionModel(
      sectionTitle: "Order By",
      isShowSection: true,
      orderByList: [
        OrderByModel(isSelected: false, type: EnumOrderBy.ascending),
        OrderByModel(isSelected: false, type: EnumOrderBy.descending)
      ],
    ),
  ];

  // List<InvoiceFilterSectionModel> sortyByList = [
  //   InvoiceFilterSectionModel(
  //       sectionTitle: "Name",
  //       isShowSection: false,
  //       items: [
  //         InvoiceFilterItem(name: "Date", isSelected: true),
  //         InvoiceFilterItem(name: "Number", isSelected: false),
  //         InvoiceFilterItem(name: "Amount", isSelected: false),
  //       ]),
  //   InvoiceFilterSectionModel(
  //       sectionTitle: "ORDER BY",
  //       isShowSection: true,
  //       items: [
  //         InvoiceFilterItem(name: "Ascending", isSelected: true),
  //         InvoiceFilterItem(name: "Descending")
  //       ]),
  // ];

  List<InvoiceFilterSectionModel> filterBy = [
    InvoiceFilterSectionModel(
        sectionTitle: "Name",
        isShowSection: false,
        items: [
          InvoiceFilterItem(name: "All", type: EnumInvoiceType.all),
          InvoiceFilterItem(name: "Draft", type: EnumInvoiceType.draft),
          InvoiceFilterItem(name: "Unpaid", type: EnumInvoiceType.unpaid),
          InvoiceFilterItem(name: "Paid", type: EnumInvoiceType.paid),
          InvoiceFilterItem(
              name: "Partially Paid", type: EnumInvoiceType.partiallyPaid),
          InvoiceFilterItem(name: "Void", type: EnumInvoiceType.voidType),
          InvoiceFilterItem(name: "Recurring", type: EnumInvoiceType.recurring),
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

      sortBySectionList.first.invoiceSortByModel!.map((returnedItem) {
        if (returnedItem.type == widget.selectedInvoiceSortBy) {
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
    List<InvoiceFilterItem> items = filterBy.first.items;
    InvoiceFilterItem filterItem = items.firstWhere((item) {
      return item.isSelected == true;
    });

    List<InvoiceSortByModel> sortByItems =
        sortBySectionList.first.invoiceSortByModel!;
    InvoiceSortByModel sortByItem = sortByItems.firstWhere((item) {
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
        List<InvoiceSortByModel> expensesItemList =
            sortBySectionList[indexPath.section].invoiceSortByModel!;
        InvoiceSortByModel model = expensesItemList[indexPath.item];
        return (model.type.title, model.isSelected);
      } else {
        List<OrderByModel> orderByList =
            sortBySectionList[indexPath.section].orderByList!;
        OrderByModel model = orderByList[indexPath.item];
        return (model.type.title, model.isSelected);
      }
    } else {
      List<InvoiceFilterItem> filterItemList =
          filterBy[indexPath.section].items;
      InvoiceFilterItem item = filterItemList[indexPath.item];
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
            List<InvoiceSortByModel> expensesItemList =
                sortBySectionList[indexPath.section].invoiceSortByModel!;
            InvoiceSortByModel item = expensesItemList[indexPath.item];
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
          List<InvoiceFilterItem> filterItemList =
              filterBy[indexPath.section].items;
          InvoiceFilterItem item = filterItemList[indexPath.item];
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
        return sortBySectionList[section].invoiceSortByModel!.length;
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

enum EnumInvoiceSortBy { date, number, name, amount }

extension EnumInvoiceSortByExtension on EnumInvoiceSortBy {
  String get apiParams {
    switch (this) {
      case EnumInvoiceSortBy.date:
        return "date";
      case EnumInvoiceSortBy.number:
        return "number";
      case EnumInvoiceSortBy.name:
        return "name";
      case EnumInvoiceSortBy.amount:
        return "amount";
    }
  }

  String get title {
    switch (this) {
      case EnumInvoiceSortBy.date:
        return "Date";
      case EnumInvoiceSortBy.number:
        return "Number";
      case EnumInvoiceSortBy.name:
        return "Name";
      case EnumInvoiceSortBy.amount:
        return "Amount";
    }
  }
}

class InvoiceSortByModel {
  bool isSelected;
  EnumInvoiceSortBy type;
  InvoiceSortByModel({
    required this.isSelected,
    required this.type,
  });
}

class InvoiceSortBySectionModel {
  String sectionTitle;
  bool isShowSection;
  List<OrderByModel>? orderByList;
  List<InvoiceSortByModel>? invoiceSortByModel;

  InvoiceSortBySectionModel(
      {required this.sectionTitle,
      required this.isShowSection,
      this.orderByList,
      this.invoiceSortByModel});
}

class InvoiceFilterSectionModel {
  String sectionTitle;
  bool isShowSection;
  List<InvoiceFilterItem> items;

  InvoiceFilterSectionModel(
      {required this.sectionTitle,
      required this.isShowSection,
      required this.items});
}

class InvoiceFilterItem {
  String name;
  bool isSelected;
  EnumInvoiceType type;

  InvoiceFilterItem(
      {required this.name,
      this.isSelected = false,
      this.type = EnumInvoiceType.all});

  void togleSelectedState() {
    if (isSelected == false) isSelected = !isSelected;
  }
}
