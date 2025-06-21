import 'package:auto_route/auto_route.dart';
import 'package:billbooks_app/core/theme/app_pallete.dart';
import 'package:billbooks_app/core/utils/show_toast.dart';
import 'package:billbooks_app/core/widgets/loading_page.dart';
import 'package:billbooks_app/core/widgets/searchbar_widget.dart';
import 'package:billbooks_app/features/item/domain/entities/item_list_entity.dart';
import 'package:billbooks_app/features/item/presentation/bloc/item_bloc.dart';
import 'package:billbooks_app/features/item/presentation/item_sort_page.dart';
import 'package:billbooks_app/features/item/presentation/widgets/item_type_header_widget.dart';
import 'package:billbooks_app/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_section_list/flutter_section_list.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:toastification/toastification.dart';
import '../../../core/app_constants.dart';
import '../../../core/theme/app_fonts.dart';
import '../../../core/utils/utils.dart';
import '../../../core/widgets/app_alert_widget.dart';
import '../../../core/widgets/list_empty_page.dart';
import '../../../core/widgets/list_empty_search_page.dart';
import '../../clients/domain/entities/client_list_entity.dart';
import '../../more/expenses/presentation/widgets/expenses_sort_page.dart';
import '../domain/usecase/item_usecase.dart';
import 'widgets/item_card_widget.dart';

enum EnumItemType {
  all,
  active,
  inActive,
  services,
  inventory,
  nonInventory,
  goods
}

extension EnumItemTypeExtensions on EnumItemType {
  String get title {
    switch (this) {
      case EnumItemType.all:
        return "All";
      case EnumItemType.active:
        return "Active";
      case EnumItemType.inActive:
        return "Inactive";
      case EnumItemType.services:
        return "Services";
      case EnumItemType.inventory:
        return "Inventory";
      case EnumItemType.nonInventory:
        return "Non-Inventory";
      case EnumItemType.goods:
        return "Goods";
    }
  }

//inactive, services, goods, inventory,  non-inventory
  String get apiValue {
    switch (this) {
      case EnumItemType.all:
        return "all";
      case EnumItemType.active:
        return "active";
      case EnumItemType.inActive:
        return "inactive";
      case EnumItemType.services:
        return "services";
      case EnumItemType.inventory:
        return "inventory";
      case EnumItemType.nonInventory:
        return "non-inventory";
      case EnumItemType.goods:
        return "goods";
    }
  }
}

@RoutePage()
class ItemList extends StatefulWidget {
  const ItemList({super.key});

  @override
  State<ItemList> createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> with SectionAdapterMixin {
  TextEditingController searchController = TextEditingController();
  EnumItemType selectedType = EnumItemType.all;
  EnumItemSortBy selectedInvoiceSortBy = EnumItemSortBy.name;
  EnumOrderBy selectedOrderBy = EnumOrderBy.ascending;
  bool isLoading = false;
  //ItemsResponseEntity? itemsResponseEntity;
  List<ItemListEntity> itemList = [];
  ScrollController _scrollController = ScrollController();
  Paging? paging;
  int currentPage = 1;
  bool isFromPagination = false;
  bool ignoreBlockListener = false;

  @override
  void initState() {
    _setupScrollController();
    _getItemList();
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
        _getItemList();
      }
    }
  }

  void _getItemList() {
    context.read<ItemBloc>().add(GetItemList(reqParams: getReqParams()));
  }

  ItemListReqModel getReqParams() {
    return ItemListReqModel(
      columnName: selectedInvoiceSortBy.apiValue,
      status: selectedType.apiValue,
      orderBy: selectedOrderBy.apiParamsValue,
      query: searchController.text,
      page: currentPage.toString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Items"),
          bottom: PreferredSize(
              preferredSize: const Size.fromHeight(45),
              child: ItemTypeHeaderWidget(
                selectedType: selectedType,
                callBack: (type) {
                  selectedType = type;
                  currentPage = 1;
                  setState(() {
                    _getItemList();
                  });
                },
              )),
          actions: [
            IconButton(
                onPressed: () {
                  AutoRouter.of(context).push(ItemSortPageRoute(
                      callBack: (type, orderby, sortBy) {
                        selectedType = type;
                        selectedOrderBy = orderby;
                        selectedInvoiceSortBy = sortBy;
                        currentPage = 1;
                        setState(() {
                          _getItemList();
                        });
                      },
                      selectedItemSortBy: selectedInvoiceSortBy,
                      selectedOrderBy: selectedOrderBy,
                      selectedType: selectedType));
                },
                icon: const Icon(
                  Icons.filter_list_alt,
                  color: AppPallete.blueColor,
                )),
            IconButton(
                onPressed: () {
                  openAddNewItem(null, false);
                },
                icon: const Icon(
                  Icons.add,
                  color: AppPallete.blueColor,
                ))
          ],
        ),
        body: BlocConsumer<ItemBloc, ItemState>(listener: (context, state) {
          if (ignoreBlockListener) {
            return;
          }

          if (state is ErrorDeleteItemState) {
            showToastification(
                context, state.errorMessage, ToastificationType.error);
          } else if (state is SuccessDeleteItemState) {
            showToastification(context, "Successfully item deleted",
                ToastificationType.success);
            currentPage = 1;
            _getItemList();
          }
          if (state is ErrorState) {
            isFromPagination = false;

            showToastification(
                context, state.errorMessage, ToastificationType.error);
          }
          if (state is ItemActiveErrorState) {
            showToastification(
                context, state.errorMessage, ToastificationType.error);
          }
          if (state is ItemInActiveErrorState) {
            showToastification(
                context, state.errorMessage, ToastificationType.error);
          }
          if (state is ItemActiveSuccessState) {
            showToastification(
                context,
                state.resEntity.data?.message ?? "Successfully item inactive.",
                ToastificationType.success);
            currentPage = 1;
            _getItemList();
          }
          if (state is ItemInActiveSuccessState) {
            showToastification(
                context,
                state.resEntity.data?.message ?? "Successfully item active.",
                ToastificationType.success);
            currentPage = 1;
            _getItemList();
          }
        }, builder: (context, state) {
          if (state is DeleteItemLoadingState && ignoreBlockListener == false) {
            return const LoadingPage(title: "Deleting item..");
          }
          if (state is ItemActiveLoadingState && ignoreBlockListener == false) {
            return const LoadingPage(title: "Marking active...");
          }
          if (state is ItemInActiveLoadingState &&
              ignoreBlockListener == false) {
            return const LoadingPage(title: "Marking inactive...");
          }
          if (state is LoadingState && ignoreBlockListener == false) {
            if (!isFromPagination) isLoading = true;
          }
          if (state is SuccessState && ignoreBlockListener == false) {
            if (currentPage == 1) {
              itemList = [];
            }
            paging = state.itemsResponseDataModel.data?.paging;
            final items = state.itemsResponseDataModel.data?.items ?? [];
            currentPage = paging?.currentpage ?? 0;
            isFromPagination = false;
            itemList.addAll(items);
            isLoading = false;

            if (itemList.isEmpty) {
              if (searchController.text.isNotEmpty) {
                return showSearchEmptyView();
              } else {
                return showEmptyView();
              }
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
        }));
  }

  Future<void> _handleRefresh() async {
    currentPage = 1;
    _getItemList();
  }

  Widget showEmptyView() {
    return ListEmptyPage(
      buttonTitle: "Create new item",
      noDataText: "Billing without items could be hard.",
      iconName: Icons.shopping_bag_outlined,
      noDataSubtitle:
          "Add your popular products and services so you can use them while creating invoices and estimates in seconds. It's easy, we'll sho you how.",
      callBack: () {
        openAddNewItem(null, false);
      },
    );
  }

  Widget showSearchEmptyView() {
    return ListEmptySearchPage(
      buttonTitle: "Refresh",
      noDataText: "No results for keyword",
      iconName: Icons.shopping_bag_outlined,
      searchText: searchController.text,
      callBack: () {
        searchController.text = "";
        _getItemList();
      },
    );
  }

  /*
  BlocBuilder<ItemBloc, ItemState>(
          builder: (context, state) {
            if (state is SuccessState) {
              itemsResponseEntity = state.itemsResponseDataModel;
              return SectionListView.builder(adapter: this);
            }
            return SizedBox();
          },
  */

  @override
  int numberOfSections() {
    return 1;
  }

  @override
  Widget getSectionHeader(BuildContext context, int section) {
    return SearchBarWidget(
      searchController: searchController,
      hintText: "Search Items",
      onSubmitted: (searchText) {
        _getItemList();
      },
      dismissKeyboard: () {
        Utils.hideKeyboard();
      },
    );
  }

  @override
  bool shouldExistSectionHeader(int section) {
    return true;
  }

  void openAddNewItem(ItemListEntity? item, bool isFromDuplicate) {
    ignoreBlockListener = true;
    AutoRouter.of(context).push(NewItemPageRoute(
        isFromDuplicate: isFromDuplicate,
        itemListEntity: item,
        popBack: () {
          ignoreBlockListener = false;
        },
        refreshPage: () {
          ignoreBlockListener = false;
          _getItemList();
        }));
  }

  bool isActive(ItemListEntity item) {
    if (item.status?.toLowerCase() == "active") {
      return true;
    }
    return false;
  }

  String getStatusTitle(ItemListEntity item) {
    if (isActive(item)) {
      return "Inactive";
    }
    return "Active";
  }

  Color getStatusColor(ItemListEntity item) {
    if (isActive(item)) {
      return AppPallete.orangeColor;
    }
    return AppPallete.greenColor;
  }

  void _makeActive(String id) {
    context.read<ItemBloc>().add(
        ItemMarkActiveEvent(reqParams: ItemMarkActiveUseCaseReqParams(id: id)));
  }

  void _makeInActive(String id) {
    context.read<ItemBloc>().add(ItemMarkInActiveEvent(
        reqParams: ItemMarkInActiveUseCaseReqParams(id: id)));
  }

  @override
  Widget getItem(BuildContext context, IndexPath indexPath) {
    final item = isLoading
        ? ItemListEntity(
            name: "Test Data",
            rate: "Rate",
            unit: "Unit",
            status: "Active",
            type: "service",
            description: "Description comes here")
        : itemList[indexPath.item];
    return GestureDetector(
      onTap: () {
        openAddNewItem(item, false);
      },
      child: SwipeActionCell(
        key: ObjectKey(item),
        trailingActions: [
          SwipeAction(
              closeOnTap: true,
              style: AppFonts.regularStyle(color: AppPallete.white),
              title: "Delete",
              onTap: (CompletionHandler handler) async {
                await handler(false);
                deleteAlert(item.id ?? "");
              },
              color: AppPallete.red),
          SwipeAction(
              closeOnTap: true,
              style: AppFonts.regularStyle(color: AppPallete.white),
              title: "Duplicate",
              onTap: (CompletionHandler handler) async {
                await handler(false);
                openAddNewItem(item, true);
              },
              color: AppPallete.borderColor),
          SwipeAction(
              closeOnTap: true,
              style: AppFonts.regularStyle(color: AppPallete.white),
              title: getStatusTitle(item),
              onTap: (CompletionHandler handler) async {
                await handler(false);

                if (isActive(item)) {
                  _makeInActive(item.id ?? "");
                } else {
                  _makeActive(item.id ?? "");
                }
              },
              color: getStatusColor(item)),
        ],
        child: ItemCardWidget(
          itemListEntity: item,
        ),
      ),
    );
  }

  @override
  int numberOfItems(int section) {
    return isLoading ? 10 : itemList.length;
  }

  void deleteAlert(String id) {
    showDialog(
        context: context,
        builder: (context) {
          return AppAlertWidget(
            title: "Delete Item",
            message: "Are you sure you want to delete this item?",
            onTapDelete: () {
              debugPrint("on tap delete item");
              AutoRouter.of(context).maybePop();

              context.read<ItemBloc>().add(DeleteItemEvent(
                  deleteItemReqModel: DeleteItemReqModel(id: id)));
            },
          );
        });
  }
}
