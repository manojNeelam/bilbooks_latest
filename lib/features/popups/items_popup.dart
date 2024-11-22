import 'package:auto_route/auto_route.dart';
import 'package:billbooks_app/core/theme/app_fonts.dart';
import 'package:billbooks_app/core/theme/app_pallete.dart';
import 'package:billbooks_app/features/item/domain/entities/item_list_entity.dart';
import 'package:billbooks_app/features/item/presentation/bloc/item_bloc.dart';
import 'package:billbooks_app/features/item/presentation/item_sort_page.dart';
import 'package:billbooks_app/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_section_list/flutter_section_list.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../core/widgets/list_empty_page.dart';
import '../../../core/widgets/list_empty_search_page.dart';
import '../../core/app_constants.dart';
import '../../core/utils/utils.dart';
import '../../core/widgets/item_separator.dart';
import '../../core/widgets/searchbar_widget.dart';
import '../item/domain/usecase/item_usecase.dart';
import '../item/presentation/item_list.dart';
import '../item/presentation/widgets/item_card_widget.dart';
import '../more/expenses/presentation/widgets/expenses_sort_page.dart';

@RoutePage()
class ItemsPopup extends StatefulWidget {
  final List<ItemListEntity>? itemsListFromBaseClass;
  final ItemListEntity? selectedItem;
  final Function(ItemListEntity?) onSelectedItem;
  const ItemsPopup(
      {super.key,
      this.selectedItem,
      required this.onSelectedItem,
      this.itemsListFromBaseClass});

  @override
  State<ItemsPopup> createState() => _ItemsPopupState();
}

class _ItemsPopupState extends State<ItemsPopup> with SectionAdapterMixin {
  TextEditingController searchController = TextEditingController();
  EnumItemType selectedType = EnumItemType.all;
  EnumItemSortBy selectedInvoiceSortBy = EnumItemSortBy.name;
  EnumOrderBy selectedOrderBy = EnumOrderBy.ascending;
  bool isLoading = false;
  //ItemsResponseEntity? itemsResponseEntity;
  List<ItemListEntity>? itemList;

  @override
  void initState() {
    // if (widget.itemsListFromBaseClass != null &&
    //     widget.itemsListFromBaseClass!.isNotEmpty) {
    //   itemList = widget.itemsListFromBaseClass;
    // } else {
    //   _getItemList();
    // }
    _getItemList();
    super.initState();
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
      page: "1",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Items"),
          bottom: AppConstants.getAppBarDivider,
          actions: [
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
        body: BlocConsumer<ItemBloc, ItemState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is LoadingState) {
              isLoading = true;
            }
            if (state is SuccessState) {
              isLoading = false;
              final items = state.itemsResponseDataModel.data?.items ?? [];
              itemList = items;
              if (items.isNotEmpty) {
                //itemsResponseEntity = state.itemsResponseDataModel;
                return Skeletonizer(
                    enabled: isLoading,
                    child: SectionListView.builder(adapter: this));
              } else if (searchController.text.isNotEmpty) {
                return showSearchEmptyView();
              } else {
                return showEmptyView();
              }
            }
            return Skeletonizer(
                enabled: isLoading,
                child: SectionListView.builder(adapter: this));
          },
        ));
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

  @override
  int numberOfSections() {
    return 1;
  }

  @override
  Widget getSectionHeader(BuildContext context, int section) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        widget.onSelectedItem(null);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SearchBarWidget(
            searchController: searchController,
            hintText: "Search Clients",
            onSubmitted: (searchText) {
              _getItemList();
            },
            dismissKeyboard: () {
              Utils.hideKeyboard();
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "None",
                  style: AppFonts.regularStyle(),
                ),
                if (widget.selectedItem == null)
                  const Icon(
                    Icons.check,
                    color: AppPallete.blueColor,
                  )
              ],
            ),
          ),
          const ItemSeparator(),
        ],
      ),
    );
  }

  @override
  bool shouldExistSectionHeader(int section) {
    return true;
  }

  void openAddNewItem(ItemListEntity? item, bool isFromDuplicate) {
    AutoRouter.of(context).push(NewItemPageRoute(
        isFromDuplicate: isFromDuplicate,
        itemListEntity: item,
        refreshPage: () {
          _getItemList();
        }));
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
        : itemList?[indexPath.item];
    if (item != null) {
      return GestureDetector(
        onTap: () {
          widget.onSelectedItem(item);
          AutoRouter.of(context).maybePop();
        },
        child: ItemCardWidget(
          itemListEntity: item,
        ),
      );
    }
    return const SizedBox();
  }

  @override
  int numberOfItems(int section) {
    return isLoading ? 10 : itemList?.length ?? 0;
  }
}
