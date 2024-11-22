import 'package:auto_route/auto_route.dart';
import 'package:billbooks_app/features/item/presentation/item_list.dart';
import 'package:billbooks_app/features/more/expenses/presentation/widgets/expenses_sort_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_section_list/flutter_section_list.dart';

import '../../../core/theme/app_fonts.dart';
import '../../../core/theme/app_pallete.dart';
import '../../../core/widgets/item_separator.dart';

@RoutePage()
class ItemSortPage extends StatefulWidget {
  final Function(EnumItemType, EnumOrderBy, EnumItemSortBy) callBack;
  final EnumItemSortBy selectedItemSortBy;
  final EnumOrderBy selectedOrderBy;
  final EnumItemType selectedType;
  const ItemSortPage(
      {super.key,
      required this.callBack,
      required this.selectedItemSortBy,
      required this.selectedOrderBy,
      required this.selectedType});

  @override
  State<ItemSortPage> createState() => _ItemSortPageState();
}

class _ItemSortPageState extends State<ItemSortPage> with SectionAdapterMixin {
  bool loadOnlyOnce = true;

  List<ItemSortBySectionModel> sortBySectionList = [
    ItemSortBySectionModel(
        sectionTitle: "Name",
        isShowSection: false,
        invoiceSortByModel: [
          ItemSortByModel(isSelected: false, type: EnumItemSortBy.name),
          ItemSortByModel(isSelected: false, type: EnumItemSortBy.sku),
        ]),
    ItemSortBySectionModel(
      sectionTitle: "Order By",
      isShowSection: true,
      orderByList: [
        OrderByModel(isSelected: false, type: EnumOrderBy.ascending),
        OrderByModel(isSelected: false, type: EnumOrderBy.descending)
      ],
    ),
  ];

  List<ItemFilterSectionModel> filterBy = [
    ItemFilterSectionModel(sectionTitle: "Name", isShowSection: false, items: [
      ItemFilterItem(type: EnumItemType.all),
      ItemFilterItem(type: EnumItemType.active),
      ItemFilterItem(type: EnumItemType.inActive),
      ItemFilterItem(type: EnumItemType.services),
      ItemFilterItem(type: EnumItemType.inventory),
      ItemFilterItem(type: EnumItemType.nonInventory),
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
        if (returnedItem.type == widget.selectedItemSortBy) {
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
    List<ItemFilterItem> items = filterBy.first.items;
    ItemFilterItem filterItem = items.firstWhere((item) {
      return item.isSelected == true;
    });

    List<ItemSortByModel> sortByItems =
        sortBySectionList.first.invoiceSortByModel!;
    ItemSortByModel sortByItem = sortByItems.firstWhere((item) {
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
        List<ItemSortByModel> expensesItemList =
            sortBySectionList[indexPath.section].invoiceSortByModel!;
        ItemSortByModel model = expensesItemList[indexPath.item];
        return (model.type.title, model.isSelected);
      } else {
        List<OrderByModel> orderByList =
            sortBySectionList[indexPath.section].orderByList!;
        OrderByModel model = orderByList[indexPath.item];
        return (model.type.title, model.isSelected);
      }
    } else {
      List<ItemFilterItem> filterItemList = filterBy[indexPath.section].items;
      ItemFilterItem item = filterItemList[indexPath.item];
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
            List<ItemSortByModel> itemItemList =
                sortBySectionList[indexPath.section].invoiceSortByModel!;
            ItemSortByModel item = itemItemList[indexPath.item];
            if (item.isSelected == false) {
              itemItemList.map((returnedItem) {
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
          List<ItemFilterItem> filterItemList =
              filterBy[indexPath.section].items;
          ItemFilterItem item = filterItemList[indexPath.item];
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

enum EnumItemSortBy { name, sku }

extension EnumInvoiceSortByExtension on EnumItemSortBy {
  String get title {
    switch (this) {
      case EnumItemSortBy.name:
        return "Name";
      case EnumItemSortBy.sku:
        return "SKU";
    }
  }

  String get apiValue {
    switch (this) {
      case EnumItemSortBy.name:
        return "name";
      case EnumItemSortBy.sku:
        return "sku";
    }
  }
}

class ItemSortByModel {
  bool isSelected;
  EnumItemSortBy type;
  ItemSortByModel({
    required this.isSelected,
    required this.type,
  });
}

class ItemSortBySectionModel {
  String sectionTitle;
  bool isShowSection;
  List<OrderByModel>? orderByList;
  List<ItemSortByModel>? invoiceSortByModel;

  ItemSortBySectionModel(
      {required this.sectionTitle,
      required this.isShowSection,
      this.orderByList,
      this.invoiceSortByModel});
}

class ItemFilterSectionModel {
  String sectionTitle;
  bool isShowSection;
  List<ItemFilterItem> items;

  ItemFilterSectionModel(
      {required this.sectionTitle,
      required this.isShowSection,
      required this.items});
}

class ItemFilterItem {
  bool isSelected;
  EnumItemType type;

  ItemFilterItem({this.isSelected = false, this.type = EnumItemType.all});

  void togleSelectedState() {
    if (isSelected == false) isSelected = !isSelected;
  }
}
