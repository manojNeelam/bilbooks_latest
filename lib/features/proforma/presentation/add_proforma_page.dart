import 'dart:io';
import 'dart:typed_data';

import 'package:auto_route/auto_route.dart';
import 'package:billbooks_app/core/app_constants.dart';
import 'package:billbooks_app/core/utils/currency_helper.dart';
import 'package:billbooks_app/core/theme/app_fonts.dart';
import 'package:billbooks_app/core/theme/app_pallete.dart';
import 'package:billbooks_app/core/utils/hive_functions.dart';
import 'package:billbooks_app/core/utils/show_toast.dart';
import 'package:billbooks_app/core/widgets/item_separator.dart';
import 'package:billbooks_app/core/widgets/loading_page.dart';
import 'package:billbooks_app/core/widgets/section_header_widget.dart';
import 'package:billbooks_app/features/clients/domain/entities/client_list_entity.dart';
import 'package:billbooks_app/features/invoice/domain/entities/invoice_list_entity.dart';
import 'package:billbooks_app/features/invoice/domain/usecase/client_staff_usecase.dart';
import 'package:billbooks_app/features/invoice/presentation/bloc/invoice_bloc.dart';
import 'package:billbooks_app/features/invoice/presentation/line_item_total_selection.dart';
import 'package:billbooks_app/features/project/domain/entity/project_list_entity.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_section_list/flutter_section_list.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toastification/toastification.dart';
import '../../../core/widgets/app_alert_widget.dart';
import '../../../core/widgets/notes_widget.dart';
import '../../../core/widgets/terms_card_widget.dart';
import '../../../router/app_router.dart';
import '../../invoice/domain/entities/invoice_details_entity.dart';
import '../../invoice/domain/usecase/add_invoice_usecase.dart';
import '../../invoice/domain/usecase/get_document_usecase.dart';
import '../../invoice/domain/usecase/invoice_delete_usecase.dart';
import '../../invoice/presentation/add_new_invoice_page.dart';
import '../../../core/models/country_model.dart';
import '../../invoice/presentation/widgets/invoice_add_client_widget.dart';
import '../../invoice/presentation/widgets/invoice_client_details_widget.dart';
import '../../invoice/presentation/widgets/invoice_lineitem_widget.dart';
import '../../invoice/presentation/widgets/itemdetails_amount_section_widget.dart';
import '../domain/entities/proforma_details_entity.dart';
import '../domain/usecase/proforma_list_usecase.dart';
import 'bloc/proforma_bloc.dart';
import '../../pdfviewer/presentation/widgets/pdf_signature_input_dialog.dart';
import 'widgets/profirma_add_basic_details_widget.dart';
import 'widgets/proforma_info_widget.dart';

enum EnumNewProformaType {
  new_proforma,
  editProforma,
  duplicateProforma,
}

extension EnumNewProformaTypeExtension on EnumNewProformaType {
  String getName() {
    return "Proforma";
  }

  String getTitle() {
    switch (this) {
      case EnumNewProformaType.new_proforma:
        return "New Proforma";
      case EnumNewProformaType.editProforma:
        return "Edit Proforma";
      case EnumNewProformaType.duplicateProforma:
        return "Duplicate Proforma";
    }
  }
}

@RoutePage()
class AddProformaPage extends StatefulWidget {
  final InvoiceEntity? proformaEntity;
  final EnumNewProformaType type;
  final Function() refreshCallBack;
  final Function() startObserveBlocBack;
  final Function() deletedItem;

  const AddProformaPage({
    super.key,
    this.proformaEntity,
    required this.type,
    required this.refreshCallBack,
    required this.startObserveBlocBack,
    required this.deletedItem,
  });

  @override
  State<AddProformaPage> createState() => _AddProformaPageState();
}

class _AddProformaPageState extends State<AddProformaPage>
    with SectionAdapterMixin {
  final ImagePicker _imagePicker = ImagePicker();
  TextEditingController notesController = TextEditingController();
  ProformaRequestModel proformaRequestModel = ProformaRequestModel();
  String terms = "";
  ClientEntity? selectedClient;
  ProjectEntity? selectedProject;
  List<ProformaStaffEntity> myStaffList = [];
  List<ProformaStaffEntity> clientStaff = [];

  List<ProformaStaffEntity> selectedMyStaffList = [];
  List<ProformaStaffEntity> selectedClientStaff = [];
  ProformaDetailResEntity? proformaDetailsResEntity;
  List<InvoiceItemEntity> selectedLineItems = [];
  List<ProformaTaxEntity> taxesList = [];
  List<ItemTaxInfo> selectedItemTaxesList = [];
  String subTotal = "0.00";
  String netTotal = "0.00";
  String totalDiscount = "0.00";
  String totalFinalTaxAmountVal = "0.00";
  ShippingDiscountModel shippingDiscountModel = ShippingDiscountModel(
      discount: "0.00", shipping: "0.00", isPercentage: false);
  bool isProformaDetailsLoading = false;
  bool hasAttachments = false;
  bool hasProformaSignature = false;
  String proformaSignature = "";
  Uint8List? localProformaSignatureBytes;
  Uint8List? localAttachmentBytes;
  String? localAttachmentName;
  bool localAttachmentIsImage = false;
  String currentUserName = "";
  String organizationCurrencyCode = "";
  String organizationCurrency = "";
  List<CountryModel> countries = [];
  final TextEditingController exchangeRateController = TextEditingController();
  bool isOpeningSignatureDialog = false;

  void _syncMyStaffSelections(List<ProformaStaffEntity> staffList) {
    myStaffList = staffList;
    selectedMyStaffList = myStaffList
        .where((returnedItem) => returnedItem.selected == true)
        .toList();
  }

  void _syncSelectedClientStaffFromInvoice(InvoiceEntity? proformaEntity) {
    final preselectedClientStaff = (proformaEntity?.emailtoClientstaff ?? [])
        .map((returnedItem) =>
            ProformaStaffEntity.fromInvoiceStaff(returnedItem))
        .toList();

    selectedClientStaff = preselectedClientStaff
        .where((returnedItem) => returnedItem.selected == true)
        .toList();

    if (selectedClientStaff.isEmpty) {
      selectedClientStaff = preselectedClientStaff;
    }
  }

  void _syncFetchedClientStaffSelections(List<ProformaStaffEntity> staffList) {
    final selectedIds = selectedClientStaff
        .map((returnedItem) => returnedItem.id)
        .whereType<String>()
        .toSet();

    clientStaff = staffList.map((returnedItem) {
      final isSelected = selectedIds.contains(returnedItem.id) ||
          (selectedIds.isEmpty && returnedItem.selected == true);
      return ProformaStaffEntity(
        email: returnedItem.email,
        id: returnedItem.id,
        name: returnedItem.name,
        selected: isSelected,
      );
    }).toList();

    selectedClientStaff = clientStaff
        .where((returnedItem) => returnedItem.selected == true)
        .toList();
  }

  void calculateListOfTaxes() {
    if (selectedLineItems.isEmpty) {
      subTotal = "0.00";
      netTotal = "0.00";
      totalDiscount = "0.00";
      selectedItemTaxesList = [];
      return;
    }
    selectedItemTaxesList = [];
    double totalSubAmount = 0;

    for (final item in selectedLineItems) {
      final amount = item.amount ?? "0";
      final amountAsDouble = double.parse(amount);

      totalSubAmount += amountAsDouble;

      if (item.taxes != null && item.taxes!.isNotEmpty) {
        for (final tax in item.taxes!) {
          final rate = tax.rate ?? 0;
          final taxValue = (rate / 100) * amountAsDouble;

          final index = selectedItemTaxesList.indexWhere((returnedItem) {
            return returnedItem.id == tax.id;
          });
          if (index >= 0) {
            final amount = selectedItemTaxesList[index].amount;
            final appendAmount = taxValue + amount;
            selectedItemTaxesList[index] = ItemTaxInfo(
              id: tax.id ?? "",
              amount: appendAmount,
              name: tax.name ?? "",
              rate: tax.rate.toString(),
            );
          } else {
            selectedItemTaxesList.add(ItemTaxInfo(
              id: tax.id ?? "",
              amount: taxValue,
              name: tax.name ?? "",
              rate: tax.rate.toString(),
            ));
          }
        }
      }
    }

    subTotal = totalSubAmount.toStringAsFixed(2);
    final discountRate = double.parse(shippingDiscountModel.discount);
    final discountValue = (discountRate / 100) * totalSubAmount;
    totalDiscount = discountValue.toStringAsFixed(2);
    debugPrint("Total Dis: $totalDiscount");

    final finalTaxAmountValue =
        selectedItemTaxesList.fold(0.0, (sum, item) => sum + item.amount);
    final shipping = double.parse(shippingDiscountModel.shipping);
    totalFinalTaxAmountVal = finalTaxAmountValue.toStringAsFixed(2);
    final netTotalAmount =
        (totalSubAmount + finalTaxAmountValue + shipping) - discountValue;
    netTotal = netTotalAmount.toStringAsFixed(2);
  }

  @override
  void initState() {
    _loadCurrentUserName();
    _loadOrganizationCurrency();
    _loadCountries();
    _loadCurrencySymbols();
    if (isNewProforma()) {
      context.read<ProformaBloc>().add(GetProformaDetailsEvent(
          params: ProformaDetailsReqParams(id: "0", duplicate: "")));
    } else {
      if (widget.type == EnumNewProformaType.duplicateProforma) {
        context.read<ProformaBloc>().add(GetProformaDetailsEvent(
            params: ProformaDetailsReqParams(
                id: "0", duplicate: widget.proformaEntity?.id ?? "")));
      }
      populateData();
    }
    super.initState();
  }

  String get displayCurrencyCode {
    final clientCurrency = (selectedClientCurrencyCode ?? '').trim();
    if (clientCurrency.isNotEmpty) {
      return clientCurrency;
    }

    final organizationCode = organizationCurrencyCode.trim();
    if (organizationCode.isNotEmpty) {
      return organizationCode;
    }

    return organizationCurrency.trim();
  }

  String get displayCurrencyPrefix {
    final currencyCode = displayCurrencyCode;
    if (currencyCode.isEmpty) {
      return r'$';
    }

    final symbol = CurrencyHelper().getSymbolById(currencyCode)?.trim();
    if (symbol != null && symbol.isNotEmpty) {
      return symbol;
    }

    return '$currencyCode ';
  }

  String formatCurrencyAmount(String? amount) {
    final resolvedAmount = (amount ?? '0.00').trim();
    return '$displayCurrencyPrefix$resolvedAmount';
  }

  String formatCurrencyAmountFromDouble(double amount) {
    return '$displayCurrencyPrefix${amount.toStringAsFixed(2)}';
  }

  String? get selectedClientCurrencyCode {
    final currencyCode = (selectedClient?.currencyCode ?? '').trim();
    if (currencyCode.isNotEmpty) {
      return currencyCode;
    }

    final currency = (selectedClient?.currency ?? '').trim();
    if (currency.isNotEmpty) {
      return currency;
    }

    return _getCountryCurrencyCode(selectedClient);
  }

  String? _getCountryCurrencyCode(ClientEntity? client) {
    if (client == null || countries.isEmpty) {
      return null;
    }

    final clientCountryId = (client.countryId ?? '').trim();
    if (clientCountryId.isNotEmpty) {
      final country = countries.cast<CountryModel?>().firstWhere(
            (returnedCountry) =>
                (returnedCountry?.countryId ?? '').trim() == clientCountryId,
            orElse: () => null,
          );
      final currency = (country?.currency ?? '').trim();
      if (currency.isNotEmpty) {
        return currency;
      }
    }

    final clientCountryName = (client.countryName ?? '').trim().toLowerCase();
    if (clientCountryName.isNotEmpty) {
      final country = countries.cast<CountryModel?>().firstWhere(
            (returnedCountry) =>
                (returnedCountry?.name ?? '').trim().toLowerCase() ==
                clientCountryName,
            orElse: () => null,
          );
      final currency = (country?.currency ?? '').trim();
      if (currency.isNotEmpty) {
        return currency;
      }
    }

    return null;
  }

  bool get shouldShowExchangeRate {
    final baseCurrency = organizationCurrencyCode.trim().isNotEmpty
        ? organizationCurrencyCode.trim()
        : organizationCurrency.trim();
    final clientCurrency = (selectedClientCurrencyCode ?? '').trim();

    if (baseCurrency.isEmpty || clientCurrency.isEmpty) {
      return false;
    }

    return baseCurrency.toLowerCase() != clientCurrency.toLowerCase();
  }

  Future<void> _loadOrganizationCurrency() async {
    final session = await HiveFunctions.getUserSessionData();
    final organization = session?.organization;

    if (!mounted) {
      return;
    }

    setState(() {
      organizationCurrencyCode = (organization?.currencyCode ?? '').trim();
      organizationCurrency = (organization?.currency ?? '').trim();
      _syncExchangeRateValue();
    });
  }

  Future<void> _loadCurrencySymbols() async {
    await CurrencyHelper().loadCurrencies();

    if (!mounted) {
      return;
    }

    setState(() {});
  }

  Future<void> _loadCountries() async {
    final response = await rootBundle.loadString('assets/files/countries.json');
    final countryData = countryMainDataModelFromJson(response).country ?? [];

    if (!mounted) {
      return;
    }

    setState(() {
      countries = countryData;
      _syncExchangeRateValue();
    });
  }

  void _syncExchangeRateValue({String? existingExchangeRate}) {
    if (!shouldShowExchangeRate) {
      exchangeRateController.clear();
      return;
    }

    final resolvedExchangeRate = (existingExchangeRate ?? '').trim();
    if (resolvedExchangeRate.isNotEmpty) {
      exchangeRateController.text = resolvedExchangeRate;
      return;
    }

    if (exchangeRateController.text.trim().isEmpty) {
      exchangeRateController.text = '1';
    }
  }

  Future<void> _loadCurrentUserName() async {
    final session = await HiveFunctions.getUserSessionData();
    final user = session?.user;
    final resolvedName = (user?.name ?? '').trim().isNotEmpty
        ? (user?.name ?? '').trim()
        : (user?.firstname ?? '').trim().isNotEmpty
            ? (user?.firstname ?? '').trim()
            : (user?.email ?? '').trim();

    if (!mounted) {
      return;
    }

    setState(() {
      currentUserName = resolvedName;
    });
  }

  Future<void> _openProformaSignaturePicker() async {
    if (isOpeningSignatureDialog) {
      return;
    }

    isOpeningSignatureDialog = true;
    try {
      final signatureBytes = await showPdfSignatureInputDialog(
        context,
        userName: currentUserName,
      );

      if (signatureBytes == null || !mounted) {
        return;
      }

      setState(() {
        localProformaSignatureBytes = signatureBytes;
        hasProformaSignature = true;
      });
    } finally {
      isOpeningSignatureDialog = false;
    }
  }

  Future<void> _showProformaAttachmentOptions() async {
    await showModalBottomSheet<void>(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.attach_file_outlined),
                title: Text(
                  'Add file',
                  style: AppFonts.regularStyle(),
                ),
                onTap: () async {
                  Navigator.of(context).pop();
                  await _pickAttachmentFile();
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt_outlined),
                title: Text(
                  'Take image',
                  style: AppFonts.regularStyle(),
                ),
                onTap: () async {
                  Navigator.of(context).pop();
                  await _pickAttachmentImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library_outlined),
                title: Text(
                  'Pick from gallery',
                  style: AppFonts.regularStyle(),
                ),
                onTap: () async {
                  Navigator.of(context).pop();
                  await _pickAttachmentImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickAttachmentImage(ImageSource source) async {
    final image = await _imagePicker.pickImage(
      source: source,
      imageQuality: 85,
    );

    if (image == null) {
      return;
    }

    final bytes = await image.readAsBytes();
    if (!mounted) {
      return;
    }

    setState(() {
      localAttachmentBytes = bytes;
      localAttachmentName = image.name;
      localAttachmentIsImage = true;
      hasAttachments = true;
    });
  }

  Future<void> _pickAttachmentFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
      withData: true,
    );

    if (result == null || result.files.isEmpty) {
      return;
    }

    final file = result.files.first;
    Uint8List? bytes = file.bytes;

    if (bytes == null && file.path != null && file.path!.isNotEmpty) {
      bytes = await File(file.path!).readAsBytes();
    }

    if (!mounted) {
      return;
    }

    if (bytes == null) {
      showToastification(
        context,
        'Unable to read selected file.',
        ToastificationType.error,
      );
      return;
    }

    setState(() {
      localAttachmentBytes = bytes;
      localAttachmentName = file.name;
      localAttachmentIsImage = _isImageFile(file.name);
      hasAttachments = true;
    });
  }

  bool _isImageFile(String fileName) {
    final lower = fileName.toLowerCase();
    return lower.endsWith('.jpg') ||
        lower.endsWith('.jpeg') ||
        lower.endsWith('.png') ||
        lower.endsWith('.gif') ||
        lower.endsWith('.webp');
  }

  DateTime? getDateFrom(String? dateStr) {
    if (dateStr == null) {
      return null;
    }
    try {
      final date = DateTime.parse(dateStr);
      debugPrint("DATE: ${date.toString()}");
      return date;
    } catch (e) {
      debugPrint("Unable to parse date string: ${e.toString()}");
      return null;
    }
  }

  void populateData() {
    selectedClient = ClientEntity(
      id: widget.proformaEntity?.clientId,
      clientId: widget.proformaEntity?.clientId,
      name: widget.proformaEntity?.clientName,
      address: widget.proformaEntity?.clientAddress,
      currency: widget.proformaEntity?.currency,
      currencyCode: widget.proformaEntity?.currency,
    );
    _syncMyStaffSelections((widget.proformaEntity?.emailtoMystaff ?? [])
        .map((returnedItem) =>
            ProformaStaffEntity.fromInvoiceStaff(returnedItem))
        .toList());
    var itemListss = widget.proformaEntity?.items ?? [];
    List<InvoiceItemEntity> convertedListt = [];
    for (final item in itemListss) {
      convertedListt.add(InvoiceItemEntity(
          itemId: item.itemId,
          type: item.type,
          itemName: item.itemName,
          description: item.description,
          date: item.date,
          time: item.time,
          custom: item.custom,
          qty: item.qty,
          unit: item.unit,
          rate: item.rate,
          discountType: item.discountType,
          discountValue: item.discountValue,
          isTaxable: item.isTaxable,
          taxes: item.taxes,
          amount: item.amount));
    }

    selectedLineItems = convertedListt;

    proformaRequestModel = ProformaRequestModel(
      no: widget.proformaEntity?.no ?? "",
      heading: widget.proformaEntity?.heading ?? "",
      title: widget.proformaEntity?.summary ?? "",
      expiryDate: getDateFrom(widget.proformaEntity?.expirydateYmd),
      date: widget.proformaEntity?.dateYmd,
    );
    terms = widget.proformaEntity?.terms ?? "";

    _syncSelectedClientStaffFromInvoice(widget.proformaEntity);
    if (widget.proformaEntity?.clientId != null) {
      getClientStaffBy(widget.proformaEntity?.clientId ?? "");
    }
    selectedProject = ProjectEntity(
        id: widget.proformaEntity?.projectId ?? "",
        name: widget.proformaEntity?.projectName ?? "");
    subTotal = widget.proformaEntity?.subtotal ?? "";
    netTotal = widget.proformaEntity?.nettotal ?? "";
    totalDiscount = widget.proformaEntity?.discount ?? "";
    final discountType = widget.proformaEntity?.shipping ?? "";
    bool isPercentage = false;

    if (discountType == "0") {
      isPercentage = true;
    } else if (discountType == "1") {
      isPercentage = false;
    }
    shippingDiscountModel = ShippingDiscountModel(
        discount: widget.proformaEntity?.discountValue ?? "",
        shipping: widget.proformaEntity?.shipping ?? "",
        isPercentage: isPercentage);
    notesController.text = widget.proformaEntity?.notes ?? "";
    _updateAdditionalVisibility(widget.proformaEntity);
    _syncExchangeRateValue(
        existingExchangeRate: widget.proformaEntity?.exchangeRate?.toString());

    calculateListOfTaxes();
    setState(() {});
  }

  void populateDataFromProformaResponse(InvoiceEntity? proformaEntity) {
    if (proformaEntity == null) {
      return;
    }

    selectedClient = ClientEntity(
      id: proformaEntity.clientId,
      clientId: proformaEntity.clientId,
      name: proformaEntity.clientName,
      address: proformaEntity.clientAddress,
      currency: proformaEntity.currency,
      currencyCode: proformaEntity.currency,
    );
    _syncMyStaffSelections((proformaEntity.emailtoMystaff ?? [])
        .map((returnedItem) =>
            ProformaStaffEntity.fromInvoiceStaff(returnedItem))
        .toList());

    selectedLineItems = proformaEntity.items ?? [];

    proformaRequestModel = ProformaRequestModel(
      no: proformaEntity.no ?? "",
      heading: proformaEntity.heading ?? "",
      title: proformaEntity.summary ?? "",
      expiryDate: getDateFrom(proformaEntity.expirydateYmd),
      date: proformaEntity.dateYmd,
    );
    terms = proformaEntity.terms ?? "";

    _syncSelectedClientStaffFromInvoice(proformaEntity);

    if (proformaEntity.clientId != null) {
      getClientStaffBy(proformaEntity.clientId ?? "");
    }

    selectedProject = ProjectEntity(
      id: proformaEntity.projectId ?? "",
      name: proformaEntity.projectName ?? "",
    );

    subTotal = proformaEntity.subtotal ?? "0.00";
    netTotal = proformaEntity.nettotal ?? "0.00";
    totalDiscount = proformaEntity.discount ?? "0.00";

    final discountType = proformaEntity.shipping ?? "";
    bool isPercentage = false;
    if (discountType == "0") {
      isPercentage = true;
    } else if (discountType == "1") {
      isPercentage = false;
    }

    shippingDiscountModel = ShippingDiscountModel(
      discount: proformaEntity.discountValue ?? "0.00",
      shipping: proformaEntity.shipping ?? "0.00",
      isPercentage: isPercentage,
    );
    notesController.text = proformaEntity.notes ?? "";
    _updateAdditionalVisibility(proformaEntity);
    _syncExchangeRateValue(
        existingExchangeRate: proformaEntity.exchangeRate?.toString());

    calculateListOfTaxes();
    setState(() {});
  }

  void _updateAdditionalVisibility(InvoiceEntity? proformaEntity) {
    hasAttachments = proformaEntity?.isAttachments == true;
    proformaSignature =
        (proformaEntity?.proformaSignature ?? "").replaceAll('\n', '').trim();
    hasProformaSignature = proformaSignature.isNotEmpty &&
        (proformaEntity?.isProformaSignature == true ||
            proformaSignature.isNotEmpty);
  }

  void addProforma() {
    if (shouldShowExchangeRate && exchangeRateController.text.trim().isEmpty) {
      showToastification(
        context,
        'Please enter the exchange rate.',
        ToastificationType.error,
      );
      return;
    }

    final reqParams = AddInvoiceReqParms(
      type: EnumNewInvoiceEstimateType.invoice,
      terms: terms,
      selectedClient: selectedClient,
      notes: notesController.text,
      invoiceRequestModel: InvoiceRequestModel(
        no: proformaRequestModel.no,
        heading: proformaRequestModel.heading,
        title: proformaRequestModel.title,
        date: proformaRequestModel.date,
        expiryDate: proformaRequestModel.expiryDate,
      ),
      selectedMyStaffList: selectedMyStaffList
          .map((returnedItem) => EmailtoMystaffEntity(
                id: returnedItem.id,
                name: returnedItem.name,
                email: returnedItem.email,
                selected: returnedItem.selected,
              ))
          .toList(),
      selectedClientStaff: selectedClientStaff
          .map((returnedItem) => EmailtoMystaffEntity(
                id: returnedItem.id,
                name: returnedItem.name,
                email: returnedItem.email,
                selected: returnedItem.selected,
              ))
          .toList(),
      selectedLineItems: selectedLineItems,
      selectedProject: selectedProject,
      discount: totalDiscount,
      discountType: shippingDiscountModel.isPercentage ? "0" : "1",
      discountValue: shippingDiscountModel.discount,
      netTotal: netTotal,
      shipping: shippingDiscountModel.shipping,
      subTotal: subTotal,
      taxTotal: totalFinalTaxAmountVal,
      id: doNeedToPassId() ? widget.proformaEntity?.id ?? "" : "",
      currency: shouldShowExchangeRate ? selectedClientCurrencyCode : null,
      exchangeRate:
          shouldShowExchangeRate ? exchangeRateController.text.trim() : null,
    );

    context.read<InvoiceBloc>().add(AddInvoiceEstimateEvent(params: reqParams));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppPallete.kF2F2F2,
        appBar: AppBar(
          title: Text(widget.type.getTitle()),
          bottom: AppConstants.getAppBarDivider,
          leading: IconButton(
              onPressed: () {
                widget.startObserveBlocBack();
                AutoRouter.of(context).maybePop();
              },
              icon: const Icon(
                Icons.close,
                color: AppPallete.blueColor,
              )),
          actions: [
            TextButton(
                onPressed: () {
                  addProforma();
                },
                child: Text(
                  "Save",
                  style: AppFonts.regularStyle(color: AppPallete.blueColor),
                ))
          ],
        ),
        body: BlocListener<ProformaBloc, ProformaState>(
          listener: (context, state) {
            if (state is ProformaDetailsLoadingState) {
              isProformaDetailsLoading = true;
              setState(() {});
              return;
            }

            if (state is ProformaDetailsSuccessState) {
              isProformaDetailsLoading = false;
              final proformaEntity = state.proformaDetailResEntity.proforma;

              debugPrint(
                  "ProformaDetailSuccessState: ${proformaEntity?.no ?? "No proforma number"}");

              taxesList = state.proformaDetailResEntity.taxes ?? [];
              _syncMyStaffSelections((proformaEntity?.emailtoMystaff ?? [])
                  .map((returnedItem) =>
                      ProformaStaffEntity.fromInvoiceStaff(returnedItem))
                  .toList());
              _syncSelectedClientStaffFromInvoice(proformaEntity);
              _updateAdditionalVisibility(proformaEntity);
              proformaDetailsResEntity = state.proformaDetailResEntity;
              if (widget.type == EnumNewProformaType.duplicateProforma) {
                populateDataFromProformaResponse(proformaEntity);
              } else {
                proformaRequestModel.no = proformaEntity?.no;
                proformaRequestModel.heading = proformaEntity?.heading;
                setState(() {});
              }
            } else if (state is ProformaDetailsFailureState) {
              isProformaDetailsLoading = false;
              showToastification(
                  context, state.errorMessage, ToastificationType.error);
              setState(() {});
            }
          },
          child: BlocConsumer<InvoiceBloc, InvoiceState>(
            listener: (context, state) {
              if (state is ClientStaffSuccessState) {
                final clientStaffList =
                    state.clientStaffMainResEntity.data?.staffs ?? [];
                _syncFetchedClientStaffSelections(
                    clientStaffList.map((returnedItem) {
                  return ProformaStaffEntity(
                      email: returnedItem.email,
                      id: returnedItem.id,
                      name: returnedItem.name,
                      selected: returnedItem.primary);
                }).toList());
              }
              if (state is InvoiceDeleteErrorState) {
                showToastification(
                    context, state.errorMessage, ToastificationType.error);
              }

              if (state is InvoiceDeleteSuccessState) {
                showToastification(
                    context,
                    state.invoiceDeleteMainResEntity.data?.message ??
                        "Successfully deleted",
                    ToastificationType.success);
                widget.deletedItem();
                AutoRouter.of(context).popUntilRoot();
              }

              if (state is InvoiceEstimateAddErrorState) {
                showToastification(
                    context, state.errorMessage, ToastificationType.error);
              }

              if (state is InvoiceEstimateAddSuccessState) {
                showToastification(
                    context,
                    state.addInvoiceMainResEntity.data?.message ??
                        "Successfully added proforma.",
                    ToastificationType.success);
                widget.refreshCallBack();
                AutoRouter.of(context).maybePop();
              }
            },
            builder: (context, state) {
              if (state is InvoiceDeleteLoadingState) {
                return const LoadingPage(title: "Deleting proforma..");
              }
              if (state is InvoiceEstimateAddLoadingState) {
                return LoadingPage(
                    title:
                        "${isEdit() ? "Updating" : "Adding"} proforma data..");
              }
              if (isProformaDetailsLoading) {
                return const LoadingPage(title: "Loading proforma data..");
              }
              return SectionListView.builder(
                adapter: this,
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
              );
            },
          ),
        ));
  }

  Widget getTaxCell(BuildContext context,
      {required String title,
      required String subTitle,
      required String value,
      bool isTotal = false,
      bool isSubTotal = false}) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: isSubTotal
              ? Text(
                  title,
                  textAlign: TextAlign.end,
                  style: AppFonts.mediumStyle(size: 16),
                )
              : RichText(
                  textAlign: TextAlign.end,
                  text: TextSpan(
                      text: title,
                      style: isTotal
                          ? AppFonts.mediumStyle(
                              size: 16, color: AppPallete.blueColor)
                          : AppFonts.regularStyle(),
                      children: [
                        const TextSpan(text: " "),
                        TextSpan(
                            text: subTitle,
                            style: AppFonts.regularStyle(
                                color: AppPallete.k666666))
                      ])),
        ),
        Expanded(
          flex: 2,
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: isSubTotal
                ? AppFonts.mediumStyle(size: 16)
                : AppFonts.mediumStyle(
                    size: 16,
                    color:
                        isTotal ? AppPallete.blueColor : AppPallete.textColor,
                  ),
          ),
        )
      ],
    );
  }

  Widget getItemFooter(BuildContext context) {
    return Container(
      color: AppPallete.white,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          AppConstants.sizeBoxHeight15,
          GestureDetector(
            onTap: () {
              debugPrint("Open Add New Line Item Screen");
              _openLineitem(null, null);
            },
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      const Icon(
                        Icons.add_circle,
                        color: AppPallete.blueColor,
                      ),
                      AppConstants.sizeBoxWidth10,
                      Text(
                        "Add new line",
                        style:
                            AppFonts.regularStyle(color: AppPallete.blueColor),
                      )
                    ],
                  ),
                ),
                const Icon(
                  Icons.chevron_right,
                  color: AppPallete.borderColor,
                )
              ],
            ),
          ),
          AppConstants.sizeBoxHeight15,
          const ItemSeparator(),
          AppConstants.sizeBoxHeight15,
          getTaxCell(context,
              title: "Subtotal",
              subTitle: "",
              value: formatCurrencyAmount(subTotal),
              isSubTotal: true),
          AppConstants.sepSizeBox5,
          getTaxCell(context,
              title: "Discount",
              subTitle: "",
              value: formatCurrencyAmount(totalDiscount),
              isSubTotal: false),
          AppConstants.sepSizeBox5,
          for (var taxItem in selectedItemTaxesList)
            Column(
              children: [
                getTaxCell(context,
                    title: "${taxItem.name} (${taxItem.rate}%)",
                    subTitle: "",
                    value: formatCurrencyAmountFromDouble(taxItem.amount),
                    isSubTotal: false),
                AppConstants.sepSizeBox5,
              ],
            ),
          getTaxCell(context,
              title: "Shipping",
              subTitle: "",
              value: formatCurrencyAmount(shippingDiscountModel.shipping),
              isSubTotal: false),
          AppConstants.sizeBoxHeight15,
          const ItemSeparator(),
          AppConstants.sizeBoxHeight15,
          GestureDetector(
            onTap: () {
              AutoRouter.of(context).push(LineItemTotalSelectionPageRoute(
                  shippingDiscountModel: shippingDiscountModel,
                  currencyPrefix: displayCurrencyPrefix,
                  callBack: (returnedShippingDiscountModel) {
                    shippingDiscountModel = returnedShippingDiscountModel;
                    calculateListOfTaxes();
                    setState(() {});
                  }));
            },
            child: getTaxCell(context,
                title: "Total",
                subTitle: "",
                value: formatCurrencyAmount(netTotal),
                isTotal: true),
          ),
          AppConstants.sizeBoxHeight15,
        ],
      ),
    );
  }

  bool isEdit() {
    return widget.proformaEntity != null;
  }

  void _rerenderUI() {
    setState(() {});
  }

  void _openProject() {
    AutoRouter.of(context).push(ProjectPopupRoute(
        clientId: selectedClient?.clientId,
        selectedClient: selectedClient,
        selectedProject: selectedProject,
        onSelectProject: (project) {
          selectedProject = project;
          setState(() {});
        }));
  }

  void _openLineitem(InvoiceItemEntity? lineItem, int? index) {
    AutoRouter.of(context).push(AddNewLineItemPageRoute(
        updateIndex: index,
        updateLineItem: lineItem,
        taxes: taxesList
            .map((returnedItem) => TaxEntity(
                  id: returnedItem.id,
                  name: returnedItem.name,
                  rate: returnedItem.rate,
                ))
            .toList(),
        enterItemModel: (lineItem, returnedIndex) {
          if (lineItem == null) {
            return;
          }
          if (returnedIndex != null) {
            selectedLineItems[returnedIndex] = lineItem;
          } else {
            selectedLineItems.add(lineItem);
          }
          calculateListOfTaxes();

          setState(() {});
        },
        items: proformaDetailsResEntity?.items));
  }

  void _openClient() {
    AutoRouter.of(context).push(ClientPopupRoute(
        clientListFromParentClass: proformaDetailsResEntity?.clients,
        selectedClient: selectedClient,
        onSelectClient: (client) {
          if (client != null &&
              selectedClient != null &&
              client.clientId == selectedClient?.clientId) {
            return;
          }
          selectedProject = null;
          selectedClientStaff = [];
          selectedClient = client;
          exchangeRateController.clear();
          _syncExchangeRateValue();
          _syncFetchedClientStaffSelections(
              client?.persons?.map((returnedItem) {
                    return ProformaStaffEntity(
                        email: returnedItem.email ?? "",
                        id: returnedItem.id ?? "",
                        name: returnedItem.name ?? "",
                        selected: returnedItem.primary ?? false);
                  }).toList() ??
                  []);
          if (client?.id != null) {
            getClientStaffBy(client?.id ?? "");
          }
          _rerenderUI();
        }));
  }

  void getClientStaffBy(String id) {
    context
        .read<InvoiceBloc>()
        .add(GetClientStaffEvent(params: ClientStaffUsecaseReqParams(id: id)));
  }

  bool doNeedToPassId() {
    switch (widget.type) {
      case EnumNewProformaType.new_proforma:
        return false;
      case EnumNewProformaType.editProforma:
        return true;
      case EnumNewProformaType.duplicateProforma:
        return false;
    }
  }

  bool isNewProforma() {
    if (widget.type == EnumNewProformaType.new_proforma) {
      return true;
    }
    return false;
  }

  void _openEmailTo() {
    AutoRouter.of(context).push(EmailToPageRoute(
        clientStaff: clientStaff
            .map((returnedItem) => EmailtoMystaffEntity(
                  id: returnedItem.id,
                  name: returnedItem.name,
                  email: returnedItem.email,
                  selected: returnedItem.selected,
                ))
            .toList(),
        myStaffList: myStaffList
            .map((returnedItem) => EmailtoMystaffEntity(
                  id: returnedItem.id,
                  name: returnedItem.name,
                  email: returnedItem.email,
                  selected: returnedItem.selected,
                ))
            .toList(),
        selectedClientStaff: selectedClientStaff
            .map((returnedItem) => EmailtoMystaffEntity(
                  id: returnedItem.id,
                  name: returnedItem.name,
                  email: returnedItem.email,
                  selected: returnedItem.selected,
                ))
            .toList(),
        selectedMyStaffList: selectedMyStaffList
            .map((returnedItem) => EmailtoMystaffEntity(
                  id: returnedItem.id,
                  name: returnedItem.name,
                  email: returnedItem.email,
                  selected: returnedItem.selected,
                ))
            .toList(),
        onpressDone: (myStaff, clientStafff) {
          selectedClientStaff = clientStafff
              .map((returnedItem) =>
                  ProformaStaffEntity.fromInvoiceStaff(returnedItem))
              .toList();
          selectedMyStaffList = myStaff
              .map((returnedItem) =>
                  ProformaStaffEntity.fromInvoiceStaff(returnedItem))
              .toList();
          setState(() {});
        }));
  }

  bool _shouldShowAdditionalDocumentInfo() {
    return true;
  }

  int? get _documentInfoSectionIndex =>
      _shouldShowAdditionalDocumentInfo() ? 4 : null;

  int get _termsSectionIndex => _shouldShowAdditionalDocumentInfo() ? 5 : 4;

  int get _deleteSectionIndex => _shouldShowAdditionalDocumentInfo() ? 6 : 5;

  Widget _buildAdditionalDocumentInfo() {
    final shouldShowSignaturePreview =
        localProformaSignatureBytes != null || hasProformaSignature;
    final shouldShowAttachmentPreview =
        localAttachmentBytes != null || hasAttachments;

    return Container(
      color: AppPallete.white,
      padding: AppConstants.horizontalVerticalPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "Proforma Signature",
                  style: AppFonts.mediumStyle(size: 16),
                ),
              ),
              TextButton(
                onPressed: _openProformaSignaturePicker,
                child: Text(
                  shouldShowSignaturePreview ? "Change" : "Add",
                  style: AppFonts.regularStyle(color: AppPallete.blueColor),
                ),
              ),
            ],
          ),
          AppConstants.sizeBoxHeight10,
          InkWell(
            onTap: _openProformaSignaturePicker,
            borderRadius: BorderRadius.circular(8),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: _buildProformaSignaturePreview(),
            ),
          ),
          AppConstants.sizeBoxHeight10,
          Text(
            "Tap above to switch between Signature and Name.",
            style: AppFonts.regularStyle(
              size: 14,
              color: AppPallete.k666666,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Text(
                  "Add File",
                  style: AppFonts.mediumStyle(size: 16),
                ),
              ),
              TextButton(
                onPressed: _showProformaAttachmentOptions,
                child: Text(
                  shouldShowAttachmentPreview ? "Change" : "Add",
                  style: AppFonts.regularStyle(color: AppPallete.blueColor),
                ),
              ),
            ],
          ),
          AppConstants.sizeBoxHeight10,
          InkWell(
            onTap: _showProformaAttachmentOptions,
            borderRadius: BorderRadius.circular(8),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: _buildAttachmentPreview(),
            ),
          ),
          AppConstants.sizeBoxHeight10,
          Text(
            "Tap above to add file, take image, or pick from gallery.",
            style: AppFonts.regularStyle(
              size: 14,
              color: AppPallete.k666666,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProformaSignaturePreview() {
    if (localProformaSignatureBytes != null) {
      return Container(
        width: double.infinity,
        color: AppPallete.white,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Image.memory(
          localProformaSignatureBytes!,
          height: 96,
          fit: BoxFit.contain,
        ),
      );
    }

    if (hasProformaSignature && proformaSignature.isNotEmpty) {
      return Image.network(
        proformaSignature,
        height: 96,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return _buildEmptySignaturePreview(message: "Signature available");
        },
      );
    }

    return _buildEmptySignaturePreview(message: "Add a signature or name");
  }

  Widget _buildEmptySignaturePreview({required String message}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppPallete.kF2F2F2,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        message,
        style: AppFonts.regularStyle(),
      ),
    );
  }

  Widget _buildAttachmentPreview() {
    if (localAttachmentBytes != null && localAttachmentIsImage) {
      return Container(
        width: double.infinity,
        color: AppPallete.white,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Image.memory(
          localAttachmentBytes!,
          height: 96,
          fit: BoxFit.contain,
        ),
      );
    }

    if (localAttachmentBytes != null) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppPallete.kF2F2F2,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.insert_drive_file_outlined,
              color: AppPallete.blueColor,
            ),
            AppConstants.sizeBoxWidth10,
            Expanded(
              child: Text(
                localAttachmentName ?? 'Selected file',
                style: AppFonts.regularStyle(),
              ),
            ),
          ],
        ),
      );
    }

    if (hasAttachments) {
      return _buildEmptySignaturePreview(
        message: "Attachment added to this proforma",
      );
    }

    return _buildEmptySignaturePreview(message: "Add a file or image");
  }

  @override
  Widget getItem(BuildContext context, IndexPath indexPath) {
    if (isEdit() && indexPath.section == _deleteSectionIndex) {
      return Container(
          width: MediaQuery.of(context).size.width,
          color: AppPallete.white,
          child: TextButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AppAlertWidget(
                        title: "Delete Proforma",
                        message:
                            "Are you sure you want to delete this proforma?",
                        onTapDelete: () {
                          debugPrint("on tap delete item");
                          AutoRouter.of(context).maybePop();
                          _deleteProforma();
                        },
                      );
                    });
              },
              child: Text(
                "Delete",
                style: AppFonts.regularStyle(color: AppPallete.red),
              )));
    }
    if (indexPath.section == 0) {
      return GestureDetector(
        child: ProformaInfoWidget(
          invoiceStatusColor: widget.proformaEntity?.statusColor,
          proformaRequestModel: proformaRequestModel,
        ),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              fullscreenDialog: true,
              builder: (_) => ProfirmaAddBasicDetailsWidget(
                proformaRequestModel: proformaRequestModel,
                callback: () {
                  setState(() {});
                },
              ),
            ),
          );
        },
      );
    } else if (indexPath.section == 1) {
      if (selectedClient != null) {
        return InvoiceClientDetailsWidget(
          clientEntity: selectedClient!,
          onTapOpenEmailTo: () {
            _openEmailTo();
          },
          onTapOpenProjects: () {
            _openProject();
          },
          onTapOpenSelectClient: () {
            _openClient();
          },
          projectValue: selectedProject?.name,
          emailToVlaue:
              "${selectedClientStaff.length + selectedMyStaffList.length} of ${clientStaff.length + myStaffList.length} Contacts",
          showExchangeRate: shouldShowExchangeRate,
          clientCurrencyCode: selectedClientCurrencyCode,
          baseCurrencyCode: organizationCurrencyCode.isNotEmpty
              ? organizationCurrencyCode
              : organizationCurrency,
          exchangeRateController: exchangeRateController,
        );
      }
      return InvoiceAddClientWidget(
        onPress: () {
          _openClient();
        },
      );
    } else if (indexPath.section == 3) {
      return NotesWidget(
        controller: notesController,
        title: "Notes",
        hintText: "Will be displayed on the proforma",
      );
    } else if (indexPath.section == _termsSectionIndex) {
      return TermsCardWidget(
        onPress: () {
          AutoRouter.of(context).push(InvoiceEstimateTermsInoutPageRoute(
              terms: terms,
              callback: (val) {
                terms = val;
                setState(() {});
              }));
        },
      );
    } else if (indexPath.section == _documentInfoSectionIndex) {
      return _buildAdditionalDocumentInfo();
    } else if (indexPath.section == 2) {
      final item = selectedLineItems[indexPath.item];
      return GestureDetector(
        onTap: () {
          debugPrint("selectedLineItems: ${item.description}");
          _openLineitem(item, indexPath.item);
        },
        child: SwipeActionCell(
          key: ObjectKey(item),
          trailingActions: [
            SwipeAction(
                style: AppFonts.regularStyle(color: AppPallete.white),
                title: "Delete",
                onTap: (CompletionHandler handler) async {
                  selectedLineItems.remove(item);
                  calculateListOfTaxes();
                  setState(() {});
                },
                color: Colors.red),
          ],
          child: InvoiceLineitemWidget(
            itemListEntity: item,
            currencyPrefix: displayCurrencyPrefix,
          ),
        ),
      );
    }
    return const SizedBox();
  }

  void _deleteProforma() {
    if (widget.proformaEntity != null && widget.proformaEntity!.id != null) {
      context.read<InvoiceBloc>().add(InvoiceDeleteEvent(
              params: InvoiceDeleteReqParms(
            id: widget.proformaEntity?.id ?? "",
            type: EnumDocumentType.invoice,
          )));
    }
  }

  @override
  int numberOfSections() {
    int totalSections = 5;
    if (_shouldShowAdditionalDocumentInfo()) {
      totalSections += 1;
    }
    if (isEdit()) {
      totalSections += 1;
    }
    return totalSections;
  }

  @override
  bool shouldExistSectionHeader(int section) {
    return true;
  }

  @override
  bool shouldExistSectionFooter(int section) {
    if (section == 2) {
      return true;
    }
    return false;
  }

  @override
  Widget getSectionFooter(BuildContext context, int section) {
    if (section == 2) {
      return getItemFooter(context);
    }
    return const SizedBox();
  }

  @override
  Widget getSectionHeader(BuildContext context, int section) {
    if (section == 0) {
      return const SepHeader10hF2F2F2Widget();
    } else if (section == 1) {
      return const SectionHeaderWidget(title: "Client Details");
    } else if (section == 2) {
      return const ItemDetailsAmountSectionWidget();
    } else {
      return const SepHeader10hF2F2F2Widget();
    }
  }

  @override
  int numberOfItems(int section) {
    if (section == 2) {
      debugPrint("selectedLineItems length: ${selectedLineItems.length}");
      return selectedLineItems.length;
    }
    return 1;
  }
}

class SepHeader10hF2F2F2Widget extends StatelessWidget {
  const SepHeader10hF2F2F2Widget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10,
      color: AppPallete.kF2F2F2,
    );
  }
}

class ProformaRequestModel {
  String? no;
  String? heading;
  String? title;
  DateTime? date;
  DateTime? expiryDate;

  ProformaRequestModel({
    this.no,
    this.heading,
    this.title,
    this.date,
    this.expiryDate,
  });
}

class ItemTaxInfo {
  final String id;
  final String name;
  final String rate;
  final double amount;
  ItemTaxInfo({
    required this.id,
    required this.amount,
    required this.name,
    required this.rate,
  });
}
