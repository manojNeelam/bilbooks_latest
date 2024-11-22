import 'package:auto_route/auto_route.dart';
import 'package:billbooks_app/core/app_constants.dart';
import 'package:billbooks_app/core/theme/app_fonts.dart';
import 'package:billbooks_app/core/theme/app_pallete.dart';
import 'package:billbooks_app/core/utils/show_toast.dart';
import 'package:billbooks_app/core/widgets/item_separator.dart';
import 'package:billbooks_app/core/widgets/loading_page.dart';
import 'package:billbooks_app/features/taxes/presentation/bloc/tax_bloc.dart';
import 'package:billbooks_app/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_section_list/flutter_section_list.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:toastification/toastification.dart';
import '../../../core/widgets/list_empty_page.dart';
import '../../../core/widgets/title_subtitle_header_widget.dart';
import '../../invoice/domain/entities/invoice_details_entity.dart';

@RoutePage()
class TaxesListPage extends StatefulWidget {
  const TaxesListPage({super.key});

  @override
  State<TaxesListPage> createState() => _TaxesListPageState();
}

class _TaxesListPageState extends State<TaxesListPage>
    with SectionAdapterMixin {
  List<TaxEntity> taxes = [];
  bool isLoading = false;
  bool ignoreListening = false;

  @override
  void initState() {
    ignoreListening = false;
    _getTaxes();
    super.initState();
  }

  void _getTaxes() {
    context.read<TaxBloc>().add(GetTaxList());
  }

  void _openAddTaxPage(TaxEntity? taxEntity) {
    ignoreListening = true;
    AutoRouter.of(context).push(AddTaxPageRoute(
        taxEntity: taxEntity,
        refreshPage: () {
          _getTaxes();
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Taxes"),
        bottom: AppConstants.getAppBarDivider,
        actions: [
          IconButton(
              onPressed: () {
                _openAddTaxPage(null);
              },
              icon: const Icon(
                Icons.add,
                color: AppPallete.blueColor,
              ))
        ],
      ),
      body: BlocConsumer<TaxBloc, TaxState>(
        listener: (context, state) {
          if (state is TaxListLoadingState) {
            isLoading = true;
          }
          if (state is TaxListSuccessState) {
            isLoading = false;
            taxes = state.taxListResEntity.data?.taxes ?? [];
          }
          if (state is SuccessDeleteTax && ignoreListening == false) {
            isLoading = false;
            showToastification(context, "Tax deleted successfully.",
                ToastificationType.success);
            context.read<TaxBloc>().add(GetTaxList());
          }

          if (state is TaxListErrorState) {
            isLoading = false;
          }

          if (state is TaxDeleteErrorState && ignoreListening == false) {
            showToastification(
                context, state.errorMessage, ToastificationType.error);
          }
        },
        builder: (context, state) {
          if (state is TaxDeleteWaitingState && ignoreListening == false) {
            return const LoadingPage(title: "Tax deleting...");
          }
          if (state is TaxListSuccessState) {
            if (taxes.isEmpty) {
              return _showEmptyView();
            }
          }
          if (state is TaxListErrorState) {
            if (taxes.isEmpty) {
              return _showEmptyView();
            }
          }
          return Skeletonizer(
              enabled: isLoading,
              child: SectionListView.builder(adapter: this));
        },
      ),
    );
  }

  Widget _showEmptyView() {
    return ListEmptyPage(
      buttonTitle: "Create new tax",
      noDataText: "Billing without tax could be hard.",
      iconName: Icons.file_copy_sharp,
      noDataSubtitle: "",
      callBack: () {
        _openAddTaxPage(null);
      },
    );
  }

  @override
  Widget getItem(BuildContext context, IndexPath indexPath) {
    final tax =
        isLoading ? TaxEntity(name: "Name", rate: 10) : taxes[indexPath.item];
    return GestureDetector(
        onTap: () {
          _openAddTaxPage(tax);
        },
        child: SwipeActionCell(
            key: ObjectKey(tax),
            trailingActions: [
              SwipeAction(
                  style: AppFonts.regularStyle(color: AppPallete.white),
                  title: "Delete",
                  onTap: (CompletionHandler handler) async {
                    ignoreListening = false;
                    context
                        .read<TaxBloc>()
                        .add(DeleteTaxEvent(taxId: tax.id ?? ""));
                  },
                  color: Colors.red),
            ],
            child: TaxListItemWidget(tax: tax)));
  }

  @override
  int numberOfItems(int section) {
    return isLoading ? 10 : taxes.length;
  }

  @override
  bool shouldExistSectionHeader(int section) {
    return true;
  }

  @override
  Widget getSectionHeader(BuildContext context, int section) {
    return const TitleSubtitleHeaderWidget(
      leadingTitle: "Tax Name",
      trailingTitle: "Tax Rate",
    );
  }
}

class TaxListItemWidget extends StatelessWidget {
  const TaxListItemWidget({
    super.key,
    required this.tax,
  });

  final TaxEntity tax;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppConstants.horizotal16,
      child: Column(
        children: [
          Padding(
            padding: AppConstants.verticalPadding,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  tax.name ?? "",
                  style: AppFonts.regularStyle(),
                ),
                Text(
                  "${tax.rate}%",
                  style: AppFonts.regularStyle(),
                )
              ],
            ),
          ),
          const ItemSeparator(),
        ],
      ),
    );
  }
}
