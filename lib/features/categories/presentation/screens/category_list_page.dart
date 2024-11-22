import 'package:auto_route/auto_route.dart';
import 'package:billbooks_app/core/app_constants.dart';
import 'package:billbooks_app/core/theme/app_fonts.dart';
import 'package:billbooks_app/core/theme/app_pallete.dart';
import 'package:billbooks_app/core/widgets/item_separator.dart';
import 'package:billbooks_app/core/widgets/list_empty_page.dart';
import 'package:billbooks_app/features/categories/domain/usecase/category_list_usecase.dart';
import 'package:billbooks_app/features/categories/presentation/bloc/category_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_section_list/flutter_section_list.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../domain/entities/category_main_res_entity.dart';

@RoutePage()
class CategoryListPage extends StatefulWidget {
  final CategoryEntity? categoryEntity;
  final Function(CategoryEntity?)? onSelectCategory;
  const CategoryListPage(
      {super.key, this.categoryEntity, this.onSelectCategory});

  @override
  State<CategoryListPage> createState() => _CategoryListPageState();
}

class _CategoryListPageState extends State<CategoryListPage>
    with SectionAdapterMixin {
  List<CategoryEntity> categories = [];
  bool isLoading = false;
  CategoryEntity? selectedCategory;

  @override
  void initState() {
    debugPrint("Initcalled");
    selectedCategory = widget.categoryEntity;
    _getCategoryList();
    super.initState();
  }

  void _getCategoryList() {
    context
        .read<CategoryBloc>()
        .add(GetCatgeories(params: CategoryListReqParams()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Category"),
        bottom: AppConstants.getAppBarDivider,
      ),
      body: BlocConsumer<CategoryBloc, CategoryState>(
        listener: (context, state) {
          if (state is CategoryListLoadingState) {
            isLoading = true;
          }
          if (state is CategoryListErrorState) {
            isLoading = false;
          }
        },
        builder: (context, state) {
          if (state is CategoryListSuccessState) {
            isLoading = false;
            final list = state.categoryListMainResEntity.data?.categories ?? [];
            categories = list;
            if (list.isEmpty) {
              return ListEmptyPage(
                  buttonTitle: "Create new category",
                  noDataText: "No Categories",
                  noDataSubtitle: "",
                  iconName: Icons.category,
                  callBack: () {});
            }
          }
          return Skeletonizer(
            enabled: isLoading,
            child: SectionListView.builder(adapter: this),
          );
        },
      ),
    );
  }

  @override
  Widget getItem(BuildContext context, IndexPath indexPath) {
    final category = isLoading
        ? CategoryEntity(name: "Name comes here")
        : categories[indexPath.item];
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          onSelectCategory(category);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: AppConstants.verticalPadding13,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    category.name ?? "",
                    style: AppFonts.regularStyle(),
                  ),
                  if (selectedCategory != null &&
                      selectedCategory!.id == category.id)
                    const Icon(
                      Icons.check,
                      color: AppPallete.blueColor,
                    )
                ],
              ),
            ),
            const ItemSeparator()
          ],
        ),
      ),
    );
  }

  @override
  int numberOfItems(int section) {
    return isLoading ? 10 : categories.length;
  }

  @override
  bool shouldExistSectionHeader(int section) {
    return true;
  }

  @override
  Widget getSectionHeader(BuildContext context, int section) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        onSelectCategory(null);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: AppConstants.verticalPadding13,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "None",
                    style: AppFonts.regularStyle(),
                  ),
                  if (selectedCategory == null)
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
      ),
    );
  }

  void onSelectCategory(CategoryEntity? category) {
    selectedCategory = category;
    setState(() {});
    if (widget.onSelectCategory != null) {
      widget.onSelectCategory!(category);
    }
    AutoRouter.of(context).maybePop();
  }
}
