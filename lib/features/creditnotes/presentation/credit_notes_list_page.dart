import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:billbooks_app/core/app_constants.dart' show AppConstants;
import 'package:billbooks_app/core/theme/app_fonts.dart' show AppFonts;
import 'package:billbooks_app/features/creditnotes/domain/entity/credit_notes_list_entity.dart';
import 'package:billbooks_app/features/creditnotes/domain/model/credit_note_list_req_params.dart';
import 'package:billbooks_app/features/creditnotes/presentation/credit_notes_type_header_widget.dart';
import 'package:billbooks_app/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_section_list/flutter_section_list.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:toastification/toastification.dart';

import '../../../core/theme/app_pallete.dart';
import '../../../core/utils/show_toast.dart';
import '../../../core/utils/utils.dart';
import '../../../core/widgets/list_count_header_widget.dart';
import '../../../core/widgets/list_empty_page.dart';
import '../../../core/widgets/list_empty_search_page.dart';
import '../../clients/domain/entities/client_list_entity.dart';
import 'bloc/creditnote_bloc.dart';
import 'widgets/creditnote_list_item_widget.dart';

enum EnumCreditNoteType { all, applied, unused, voided }

extension CreditNoteTypeExtension on EnumCreditNoteType {
  String get name {
    switch (this) {
      case EnumCreditNoteType.all:
        return 'All';
      case EnumCreditNoteType.applied:
        return 'Applied';
      case EnumCreditNoteType.unused:
        return 'Unused';
      case EnumCreditNoteType.voided:
        return 'Voided';
    }
  }

  String get apiParam {
    switch (this) {
      case EnumCreditNoteType.all:
        return '';
      case EnumCreditNoteType.applied:
        return 'Applied';
      case EnumCreditNoteType.unused:
        return 'Unused';
      case EnumCreditNoteType.voided:
        return 'Void';
    }
  }
}

@RoutePage()
class CreditNotesListPage extends StatefulWidget {
  const CreditNotesListPage({super.key});

  @override
  State<CreditNotesListPage> createState() => _CreditNotesListPageState();
}

class _CreditNotesListPageState extends State<CreditNotesListPage>
    with SectionAdapterMixin {
  EnumCreditNoteType selectedType = EnumCreditNoteType.all;
  int currentPage = 1;
  bool isLoading = false;
  List<CreditNoteEntity> creditNotesList = [];
  Paging? paging;
  bool isFromPagination = false;
  String? startDateReqParams;
  String? endDateReqParams;
  ScrollController _scrollController = ScrollController();
  TextEditingController searchController = TextEditingController();
  EnumAllTimes selectedAllTimes = EnumAllTimes.all;
  String allTimesDisplayName = EnumAllTimes.all.displayName.$3;

  @override
  void initState() {
    _setupScrollController();
    loadCreditNotes();
    super.initState();
  }

  void loadCreditNotes() {
    context.read<CreditnoteBloc>().add(CreditnoteLoadEvent(
        CreditNoteListReqParams(
            status: selectedType.apiParam, query: searchController.text)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Credit Notes"),
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(45),
            child: CreditNotesTypeHeaderWidget(
              selectedType: selectedType,
              callBack: (type) {
                selectedType = type;
                setState(() {});
                currentPage = 1;
                loadCreditNotes();
              },
            )),
        actions: [
          IconButton(
              onPressed: () {
                _showAddCreditNoteScreen();
              },
              icon: const Icon(
                Icons.add,
                color: AppPallete.blueColor,
              ))
        ],
      ),
      body: BlocConsumer<CreditnoteBloc, CreditnoteState>(
        listener: (context, state) {
          if (state is CreditnoteError) {
            isFromPagination = false;
            showToastification(
                context, state.message, ToastificationType.error);
            isLoading = false;
          }
          if (state is CreditnoteLoading) {
            if (!isFromPagination) isLoading = true;
          }
        },
        builder: (context, state) {
          if (state is CreditnoteLoaded) {
            // Handle the loaded state, e.g., show a success message or update UI
            if (currentPage == 1) {
              creditNotesList = [];
            }
            final list = state.creditNotes.data?.creditnotes ?? [];
            paging = state.creditNotes.data?.paging;
            currentPage = paging?.currentpage ?? 0;
            isFromPagination = false;
            creditNotesList.addAll(list);
            isLoading = false;

            if (creditNotesList.isEmpty) {
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

  @override
  Widget getItem(BuildContext context, IndexPath indexPath) {
    final item = isLoading
        ? CreditNoteEntity(
            creditNoteId: "",
            creditnoteDate: "",
            creditnoteNo: "",
            invoiceNo: "",
            clientName: "",
            projectName: "",
            status: "",
            expiryDate: "",
            formatedAmount: "",
            currency: "")
        : creditNotesList[indexPath.item];
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
              },
              color: AppPallete.borderColor)
        ],
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: CreditnoteListItemWidget(
            creditNoteEntity: item,
          ),
        ),
      ),
      onTap: () {
        //AutoRouter.of(context).push(CategoryListPageRoute());

        // Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        //   return InvoiceDetailPage(); //edit
        // }));
      },
    );
  }

  Widget _showNoSearchResultFound() {
    return ListEmptySearchPage(
        searchText: searchController.text,
        callBack: () {
          searchController.text = "";
          loadCreditNotes();
        });
  }

  Widget _showEmptyView() {
    return ListEmptyPage(
      buttonTitle: "Create new credit note",
      noDataText: "Billing without Credit Notes could be hard.",
      iconName: Icons.people_alt_outlined,
      noDataSubtitle:
          "Add your popular products and services so you can use them while creating invoices and estimates in seconds. It's easy, we'll show you how.",
      callBack: () {},
    );
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
      }
    }
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
  int numberOfItems(int section) {
    return isLoading ? 10 : creditNotesList.length;
  }

  Future<void> _handleRefresh() async {
    currentPage = 1;
  }

  @override
  Widget getSectionHeader(BuildContext context, int section) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, left: 16, right: 16, bottom: 0),
      child: ListCountHeader(
          controller: searchController,
          hintText: "Search by CN num, Client / Project id",
          capsuleText: "${creditNotesList.length} Credit Notes",
          selectedMenuItem: selectedAllTimes,
          isShowAllTime: false,
          onSelectedMenuItem: (val, displayName, startDate, endDate) {},
          dismissKeyboard: () {
            Utils.hideKeyboard();
          },
          onSubmitted: (val) {
            loadCreditNotes();
          }),
    );
  }

  _showAddCreditNoteScreen() {
    AutoRouter.of(context).push(AddCreateNotePageRoute());
  }
}
