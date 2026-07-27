import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';
import 'package:billbooks_app/core/theme/app_fonts.dart';
import 'package:billbooks_app/core/theme/app_pallete.dart';
import 'package:billbooks_app/core/utils/show_toast.dart';
import 'package:billbooks_app/core/widgets/app_alert_widget.dart';
import 'package:billbooks_app/core/widgets/loading_page.dart';
import 'package:billbooks_app/features/invoice/domain/entities/invoice_details_entity.dart';
import 'package:billbooks_app/features/invoice/domain/entities/invoice_list_entity.dart';
import 'package:billbooks_app/features/invoice/domain/usecase/get_document_usecase.dart';
import 'package:billbooks_app/features/invoice/domain/usecase/invoice_delete_usecase.dart';
import 'package:billbooks_app/features/invoice/domain/usecase/invoice_markassend_usecase.dart';
import 'package:billbooks_app/features/invoice/presentation/add_new_invoice_page.dart';
import 'package:billbooks_app/features/invoice/presentation/invoice_action_button.dart';
import 'package:billbooks_app/features/invoice/presentation/bloc/invoice_bloc.dart';
import 'package:billbooks_app/features/invoice/presentation/send_invoice_estimate_page.dart';
import 'package:billbooks_app/features/invoice/presentation/widgets/invoice_details_info_widget.dart';
import 'package:billbooks_app/features/invoice/presentation/widgets/itemdetails_amount_section_widget.dart';
import 'package:billbooks_app/features/invoice/presentation/widgets/items_details_card_widget.dart';
import 'package:billbooks_app/features/invoice/presentation/widgets/items_tax_amount_details_widget.dart';
import 'package:billbooks_app/features/proforma/domain/entities/proforma_details_entity.dart';
import 'package:billbooks_app/features/proforma/domain/usecase/proforma_list_usecase.dart';
import 'package:billbooks_app/features/proforma/presentation/add_proforma_page.dart';
import 'package:billbooks_app/features/proforma/presentation/bloc/proforma_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_section_list/flutter_section_list.dart';
import 'package:toastification/toastification.dart';
import 'dart:async';

class ProformaDetailPage extends StatefulWidget {
  final InvoiceEntity proformaEntity;
  final VoidCallback? refreshList;
  final VoidCallback startObserveBlocBack;

  const ProformaDetailPage({
    super.key,
    required this.proformaEntity,
    this.refreshList,
    required this.startObserveBlocBack,
  });

  @override
  State<ProformaDetailPage> createState() => _ProformaDetailPageState();
}

class _ProformaDetailPageState extends State<ProformaDetailPage>
    with SectionAdapterMixin {
  InvoiceEntity? invoiceEntity;
  bool callRefresh = false;
  ProformaDetailResEntity? proformaDetailResEntity;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    context.read<ProformaBloc>().add(GetProformaDetailsEvent(
        params: ProformaDetailsReqParams(id: widget.proformaEntity.id ?? '')));
  }

  void _popOut() {
    widget.startObserveBlocBack();
    if (callRefresh && widget.refreshList != null) {
      widget.refreshList!();
    }
    Navigator.of(context).maybePop();
  }

  void _openEdit() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => AddProformaPage(
        proformaEntity: invoiceEntity ?? widget.proformaEntity,
        type: EnumNewProformaType.editProforma,
        startObserveBlocBack: () {},
        deletedItem: () {
          callRefresh = true;
          _popOut();
        },
        refreshCallBack: () {
          callRefresh = true;
          _loadData();
        },
      ),
    ));
  }

  void _openDuplicate() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => AddProformaPage(
        proformaEntity: invoiceEntity ?? widget.proformaEntity,
        type: EnumNewProformaType.duplicateProforma,
        startObserveBlocBack: () {},
        deletedItem: () {},
        refreshCallBack: () {},
      ),
    ));
  }

  void _openSendProforma() {
    final id = invoiceEntity?.id ?? widget.proformaEntity.id ?? '';
    if (id.isEmpty) {
      return;
    }

    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => SendInvoiceEstimatePage(
        params: GetDocumentUsecaseReqParams(
          pageType: EnumSendPageType.send,
          type: EnumDocumentType.proforma,
          id: id,
        ),
      ),
    ));
  }

  void _openForwardProforma() {
    final id = invoiceEntity?.id ?? widget.proformaEntity.id ?? '';
    if (id.isEmpty) {
      return;
    }

    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => SendInvoiceEstimatePage(
        params: GetDocumentUsecaseReqParams(
          pageType: EnumSendPageType.forward,
          type: EnumDocumentType.proforma,
          id: id,
        ),
      ),
    ));
  }

  InvoiceDetailResEntity _buildInvoiceDetailResEntityFromProforma() {
    return InvoiceDetailResEntity(
      invoice: invoiceEntity ?? widget.proformaEntity,
      taxes: (proformaDetailResEntity?.taxes ?? [])
          .map((returnedTax) => TaxEntity(
                id: returnedTax.id,
                name: returnedTax.name,
                rate: returnedTax.rate,
              ))
          .toList(),
      clients: proformaDetailResEntity?.clients,
      projects: proformaDetailResEntity?.projects,
      items: proformaDetailResEntity?.items,
    );
  }

  void _showUnsupportedAction(String actionTitle) {
    showToastification(
      context,
      '$actionTitle is not available for proforma yet.',
      ToastificationType.info,
    );
  }

  void _showDeleteAlert() {
    Timer(const Duration(milliseconds: 500), () {
      if (!mounted) {
        return;
      }
      showDialog(
        context: context,
        builder: (context) {
          return AppAlertWidget(
            title: 'Delete Proforma',
            message: 'Are you sure you want to delete this proforma?',
            onTapDelete: () {
              Navigator.of(context).maybePop();
              _deleteProforma();
            },
          );
        },
      );
    });
  }

  void _deleteProforma() {
    final id = invoiceEntity?.id ?? widget.proformaEntity.id ?? '';
    if (id.isEmpty) {
      return;
    }

    context.read<InvoiceBloc>().add(InvoiceDeleteEvent(
            params: InvoiceDeleteReqParms(
          id: id,
          type: EnumDocumentType.proforma,
        )));
  }

  bool isDraft() {
    final status = (invoiceEntity?.status ?? '').trim().toLowerCase();
    return status == 'draft';
  }

  bool isSent() {
    final status = (invoiceEntity?.status ?? '').trim().toLowerCase();
    return status == 'sent';
  }

  void _showMarkAsSentAlert() {
    Timer(const Duration(milliseconds: 500), () {
      if (!mounted) {
        return;
      }
      showDialog(
        context: context,
        builder: (context) {
          return AppAlertWidget(
            title: 'Mark as Sent',
            message:
                'This proforma will be marked as sent without actually sending it to your client. Confirm?',
            onTapDelete: () {
              Navigator.of(context).maybePop();
              _setMarkAsSent();
            },
            alertType: EnumAppAlertType.ok,
          );
        },
      );
    });
  }

  void _setMarkAsSent() {
    final id = invoiceEntity?.id ?? widget.proformaEntity.id ?? '';
    if (id.isEmpty) {
      return;
    }

    context.read<InvoiceBloc>().add(InvoiceMarkAsSendEvent(
            params: InvoiceMarkassendReqParms(
          id: id,
          type: EnumDocumentType.proforma,
        )));
  }

  void _convertToInvoice() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => AddNewInvoiceEstimatePage(
        invoiceDetailResEntity: _buildInvoiceDetailResEntityFromProforma(),
        invoiceEntity: invoiceEntity ?? widget.proformaEntity,
        type: EnumNewInvoiceEstimateType.convertProformaToInvoice,
        estimateTitle: 'Estimate',
        startObserveBlocBack: () {},
        deletedItem: () {},
        refreshCallBack: () {
          callRefresh = true;
        },
      ),
    ));
  }

  void _dismissMorePopup(BuildContext sheetContext) {
    Navigator.of(sheetContext, rootNavigator: true).pop();
  }

  void _showMoreActions() {
    showAdaptiveActionSheet(
      useRootNavigator: true,
      androidBorderRadius: 30,
      isDismissible: true,
      context: context,
      actions: [
        BottomSheetAction(
            title: Text(
              'Send Proforma',
              style:
                  AppFonts.regularStyle(color: AppPallete.blueColor, size: 16),
            ),
            onPressed: (sheetContext) {
              _dismissMorePopup(sheetContext);
              _openSendProforma();
            }),
        if (isDraft())
          BottomSheetAction(
              title: Text(
                'Mark as Sent',
                style: AppFonts.regularStyle(
                    color: AppPallete.blueColor, size: 16),
              ),
              onPressed: (sheetContext) {
                _dismissMorePopup(sheetContext);
                _showMarkAsSentAlert();
              }),
        if (isSent())
          BottomSheetAction(
              title: Text(
                'Convert to Invoice',
                style: AppFonts.regularStyle(
                    color: AppPallete.blueColor, size: 16),
              ),
              onPressed: (sheetContext) {
                _dismissMorePopup(sheetContext);
                _convertToInvoice();
              }),
        BottomSheetAction(
            title: Text(
              'Forward Proforma',
              style:
                  AppFonts.regularStyle(color: AppPallete.blueColor, size: 16),
            ),
            onPressed: (sheetContext) {
              _dismissMorePopup(sheetContext);
              _openForwardProforma();
            }),
        BottomSheetAction(
            title: Text(
              'Duplicate',
              style:
                  AppFonts.regularStyle(color: AppPallete.blueColor, size: 16),
            ),
            onPressed: (sheetContext) {
              _dismissMorePopup(sheetContext);
              _openDuplicate();
            }),
        BottomSheetAction(
            title: Text(
              'Packing Slip',
              style:
                  AppFonts.regularStyle(color: AppPallete.blueColor, size: 16),
            ),
            onPressed: (sheetContext) {
              _dismissMorePopup(sheetContext);
              _showUnsupportedAction('Packing Slip');
            }),
        BottomSheetAction(
            title: Text(
              'Delete',
              style: AppFonts.regularStyle(color: AppPallete.red, size: 16),
            ),
            onPressed: (sheetContext) {
              _dismissMorePopup(sheetContext);
              _showDeleteAlert();
            }),
      ],
      cancelAction: CancelAction(
          title: Text(
        'Cancel',
        style: AppFonts.mediumStyle(color: AppPallete.blueColor, size: 16),
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    final invoiceState = context.watch<InvoiceBloc>().state;

    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: _openEdit,
              child: Text(
                'Edit',
                style: AppFonts.regularStyle(color: AppPallete.blueColor),
              ))
        ],
        leading: IconButton(
          onPressed: _popOut,
          icon: const Icon(
            Icons.close,
            color: AppPallete.blueColor,
          ),
        ),
        backgroundColor: AppPallete.lightBlueColor,
        title: Text(
          'Proforma',
          style: AppFonts.mediumStyle(),
        ),
      ),
      body: SafeArea(
        child: BlocListener<InvoiceBloc, InvoiceState>(
          listener: (context, state) {
            if (state is InvoiceDeleteErrorState) {
              showToastification(
                  context, state.errorMessage, ToastificationType.error);
            }

            if (state is InvoiceMarkAsSendErrorState) {
              showToastification(
                  context, state.errorMessage, ToastificationType.error);
            }

            if (state is InvoiceDeleteSuccessState) {
              showToastification(
                  context,
                  state.invoiceDeleteMainResEntity.data?.message ??
                      'Successfully deleted',
                  ToastificationType.success);
              callRefresh = true;
              _popOut();
            }

            if (state is InvoiceMarkAsSendSuccessState) {
              showToastification(
                  context,
                  state.invoiceMarksendMainResEntity.data?.message ??
                      'Successfully marked as sent.',
                  ToastificationType.success);
              callRefresh = true;
              _loadData();
            }
          },
          child: BlocConsumer<ProformaBloc, ProformaState>(
            listener: (context, state) {
              if (state is ProformaDetailsSuccessState) {
                proformaDetailResEntity = state.proformaDetailResEntity;
                invoiceEntity = state.proformaDetailResEntity.proforma;
                setState(() {});
              }

              if (state is ProformaDetailsFailureState) {
                showToastification(
                    context, state.errorMessage, ToastificationType.error);
              }
            },
            builder: (context, state) {
              if (invoiceState is InvoiceDeleteLoadingState) {
                return const LoadingPage(title: 'Deleting proforma...');
              }

              if (invoiceState is InvoiceMarkAsSendLoadingState) {
                return const LoadingPage(title: 'Marking proforma as sent...');
              }

              if (state is ProformaDetailsLoadingState &&
                  proformaDetailResEntity == null) {
                return const LoadingPage(title: 'Loading proforma details...');
              }

              if (invoiceEntity == null || proformaDetailResEntity == null) {
                return const LoadingPage(title: 'Loading proforma details...');
              }

              return SectionListView.builder(adapter: this);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildOverviewSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 16, top: 5),
      decoration: const BoxDecoration(color: AppPallete.lightBlueColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              invoiceEntity?.clientName ?? '',
              textAlign: TextAlign.center,
              style: AppFonts.regularStyle(size: 18),
            ),
          ),
          Text(
            invoiceEntity?.formatedTotal ?? invoiceEntity?.nettotal ?? '-',
            style: AppFonts.mediumStyle(
              color: AppPallete.blueColor,
              size: 24,
            ),
          ),
          if ((invoiceEntity?.status ?? '').isNotEmpty) ...[
            const SizedBox(height: 3),
            Text(
              (invoiceEntity?.status ?? '').toUpperCase(),
              style: AppFonts.mediumStyle(
                size: 12,
                color: AppPallete.k666666,
              ),
            ),
          ],
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: _openEdit,
                  child: _headerActionCell(
                    actionButtonType: InvoiceActionButtonType.edit,
                  ),
                ),
                GestureDetector(
                  onTap: _openSendProforma,
                  child: _headerActionCell(
                    actionButtonType: InvoiceActionButtonType.send,
                  ),
                ),
                GestureDetector(
                  onTap: () => _showUnsupportedAction('View PDF'),
                  child: _headerActionCell(
                    actionButtonType: InvoiceActionButtonType.viewpdf,
                  ),
                ),
                GestureDetector(
                  onTap: _showMoreActions,
                  child: _headerActionCell(
                    actionButtonType: InvoiceActionButtonType.more,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _headerActionCell({
    required InvoiceActionButtonType actionButtonType,
  }) {
    return Container(
      decoration: const BoxDecoration(color: AppPallete.lightBlueColor),
      child: Column(
        children: [
          SizedBox(
            width: 33,
            height: 33,
            child: Image.asset(actionButtonType.imageName),
          ),
          Text(
            actionButtonType.name,
            style: AppFonts.regularStyle(size: 14, color: AppPallete.blueColor),
          ),
        ],
      ),
    );
  }

  @override
  Widget getItem(BuildContext context, IndexPath indexPath) {
    if (indexPath.section == 0) {
      return _buildOverviewSection(context);
    }

    if (indexPath.section == 1) {
      return InvoiceDetailsInfoWidget(
        invoiceEntity: invoiceEntity!,
        type: EnumNewInvoiceEstimateType.editEstimate,
        estimateTitle: 'Proforma',
      );
    }

    if (indexPath.section == 2) {
      final items = invoiceEntity?.items ?? [];
      if (items.length > indexPath.item) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ItemDetailsCardWidget(
            invoiceItemEntity: items[indexPath.item],
            currencySymbol: invoiceEntity!.decodedCurrencySymbol,
          ),
        );
      }
    }

    return const SizedBox();
  }

  @override
  int numberOfItems(int section) {
    if (invoiceEntity == null) {
      return 0;
    }

    if (section == 2) {
      return invoiceEntity?.items?.length ?? 0;
    }

    return 1;
  }

  @override
  int numberOfSections() {
    if (invoiceEntity == null) {
      return 0;
    }

    return 3;
  }

  @override
  bool shouldExistSectionHeader(int section) {
    return section == 2;
  }

  @override
  bool shouldExistSectionFooter(int section) {
    return section == 2 && invoiceEntity != null;
  }

  @override
  Widget getSectionHeader(BuildContext context, int section) {
    if (section == 2) {
      return const ItemDetailsAmountSectionWidget();
    }

    return const SizedBox();
  }

  @override
  Widget getSectionFooter(BuildContext context, int section) {
    return ItemsTaxAmountDetailsWidget(
      invoiceDetailResEntity: InvoiceDetailResEntity(),
      invoiceEntity: invoiceEntity!,
      isInvoice: false,
    );
  }
}
