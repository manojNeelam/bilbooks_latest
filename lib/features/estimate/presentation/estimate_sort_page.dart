import 'package:auto_route/auto_route.dart';
import 'package:billbooks_app/features/estimate/presentation/estimate_list_page.dart';
import 'package:billbooks_app/features/more/expenses/presentation/widgets/expenses_sort_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_section_list/flutter_section_list.dart';

import '../../../core/theme/app_fonts.dart';
import '../../../core/theme/app_pallete.dart';
import '../../../core/widgets/item_separator.dart';

enum EnumEstimateSortBy { date, number, name, amount }

extension EnumInvoiceSortByExtension on EnumEstimateSortBy {
  String get title {
    switch (this) {
      case EnumEstimateSortBy.date:
        return "Date";
      case EnumEstimateSortBy.number:
        return "Number";
      case EnumEstimateSortBy.name:
        return "Name";
      case EnumEstimateSortBy.amount:
        return "Amount";
    }
  }
}

@RoutePage()
class EstimateSortPage extends StatefulWidget {
  final Function(EnumEstimateType, EnumOrderBy, EnumEstimateSortBy) callBack;
  final EnumEstimateSortBy selectedEstimateSortBy;
  final EnumOrderBy selectedOrderBy;
  final EnumEstimateType selectedType;

  const EstimateSortPage(
      {super.key,
      required this.callBack,
      required this.selectedEstimateSortBy,
      required this.selectedOrderBy,
      required this.selectedType});

  @override
  State<EstimateSortPage> createState() => _EstimateSortPageState();
}

class _EstimateSortPageState extends State<EstimateSortPage>
    with SectionAdapterMixin {
  bool loadOnlyOnce = true;

  List<EstimateSortBySectionModel> sortBySectionList = [
    EstimateSortBySectionModel(
        sectionTitle: "Name",
        isShowSection: false,
        estimateSortByModel: [
          EstimateSortByModel(isSelected: false, type: EnumEstimateSortBy.date),
          EstimateSortByModel(
              isSelected: false, type: EnumEstimateSortBy.number),
          EstimateSortByModel(isSelected: false, type: EnumEstimateSortBy.name),
          EstimateSortByModel(
              isSelected: false, type: EnumEstimateSortBy.amount)
        ]),
    EstimateSortBySectionModel(
      sectionTitle: "Order By",
      isShowSection: true,
      orderByList: [
        OrderByModel(isSelected: false, type: EnumOrderBy.ascending),
        OrderByModel(isSelected: false, type: EnumOrderBy.descending)
      ],
    ),
  ];

  List<EstimateFilterSectionModel> filterBy = [
    EstimateFilterSectionModel(
        sectionTitle: "Name",
        isShowSection: false,
        items: [
          EstimateFilterItem(type: EnumEstimateType.all),
          EstimateFilterItem(type: EnumEstimateType.draft),
          EstimateFilterItem(type: EnumEstimateType.sent),
          EstimateFilterItem(type: EnumEstimateType.approved),
          EstimateFilterItem(type: EnumEstimateType.invoiced),
          EstimateFilterItem(type: EnumEstimateType.declined),
          EstimateFilterItem(type: EnumEstimateType.expired),
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

      sortBySectionList.first.estimateSortByModel!.map((returnedItem) {
        if (returnedItem.type == widget.selectedEstimateSortBy) {
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
    List<EstimateFilterItem> items = filterBy.first.items;
    EstimateFilterItem filterItem = items.firstWhere((item) {
      return item.isSelected == true;
    });

    List<EstimateSortByModel> sortByItems =
        sortBySectionList.first.estimateSortByModel!;
    EstimateSortByModel sortByItem = sortByItems.firstWhere((item) {
      return item.isSelected == true;
    });

    List<OrderByModel> orderByItems = sortBySectionList.last.orderByList!;
    OrderByModel orderByItem = orderByItems.firstWhere((item) {
      return item.isSelected == true;
    });

    //debugPrint(filterItem.name);
    debugPrint(filterItem.type.title);
    debugPrint(orderByItem.type.title);
    debugPrint(sortByItem.type.title);

    widget.callBack(filterItem.type, orderByItem.type, sortByItem.type);
    AutoRouter.of(context).maybePop();
  }

  (String, bool) getTitleandSelectedState(IndexPath indexPath) {
    if (isSelectedSortBy()) {
      if (indexPath.section == 0) {
        List<EstimateSortByModel> expensesItemList =
            sortBySectionList[indexPath.section].estimateSortByModel!;
        EstimateSortByModel model = expensesItemList[indexPath.item];
        return (model.type.title, model.isSelected);
      } else {
        List<OrderByModel> orderByList =
            sortBySectionList[indexPath.section].orderByList!;
        OrderByModel model = orderByList[indexPath.item];
        return (model.type.title, model.isSelected);
      }
    } else {
      List<EstimateFilterItem> filterItemList =
          filterBy[indexPath.section].items;
      EstimateFilterItem item = filterItemList[indexPath.item];
      return (item.type.title, item.isSelected);
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
            List<EstimateSortByModel> expensesItemList =
                sortBySectionList[indexPath.section].estimateSortByModel!;
            EstimateSortByModel item = expensesItemList[indexPath.item];
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
          List<EstimateFilterItem> filterItemList =
              filterBy[indexPath.section].items;
          EstimateFilterItem item = filterItemList[indexPath.item];
          if (item.isSelected == false) {
            filterItemList.map((returnedItem) {
              if (returnedItem.type.title == item.type.title) {
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
        return sortBySectionList[section].estimateSortByModel!.length;
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
}

class EstimateSortByModel {
  bool isSelected;
  EnumEstimateSortBy type;
  EstimateSortByModel({
    required this.isSelected,
    required this.type,
  });
}

class EstimateSortBySectionModel {
  String sectionTitle;
  bool isShowSection;
  List<OrderByModel>? orderByList;
  List<EstimateSortByModel>? estimateSortByModel;

  EstimateSortBySectionModel(
      {required this.sectionTitle,
      required this.isShowSection,
      this.orderByList,
      this.estimateSortByModel});
}

class EstimateFilterSectionModel {
  String sectionTitle;
  bool isShowSection;
  List<EstimateFilterItem> items;

  EstimateFilterSectionModel(
      {required this.sectionTitle,
      required this.isShowSection,
      required this.items});
}

class EstimateFilterItem {
  bool isSelected;
  EnumEstimateType type;

  EstimateFilterItem(
      {this.isSelected = false, this.type = EnumEstimateType.all});

  void togleSelectedState() {
    if (isSelected == false) isSelected = !isSelected;
  }
}
