import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_section_list/flutter_section_list.dart';

import '../../../core/theme/app_fonts.dart';
import '../../../core/theme/app_pallete.dart';
import '../../../core/widgets/item_separator.dart';
import '../../more/expenses/presentation/widgets/expenses_sort_page.dart';

@RoutePage()
class ProjectSortPage extends StatefulWidget {
  final Function(EnumProjectType, EnumOrderBy, EnumProjectSortBy) callBack;
  final EnumProjectSortBy selectedProjectSortBy;
  final EnumOrderBy selectedOrderBy;
  final EnumProjectType selectedType;
  const ProjectSortPage(
      {super.key,
      required this.callBack,
      required this.selectedOrderBy,
      required this.selectedProjectSortBy,
      required this.selectedType});

  @override
  State<ProjectSortPage> createState() => _ProjectSortPageState();
}

class _ProjectSortPageState extends State<ProjectSortPage>
    with SectionAdapterMixin {
  bool loadOnlyOnce = true;

  List<ProjectSortBySectionModel> sortBySectionList = [
    ProjectSortBySectionModel(
        sectionTitle: "Name",
        isShowSection: false,
        invoiceSortByModel: [
          ProjectSortByModel(isSelected: false, type: EnumProjectSortBy.name),
        ]),
    ProjectSortBySectionModel(
      sectionTitle: "Order By",
      isShowSection: true,
      orderByList: [
        OrderByModel(isSelected: false, type: EnumOrderBy.ascending),
        OrderByModel(isSelected: false, type: EnumOrderBy.descending)
      ],
    ),
  ];

  List<ProjectFilterSectionModel> filterBy = [
    ProjectFilterSectionModel(
        sectionTitle: "Name",
        isShowSection: false,
        items: [
          ProjectFilterItem(type: EnumProjectType.all),
          ProjectFilterItem(type: EnumProjectType.active),
          ProjectFilterItem(type: EnumProjectType.inactive),
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
        if (returnedItem.type == widget.selectedProjectSortBy) {
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
    List<ProjectFilterItem> items = filterBy.first.items;
    ProjectFilterItem filterItem = items.firstWhere((item) {
      return item.isSelected == true;
    });

    List<ProjectSortByModel> sortByItems =
        sortBySectionList.first.invoiceSortByModel!;
    ProjectSortByModel sortByItem = sortByItems.firstWhere((item) {
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
        List<ProjectSortByModel> expensesItemList =
            sortBySectionList[indexPath.section].invoiceSortByModel!;
        ProjectSortByModel model = expensesItemList[indexPath.item];
        return (model.type.title, model.isSelected);
      } else {
        List<OrderByModel> orderByList =
            sortBySectionList[indexPath.section].orderByList!;
        OrderByModel model = orderByList[indexPath.item];
        return (model.type.title, model.isSelected);
      }
    } else {
      List<ProjectFilterItem> filterItemList =
          filterBy[indexPath.section].items;
      ProjectFilterItem item = filterItemList[indexPath.item];
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
            List<ProjectSortByModel> expensesItemList =
                sortBySectionList[indexPath.section].invoiceSortByModel!;
            ProjectSortByModel item = expensesItemList[indexPath.item];
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
          List<ProjectFilterItem> filterItemList =
              filterBy[indexPath.section].items;
          ProjectFilterItem item = filterItemList[indexPath.item];
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

enum EnumProjectSortBy { name }

extension EnumInvoiceSortByExtension on EnumProjectSortBy {
  String get title {
    switch (this) {
      case EnumProjectSortBy.name:
        return "Name";
    }
  }

  String get apiParamsValue {
    switch (this) {
      case EnumProjectSortBy.name:
        return "name";
    }
  }
}

class ProjectSortByModel {
  bool isSelected;
  EnumProjectSortBy type;
  ProjectSortByModel({
    required this.isSelected,
    required this.type,
  });
}

class ProjectSortBySectionModel {
  String sectionTitle;
  bool isShowSection;
  List<OrderByModel>? orderByList;
  List<ProjectSortByModel>? invoiceSortByModel;

  ProjectSortBySectionModel(
      {required this.sectionTitle,
      required this.isShowSection,
      this.orderByList,
      this.invoiceSortByModel});
}

class ProjectFilterSectionModel {
  String sectionTitle;
  bool isShowSection;
  List<ProjectFilterItem> items;

  ProjectFilterSectionModel(
      {required this.sectionTitle,
      required this.isShowSection,
      required this.items});
}

class ProjectFilterItem {
  bool isSelected;
  EnumProjectType type;

  ProjectFilterItem({this.isSelected = false, this.type = EnumProjectType.all});

  void togleSelectedState() {
    if (isSelected == false) isSelected = !isSelected;
  }
}

enum EnumProjectType { all, active, inactive }

extension EnumProjectTypeExtension on EnumProjectType {
  String get title {
    switch (this) {
      case EnumProjectType.all:
        return "All";

      case EnumProjectType.active:
        return "Active";

      case EnumProjectType.inactive:
        return "Inactive";
    }
  }
}
