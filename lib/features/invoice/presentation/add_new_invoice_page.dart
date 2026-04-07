import 'package:auto_route/auto_route.dart';
import 'dart:io';
import 'package:billbooks_app/core/app_constants.dart';
import 'package:billbooks_app/core/models/country_model.dart';
import 'package:billbooks_app/core/theme/app_fonts.dart';
import 'package:billbooks_app/core/theme/app_pallete.dart';
import 'package:billbooks_app/core/utils/hive_functions.dart';
import 'package:billbooks_app/core/utils/show_toast.dart';
import 'package:billbooks_app/core/widgets/item_separator.dart';
import 'package:billbooks_app/core/widgets/loading_page.dart';
import 'package:billbooks_app/core/widgets/section_header_widget.dart';
import 'package:billbooks_app/features/clients/domain/entities/client_list_entity.dart';
import 'package:billbooks_app/features/clients/domain/usecase/client_usecase.dart';
import 'package:billbooks_app/features/clients/presentation/bloc/client_bloc.dart';
import 'package:billbooks_app/features/invoice/data/models/invoice_details_model.dart';
import 'package:billbooks_app/features/invoice/domain/entities/delivery_options_model.dart';
import 'package:billbooks_app/features/invoice/domain/entities/invoice_list_entity.dart';
import 'package:billbooks_app/features/invoice/domain/usecase/client_staff_usecase.dart';
import 'package:billbooks_app/features/invoice/domain/usecase/invoice_usecase.dart';
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
import 'dart:convert';
import '../../../core/utils/utils.dart';
import '../../../core/widgets/app_alert_widget.dart';
import '../../../core/widgets/notes_widget.dart';
import '../../../core/widgets/terms_card_widget.dart';
import '../../../router/app_router.dart';
import '../domain/entities/invoice_details_entity.dart';
import '../domain/entities/payment_reminder_model.dart';
import '../domain/entities/payment_terms_model.dart';
import '../domain/entities/repeat_every_model.dart';
import '../domain/entities/time_zone_model.dart';
import '../domain/usecase/add_invoice_usecase.dart';
import '../domain/usecase/get_document_usecase.dart';
import '../domain/usecase/invoice_delete_usecase.dart';
import 'widgets/invoice_add_client_widget.dart';
import 'widgets/invoice_client_details_widget.dart';
import 'widgets/invoice_info_widget.dart';
import 'widgets/invoice_lineitem_widget.dart';
import 'widgets/itemdetails_amount_section_widget.dart';

enum EnumNewInvoiceEstimateType {
  invoice,
  estimate,
  editInvoice,
  editEstimate,
  duplicateEstimate,
  duplicateInvoice,
  convertEstimateToInvoice,
  convertProformaToInvoice,
}

extension EnumNewInvoiceEstimateTypeExtension on EnumNewInvoiceEstimateType {
  String getName({required String estimateTitle}) {
    switch (this) {
      case EnumNewInvoiceEstimateType.estimate ||
            EnumNewInvoiceEstimateType.duplicateEstimate:
        return estimateTitle;
      case EnumNewInvoiceEstimateType.invoice ||
            EnumNewInvoiceEstimateType.convertEstimateToInvoice ||
            EnumNewInvoiceEstimateType.convertProformaToInvoice ||
            EnumNewInvoiceEstimateType.duplicateInvoice:
        return "Invoice";
      case EnumNewInvoiceEstimateType.editEstimate:
        return estimateTitle;
      case EnumNewInvoiceEstimateType.editInvoice:
        return "Invoice";
    }
  }

  String getTitle(String estimateTitle) {
    switch (this) {
      case EnumNewInvoiceEstimateType.estimate ||
            EnumNewInvoiceEstimateType.duplicateEstimate:
        return "New $estimateTitle";
      case EnumNewInvoiceEstimateType.invoice ||
            EnumNewInvoiceEstimateType.convertEstimateToInvoice ||
            EnumNewInvoiceEstimateType.convertProformaToInvoice ||
            EnumNewInvoiceEstimateType.duplicateInvoice:
        return "New Invoice";
      case EnumNewInvoiceEstimateType.editEstimate:
        return "Edit $estimateTitle";
      case EnumNewInvoiceEstimateType.editInvoice:
        return "Edit Invoice";
    }
  }
}

@RoutePage()
class AddNewInvoiceEstimatePage extends StatefulWidget {
  final InvoiceDetailResEntity? invoiceDetailResEntity;
  final InvoiceEntity? invoiceEntity;
  final EnumNewInvoiceEstimateType type;
  final Function() refreshCallBack;
  final Function() startObserveBlocBack;
  final Function() deletedItem;

  final String estimateTitle;
  const AddNewInvoiceEstimatePage({
    super.key,
    this.invoiceEntity,
    this.estimateTitle = "estimate",
    required this.type,
    required this.refreshCallBack,
    required this.invoiceDetailResEntity,
    required this.startObserveBlocBack,
    required this.deletedItem,
  });

  @override
  State<AddNewInvoiceEstimatePage> createState() =>
      _AddNewInvoiceEstimatePageState();
}

class _AddNewInvoiceEstimatePageState extends State<AddNewInvoiceEstimatePage>
    with SectionAdapterMixin {
  final ImagePicker _imagePicker = ImagePicker();
  TextEditingController notesController = TextEditingController();
  InvoiceRequestModel invoiceRequestModel = InvoiceRequestModel();
  ClientEntity? selectedClient;
  ProjectEntity? selectedProject;
  List<EmailtoMystaffEntity> myStaffList = [];
  List<EmailtoMystaffEntity> clientStaff = [];

  List<EmailtoMystaffEntity> selectedMyStaffList = [];
  List<EmailtoMystaffEntity> selectedClientStaff = [];
  InvoiceDetailResEntity? invoiceDetailResEntity;
  List<InvoiceItemEntity> selectedLineItems = [];
  List<TaxEntity> taxesList = [];
  List<ItemTaxInfo> selectedItemTaxesList = [];
  String subTotal = "0.00";
  String netTotal = "0.00";
  String totalDiscount = "0.00";
  String totalFinalTaxAmountVal = "0.00";
  ShippingDiscountModel shippingDiscountModel = ShippingDiscountModel(
      discount: "0.00", shipping: "0.00", isPercentage: false);
  String terms = "";
  DeliveryOptionsResModel? deliveryOptionsResModel;
  PaymentReminderResModel? paymentReminderResModel;
  RepeatEveryResModel? repeatEveryResModel;
  TimeZoneResModel? timeZoneResModel;
  List<DeliveryOption> deliveryOptionList = [];
  List<PaymentReminder> paymentReminderList = [];
  List<PaymentTerms> paymentTermsList = [];
  List<RepeatEvery> repeatEveryitems = [];
  List<Timezone> timeZonesList = [];
  String organizationCurrencyCode = "";
  String organizationCurrency = "";
  List<CountryModel> countries = [];
  final TextEditingController exchangeRateController = TextEditingController();
  bool hasAttachments = false;
  Uint8List? localAttachmentBytes;
  String? localAttachmentName;
  bool localAttachmentIsImage = false;
  List<ClientCreditnoteEntity> selectedCreditNotes = [];

  void _syncMyStaffSelections(List<EmailtoMystaffEntity> staffList) {
    myStaffList = staffList;
    selectedMyStaffList = myStaffList
        .where((returnedItem) => returnedItem.selected == true)
        .toList();
  }

  void _syncSelectedClientStaffFromInvoice(InvoiceEntity? invoiceEntity) {
    final preselectedClientStaff = invoiceEntity?.emailtoClientstaff ?? [];

    selectedClientStaff = preselectedClientStaff
        .where((returnedItem) => returnedItem.selected == true)
        .toList();

    if (selectedClientStaff.isEmpty) {
      selectedClientStaff = preselectedClientStaff;
    }
  }

  void _syncFetchedClientStaffSelections(List<EmailtoMystaffEntity> staffList) {
    final selectedIds = selectedClientStaff
        .map((returnedItem) => returnedItem.id)
        .whereType<String>()
        .toSet();

    clientStaff = staffList.map((returnedItem) {
      final isSelected = selectedIds.contains(returnedItem.id) ||
          (selectedIds.isEmpty && returnedItem.selected == true);
      return EmailtoMystaffEntity(
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
            final amount = selectedItemTaxesList[index].amount; //10
            final appendAmount = taxValue + amount; //5 + 10 = 15
            selectedItemTaxesList[index] = ItemTaxInfo(
              id: tax.id ?? "",
              amount: appendAmount,
              name: tax.name ?? "",
              rate: tax.rate.toString(),
            );
          } else {
            selectedItemTaxesList.add(ItemTaxInfo(
              id: tax.id ?? "", //1
              amount: taxValue, //10
              name: tax.name ?? "", //GST
              rate: tax.rate.toString(), //10
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
    _loadOrganizationCurrency();
    _loadCountries();
    if (isNewEstimateInvoice()) {
      context.read<InvoiceBloc>().add(GetInvoiceDetails(
          invoiceDetailRequest: InvoiceDetailRequest(type: widget.type)));
    } else {
      if (widget.type == EnumNewInvoiceEstimateType.duplicateInvoice ||
          widget.type == EnumNewInvoiceEstimateType.duplicateEstimate ||
          widget.type == EnumNewInvoiceEstimateType.convertEstimateToInvoice) {
        context.read<InvoiceBloc>().add(GetInvoiceDetails(
            invoiceDetailRequest: InvoiceDetailRequest(type: widget.type)));
      }
      populateData();
    }
    super.initState();
  }

  void _loadInvoiceListData() async {
    await _readDeliveryOptions();
    await _readPaymentReminder();
    await _readRepeatEvery();
    await _readTimeZones();
    await _readPaymentTerms();
  }

  Future<String> estimateTitle() async {
    String estimateHeading = await Utils.getEstimate() ?? "Estimate";
    return widget.type.getTitle(estimateHeading);
  }

  Future<void> _readDeliveryOptions() async {
    final String response =
        await rootBundle.loadString('assets/files/delivery_options.json');
    deliveryOptionsResModel = deliveryOptionsResModelFromJson(response);
    deliveryOptionList = deliveryOptionsResModel?.items ?? [];

    final deliveryOptions = widget.invoiceEntity?.deliveryOptions ?? "";
    if (deliveryOptions.isNotEmpty) {
      final deliveryOptionsIndex = deliveryOptionList.indexWhere((elemnet) {
        return elemnet.value == deliveryOptions;
      });
      if (deliveryOptionsIndex >= 0) {
        invoiceRequestModel.selectedDeliveryOption =
            deliveryOptionList[deliveryOptionsIndex];
      }
    }
  }

  Future<void> _readPaymentReminder() async {
    final String response =
        await rootBundle.loadString('assets/files/payment_reminder.json');
    paymentReminderResModel = paymentReminderResModelFromJson(response);
    paymentReminderList = paymentReminderResModel?.items ?? [];

    final paymentReminders = widget.invoiceEntity?.paymentReminders ?? "";
    if (paymentReminders.isNotEmpty) {
      final paymentRemindersIndex = paymentReminderList.indexWhere((elemnet) {
        return elemnet.value == paymentReminders;
      });
      if (paymentRemindersIndex >= 0) {
        invoiceRequestModel.selectedPaymentReminder =
            paymentReminderList[paymentRemindersIndex];
      }
    }
  }

  Future<void> _readPaymentTerms() async {
    final String response =
        await rootBundle.loadString('assets/files/payment_terms.json');
    final res = paymentTermsResModelFromJson(response);
    paymentTermsList = res.items ?? [];

    final dueTerms = widget.invoiceEntity?.dueTerms ?? "";
    if (dueTerms.isNotEmpty) {
      final payTermsIndex = paymentTermsList.indexWhere((elemnet) {
        return elemnet.value == dueTerms;
      });
      if (payTermsIndex >= 0) {
        invoiceRequestModel.selectedPaymentTerms =
            paymentTermsList[payTermsIndex];
      }
    }
  }

  void reRenderUI() {
    setState(() {});
  }

  Future<void> _readRepeatEvery() async {
    final String response =
        await rootBundle.loadString('assets/files/repeat_every.json');
    repeatEveryResModel = repeatEveryResModelFromJson(response);
    repeatEveryitems = repeatEveryResModel?.items ?? [];

    final frequency = widget.invoiceEntity?.frequency ?? "";
    if (frequency.isNotEmpty) {
      final freqIndex = repeatEveryitems.indexWhere((elemnet) {
        return elemnet.value == frequency;
      });
      if (freqIndex >= 0) {
        invoiceRequestModel.selectedRepeatEvery = repeatEveryitems[freqIndex];
      }
    }
  }

  Future<void> _readTimeZones() async {
    final String response =
        await rootBundle.loadString('assets/files/time_zones.json');
    timeZoneResModel = timeZoneResModelFromJson(response);
    timeZonesList = timeZoneResModel?.timezone ?? [];

    final timezoneId = widget.invoiceEntity?.timezoneId ?? "";
    if (timezoneId.isNotEmpty) {
      final timeZoneIndex = timeZonesList.indexWhere((elemnet) {
        return elemnet.timezoneId == timezoneId;
      });
      if (timeZoneIndex >= 0) {
        invoiceRequestModel.selectedTimezones = timeZonesList[timeZoneIndex];
      }
    }
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

  double _toDouble(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 0;
    }
    return double.tryParse(value.trim()) ?? 0;
  }

  List<ClientCreditnoteEntity> get unusedCreditNotes {
    final creditnotes = selectedClient?.creditnotes ?? [];
    return creditnotes.where((creditnote) {
      return (creditnote.status ?? '').trim().toLowerCase() == 'unused';
    }).toList();
  }

  double get availableCreditNoteLimit {
    if (unusedCreditNotes.isEmpty) {
      return 0;
    }

    return unusedCreditNotes.fold(0.0, (sum, creditnote) {
      return sum + _toDouble(creditnote.amount);
    });
  }

  bool get shouldShowCreditNoteOption => availableCreditNoteLimit > 0;

  double get appliedCreditNoteTotal {
    if (selectedCreditNotes.isEmpty) {
      return 0;
    }

    return selectedCreditNotes.fold(0.0, (sum, creditnote) {
      return sum + _toDouble(creditnote.amount);
    });
  }

  double get payableNetTotal {
    final value = _toDouble(netTotal) - appliedCreditNoteTotal;
    return value < 0 ? 0 : value;
  }

  String? get serializedSelectedCreditNotes {
    final rawIds = selectedCreditNotes
        .map((creditnote) => (creditnote.id ?? '').trim())
        .where((id) => id.isNotEmpty)
        .toList();

    if (rawIds.isEmpty) {
      return null;
    }

    final normalizedIds = rawIds.map((id) {
      final parsed = int.tryParse(id);
      return parsed ?? id;
    }).toList();

    return jsonEncode(normalizedIds);
  }

  String _creditNoteKey(ClientCreditnoteEntity creditnote) {
    final id = (creditnote.id ?? '').trim();
    if (id.isNotEmpty) {
      return id;
    }

    return [
      creditnote.noteNo ?? '',
      creditnote.amount ?? '',
      creditnote.clientId ?? '',
    ].join('_');
  }

  ClientEntity? _resolveClientWithCreditNotes(ClientEntity? client) {
    if (client == null) {
      return null;
    }

    ClientEntity? matchedClient;
    final availableClients = invoiceDetailResEntity?.clients ?? [];
    for (final returnedClient in availableClients) {
      if (returnedClient.clientId == client.clientId ||
          returnedClient.id == client.id) {
        matchedClient = returnedClient;
        break;
      }
    }

    if (matchedClient?.creditnotes?.isNotEmpty == true) {
      client.creditnotes = matchedClient?.creditnotes;
    }

    return client;
  }

  String _selectedClientLookupId(ClientEntity? client) {
    final clientId = (client?.clientId ?? '').trim();
    if (clientId.isNotEmpty) {
      return clientId;
    }
    return (client?.id ?? '').trim();
  }

  void _fetchSelectedClientDetails(ClientEntity? client) {
    final lookupId = _selectedClientLookupId(client);
    if (lookupId.isEmpty) {
      return;
    }

    context.read<ClientBloc>().add(
          GetClientDetailsEvent(
            clientDetailsReqParams: ClientDetailsReqParams(id: lookupId),
          ),
        );
  }

  void _removeSelectedCreditNote(ClientCreditnoteEntity creditnote) {
    final selectedKey = _creditNoteKey(creditnote);
    selectedCreditNotes.removeWhere(
      (returnedItem) => _creditNoteKey(returnedItem) == selectedKey,
    );
    setState(() {});
  }

  Future<void> _openCreditNoteSelector() async {
    if (unusedCreditNotes.isEmpty) {
      return;
    }

    final tempSelectedIds = selectedCreditNotes
        .map((creditnote) => _creditNoteKey(creditnote))
        .toSet();

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        return StatefulBuilder(
          builder: (modalContext, setModalState) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppPallete.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Select Credit Notes',
                                style: AppFonts.mediumStyle(size: 18),
                              ),
                            ),
                            Text(
                              'Available: \$${availableCreditNoteLimit.toStringAsFixed(2)}',
                              style: AppFonts.regularStyle(
                                color: AppPallete.k666666,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Flexible(
                        child: ListView.separated(
                          shrinkWrap: true,
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          itemCount: unusedCreditNotes.length,
                          separatorBuilder: (_, __) => const Divider(height: 1),
                          itemBuilder: (context, index) {
                            final creditnote = unusedCreditNotes[index];
                            final noteKey = _creditNoteKey(creditnote);
                            final isSelected =
                                tempSelectedIds.contains(noteKey);

                            return CheckboxListTile(
                              value: isSelected,
                              activeColor: AppPallete.blueColor,
                              controlAffinity: ListTileControlAffinity.leading,
                              title: Text(
                                creditnote.noteNo?.trim().isNotEmpty == true
                                    ? creditnote.noteNo!
                                    : 'Credit Note',
                                style: AppFonts.mediumStyle(size: 16),
                              ),
                              subtitle: (creditnote.description ?? '')
                                      .trim()
                                      .isNotEmpty
                                  ? Text(
                                      creditnote.description ?? '',
                                      style: AppFonts.regularStyle(
                                        color: AppPallete.k666666,
                                      ),
                                    )
                                  : null,
                              secondary: Text(
                                '\$${_toDouble(creditnote.amount).toStringAsFixed(2)}',
                                style: AppFonts.mediumStyle(size: 16),
                              ),
                              onChanged: (value) {
                                setModalState(() {
                                  if (value == true) {
                                    tempSelectedIds.add(noteKey);
                                  } else {
                                    tempSelectedIds.remove(noteKey);
                                  }
                                });
                              },
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(sheetContext).pop();
                              },
                              child: Text(
                                'Cancel',
                                style: AppFonts.regularStyle(
                                  color: AppPallete.k666666,
                                ),
                              ),
                            ),
                            AppConstants.sizeBoxWidth10,
                            ElevatedButton(
                              onPressed: () {
                                selectedCreditNotes = unusedCreditNotes.where(
                                  (creditnote) {
                                    return tempSelectedIds
                                        .contains(_creditNoteKey(creditnote));
                                  },
                                ).toList();
                                setState(() {});
                                Navigator.of(sheetContext).pop();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppPallete.blueColor,
                                foregroundColor: AppPallete.white,
                                elevation: 0,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 12,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Text(
                                'Apply',
                                style: AppFonts.mediumStyle(
                                  size: 16,
                                  color: AppPallete.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
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

  Future<void> _showAttachmentOptions() async {
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
      return _buildEmptyAttachmentPreview(
        message: 'Attachment added to this invoice',
      );
    }

    return _buildEmptyAttachmentPreview(message: 'Add a file or image');
  }

  Widget _buildEmptyAttachmentPreview({required String message}) {
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

  Widget _buildAdditionalDocumentInfo() {
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
                  'Add File',
                  style: AppFonts.mediumStyle(size: 16),
                ),
              ),
              TextButton(
                onPressed: _showAttachmentOptions,
                child: Text(
                  shouldShowAttachmentPreview ? 'Change' : 'Add',
                  style: AppFonts.regularStyle(color: AppPallete.blueColor),
                ),
              ),
            ],
          ),
          AppConstants.sizeBoxHeight10,
          InkWell(
            onTap: _showAttachmentOptions,
            borderRadius: BorderRadius.circular(8),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: _buildAttachmentPreview(),
            ),
          ),
          AppConstants.sizeBoxHeight10,
          Text(
            'Tap above to add file, take image, or pick from gallery.',
            style: AppFonts.regularStyle(
              size: 14,
              color: AppPallete.k666666,
            ),
          ),
        ],
      ),
    );
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
    invoiceDetailResEntity ??= widget.invoiceDetailResEntity;
    taxesList = invoiceDetailResEntity?.taxes ?? taxesList;
    selectedClient = ClientEntity(
      id: widget.invoiceEntity?.clientId,
      clientId: widget.invoiceEntity?.clientId,
      name: widget.invoiceEntity?.clientName,
      address: widget.invoiceEntity?.clientAddress,
      countryName: widget.invoiceEntity?.clientCountry,
      currency: widget.invoiceEntity?.currency,
      currencyCode: widget.invoiceEntity?.currency,
    );
    final matchedClient = invoiceDetailResEntity?.clients?.firstWhere(
      (returnedClient) =>
          returnedClient.clientId == selectedClient?.clientId ||
          returnedClient.id == selectedClient?.id,
      orElse: () => ClientEntity(),
    );
    if (matchedClient?.creditnotes?.isNotEmpty == true) {
      selectedClient?.creditnotes = matchedClient?.creditnotes;
    } else {
      _fetchSelectedClientDetails(selectedClient);
    }
    selectedCreditNotes = [];
    terms = widget.invoiceEntity?.terms ?? "";
    _syncMyStaffSelections(widget.invoiceEntity?.emailtoMystaff ?? []);
    var itemListss = widget.invoiceEntity?.items ?? [];
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

    // var convertedItemlISTS = itemListss.map((item) => {
    //       InvoiceItemEntity(
    //         itemId: item.itemId,
    //         type: item.type,
    //         itemName: item.itemName,
    //         description: item.description,
    //         date: item.date,
    //         time: item.time,
    //         custom: item.custom,
    //         qty: item.qty,
    //         unit: item.unit,
    //         rate: item.rate,
    //         discountType: item.discountType,
    //         discountValue: item.discountValue,
    //         isTaxable: item.isTaxable,
    //         taxes: item.taxes,
    //       )
    //     });
    //selectedLineItems = convertedItemlISTS;

    selectedLineItems = convertedListt;

    invoiceRequestModel = InvoiceRequestModel(
      no: widget.invoiceEntity?.no ?? "",
      heading: widget.invoiceEntity?.heading ?? "",
      title: widget.invoiceEntity?.summary ?? "",
      poNumber: widget.invoiceEntity?.pono ?? "",
      remaining: widget.invoiceEntity?.howmany ?? "",
      status: widget.invoiceEntity?.status ?? "",
      expiryDate: getDateFrom(widget.invoiceEntity?.expirydateYmd),
      date: widget.invoiceEntity?.dateYmd,
    );
    /*
    "expiry_date": "30.08.2024",
     "expirydate_ymd": "2024-08-30",
    */
    if (!isEstimate()) {
      if (_isRecurring()) {
        final howMany = widget.invoiceEntity?.howmany ?? "";
        invoiceRequestModel.isRecurring = howMany.isNotEmpty;
      } else {
        invoiceRequestModel.isRecurring = false;
      }
      _loadInvoiceListData();
    }
    _syncSelectedClientStaffFromInvoice(widget.invoiceEntity);
    if (widget.invoiceEntity?.clientId != null) {
      getClientStaffBy(widget.invoiceEntity?.clientId ?? "");
    }
    selectedProject = ProjectEntity(
        id: widget.invoiceEntity?.projectId ?? "",
        name: widget.invoiceEntity?.projectName ?? "");
    subTotal = widget.invoiceEntity?.subtotal ?? "";
    netTotal = widget.invoiceEntity?.nettotal ?? "";
    totalDiscount = widget.invoiceEntity?.discount ?? "";
    final discountType = widget.invoiceEntity?.shipping ?? "";
    bool isPercentage = false;

    if (discountType == "0") {
      isPercentage = true;
    } else if (discountType == "1") {
      isPercentage = false;
    }
    shippingDiscountModel = ShippingDiscountModel(
        discount: widget.invoiceEntity?.discountValue ?? "",
        shipping: widget.invoiceEntity?.shipping ?? "",
        isPercentage: isPercentage);
    notesController.text = widget.invoiceEntity?.notes ?? "";
    hasAttachments = widget.invoiceEntity?.isAttachments == true;
    _syncExchangeRateValue(
        existingExchangeRate: widget.invoiceEntity?.exchangeRate?.toString());

    calculateListOfTaxes();
    setState(() {});
  }

  bool _isRecurring() {
    final status = widget.invoiceEntity?.status ?? "";
    if (status.isNotEmpty && status.toLowerCase() == "recurring") {
      return true;
    }
    return false;
  }

  void addEstimate() {
    if (shouldShowExchangeRate && exchangeRateController.text.trim().isEmpty) {
      showToastification(
        context,
        'Please enter the exchange rate.',
        ToastificationType.error,
      );
      return;
    }

    if (appliedCreditNoteTotal > availableCreditNoteLimit) {
      showToastification(
        context,
        'Credit note amount cannot exceed available credit (${availableCreditNoteLimit.toStringAsFixed(2)}).',
        ToastificationType.error,
      );
      return;
    }

    if (appliedCreditNoteTotal > _toDouble(netTotal)) {
      showToastification(
        context,
        'Credit note amount cannot exceed invoice total (${_toDouble(netTotal).toStringAsFixed(2)}).',
        ToastificationType.error,
      );
      return;
    }

    final reqParams = AddInvoiceReqParms(
      type: widget.type,
      terms: terms,
      selectedClient: selectedClient,
      notes: notesController.text,
      invoiceRequestModel: invoiceRequestModel,
      selectedMyStaffList: selectedMyStaffList,
      selectedClientStaff: selectedClientStaff,
      selectedLineItems: selectedLineItems,
      selectedProject: selectedProject,
      discount: totalDiscount,
      discountType: shippingDiscountModel.isPercentage ? "0" : "1",
      discountValue: shippingDiscountModel.discount,
      netTotal: netTotal,
      shipping: shippingDiscountModel.shipping,
      subTotal: subTotal,
      taxTotal: totalFinalTaxAmountVal,
      id: doNeedToPassId() ? widget.invoiceEntity?.id ?? "" : "",
      currency: shouldShowExchangeRate ? selectedClientCurrencyCode : null,
      exchangeRate:
          shouldShowExchangeRate ? exchangeRateController.text.trim() : null,
      creditNotes: serializedSelectedCreditNotes,
    );

    debugPrint("${reqParams.invoiceRequestModel?.date ?? DateTime.now()}");

    context.read<InvoiceBloc>().add(AddInvoiceEstimateEvent(params: reqParams));
  }

  /*
  id:10319
client:23537
no:EST015
date:04 Jul 2023
project:
pono:
expiry_date:11 Jul 2023
summary:
currency:
exchange_rate:
subtotal:55
discount_type:0
discount_value:0
discount:0
taxtotal:5.5
shipping:0
nettotal:60.5
notes:Note Here
terms:asdf
items:[{"item":"20636","desc":"Backend application development using PHP, AJAX, MySQL","date":"2023-03-03","time":"24:45:45","custom":"","qty":1,"rate":55,"amount":55,"disc":0,"disctype":"0","discApplied":false,"unit":"1","taxes":[{"id":"882","name":"Vat","rate":10},{"id":"45","name":"GST","rate":4}]},{"item":"20638","desc":"PHP, AJAX, MySQL","date":"2023-04-03","time":"24:45:45","custom":"Custome fields","qty":12,"rate":56.3,"amount":56.3,"disc":0,"disctype":"0","discApplied":false,"unit":"1","taxes":[{"id":"882","name":"Vat","rate":10},{"id":"7","name":"GST","rate":4}]}]
emailto_mystaff:[{"id":"2468","email":"abc@exaple.com"},{"id":"2469","email":"pqr@exaple.com"}]
emailto_clientstaff:[{"id":"23214","email":"abc@exaple.com"},{"id":"23216","email":"pqr@exaple.com"}]
  */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppPallete.kF2F2F2,
        appBar: AppBar(
          title: FutureBuilder(
            future: estimateTitle(),
            initialData: "",
            builder: (context, snapshot) {
              return Text(snapshot.data ?? "NO Data");
            },
          ),
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
                  addEstimate();
                },
                child: Text(
                  "Save",
                  style: AppFonts.regularStyle(color: AppPallete.blueColor),
                ))
          ],
        ),
        body: BlocListener<ClientBloc, ClientState>(
            listener: (context, clientState) {
              if (clientState is ClientDetailsSuccessState) {
                final detailedClient =
                    clientState.clientDetailsMainResEntity.data?.client;
                if (detailedClient == null) {
                  return;
                }

                final currentSelectedId =
                    _selectedClientLookupId(selectedClient);
                final detailedClientId =
                    _selectedClientLookupId(detailedClient);
                if (currentSelectedId.isEmpty ||
                    detailedClientId.isEmpty ||
                    currentSelectedId != detailedClientId) {
                  return;
                }

                selectedClient = detailedClient;
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
                    return EmailtoMystaffEntity(
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
                          "Successfully added ${isEstimate() ? widget.estimateTitle : "invoice"}.",
                      ToastificationType.success);
                  widget.refreshCallBack();
                  AutoRouter.of(context).maybePop();
                }
                if (state is InvoiceDetailSuccessState) {
                  InvoiceEntity? invoiceEntity;

                  if (widget.type ==
                          EnumNewInvoiceEstimateType.duplicateInvoice ||
                      widget.type == EnumNewInvoiceEstimateType.invoice ||
                      widget.type ==
                          EnumNewInvoiceEstimateType.convertEstimateToInvoice ||
                      widget.type ==
                          EnumNewInvoiceEstimateType.convertProformaToInvoice) {
                    invoiceEntity = state.invoiceDetailResEntity.invoice;
                  } else if (isEstimate()) {
                    invoiceEntity = state.invoiceDetailResEntity.estimate;
                  }

                  debugPrint(
                      "InvoiceDetailSuccessState: ${invoiceEntity?.no ?? "No invoice number"}");

                  if (widget.type ==
                          EnumNewInvoiceEstimateType.duplicateInvoice ||
                      widget.type ==
                          EnumNewInvoiceEstimateType.duplicateEstimate ||
                      widget.type ==
                          EnumNewInvoiceEstimateType.convertEstimateToInvoice ||
                      widget.type ==
                          EnumNewInvoiceEstimateType.convertProformaToInvoice) {
                    invoiceRequestModel.no = invoiceEntity?.no;
                    setState(() {});
                    return;
                  }

                  taxesList = state.invoiceDetailResEntity.taxes ?? [];
                  _syncMyStaffSelections(invoiceEntity?.emailtoMystaff ?? []);
                  _syncSelectedClientStaffFromInvoice(invoiceEntity);
                  invoiceDetailResEntity = state.invoiceDetailResEntity;
                  invoiceRequestModel.no = invoiceEntity?.no;
                  invoiceRequestModel.heading = invoiceEntity?.heading;
                } else if (state is InvoiceDetailsFailureState) {
                  debugPrint("Error occured: ${state.errorMessage}");
                  showToastification(
                      context, state.errorMessage, ToastificationType.error);
                }
              },
              builder: (context, state) {
                if (state is InvoiceDeleteLoadingState) {
                  return LoadingPage(
                      title:
                          "Deleting ${isEstimate() ? widget.estimateTitle : "invoice"}..");
                }
                if (state is InvoiceEstimateAddLoadingState) {
                  return LoadingPage(
                      title:
                          "${isEdit() ? "Updating" : "Adding"} ${isEstimate() ? widget.estimateTitle : "invoice"} data..");
                }
                if (state is InvoiceDetailsLoadingState) {
                  return LoadingPage(
                      title:
                          "Loading ${isEstimate() ? widget.estimateTitle : "invoice"} data..");
                }
                return SectionListView.builder(
                  adapter: this,
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                );
              },
            )));
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
    // String getTotalSubTotal() {
    //   if (selectedLineItems.isEmpty) {
    //     return "A\$0.00";
    //   }
    //   final amountList = selectedLineItems.map((returnedItem) {
    //     if (returnedItem.amount != null) {
    //       return double.parse(returnedItem.amount ?? "0");
    //     }
    //   });
    //   final subTotal = amountList.reduce((a, b) => (a ?? 0) + (b ?? 0));
    //   return subTotal.toString();
    // }

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
              value: "\$$subTotal",
              isSubTotal: true),
          AppConstants.sepSizeBox5,
          getTaxCell(context,
              title: "Discount",
              subTitle: "",
              value: "\$$totalDiscount",
              isSubTotal: false),
          AppConstants.sepSizeBox5,
          for (var taxItem in selectedItemTaxesList)
            Column(
              children: [
                getTaxCell(context,
                    title: "${taxItem.name} (${taxItem.rate}%)",
                    subTitle: "",
                    value: "\$${taxItem.amount.toStringAsFixed(2)}",
                    isSubTotal: false),
                AppConstants.sepSizeBox5,
              ],
            ),
          getTaxCell(context,
              title: "Shipping",
              subTitle: "",
              value: "\$${shippingDiscountModel.shipping}",
              isSubTotal: false),
          if (shouldShowCreditNoteOption) ...[
            AppConstants.sepSizeBox5,
            GestureDetector(
              onTap: _openCreditNoteSelector,
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          '(-) ',
                          style: AppFonts.regularStyle(),
                        ),
                        Text(
                          'Credit Note',
                          style: AppFonts.regularStyle(
                            color: AppPallete.blueColor,
                          ),
                        ),
                        const Icon(
                          Icons.keyboard_arrow_down,
                          color: AppPallete.textColor,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      appliedCreditNoteTotal > 0
                          ? '-\$${appliedCreditNoteTotal.toStringAsFixed(2)}'
                          : '\$0.00',
                      textAlign: TextAlign.end,
                      style: AppFonts.mediumStyle(size: 16),
                    ),
                  ),
                ],
              ),
            ),
            if (selectedCreditNotes.isNotEmpty) ...[
              AppConstants.sepSizeBox5,
              ...selectedCreditNotes.map((creditnote) {
                return Padding(
                  padding: const EdgeInsets.only(left: 16, bottom: 6),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          creditnote.noteNo?.trim().isNotEmpty == true
                              ? creditnote.noteNo!
                              : 'Credit Note',
                          style: AppFonts.regularStyle(),
                        ),
                      ),
                      Text(
                        '\$${_toDouble(creditnote.amount).toStringAsFixed(2)}',
                        style: AppFonts.regularStyle(),
                      ),
                      InkWell(
                        onTap: () => _removeSelectedCreditNote(creditnote),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Icon(
                            Icons.close,
                            size: 18,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ],
          AppConstants.sizeBoxHeight15,
          const ItemSeparator(),
          AppConstants.sizeBoxHeight15,
          GestureDetector(
            onTap: () {
              AutoRouter.of(context).push(LineItemTotalSelectionPageRoute(
                  shippingDiscountModel: shippingDiscountModel,
                  callBack: (returnedShippingDiscountModel) {
                    shippingDiscountModel = returnedShippingDiscountModel;
                    calculateListOfTaxes();
                    setState(() {});
                  }));
            },
            child: getTaxCell(context,
                title: "Total",
                subTitle: "(USD)",
                value: "\$${payableNetTotal.toStringAsFixed(2)}",
                isTotal: true),
          ),
          AppConstants.sizeBoxHeight15,
        ],
      ),
    );
  }

  bool isEdit() {
    return widget.invoiceEntity != null;
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
        taxes: taxesList,
        enterItemModel: (lineItem, returnedIndex) {
          if (lineItem == null) {
            return;
          }
          if (returnedIndex != null) {
            // if (itemId.isNotEmpty) {
            //   //Consider as InvoiceItemModel
            //   InvoiceItemModel(
            //     itemId: lineItem.itemId,
            //     type: lineItem.type,
            //     itemName: lineItem.itemName,
            //     isTaxable: lineItem.isTaxable,
            //     description: lineItem.description,
            //     date: lineItem.date,
            //     time: lineItem.time,
            //     custom: lineItem.custom,
            //     qty: lineItem.qty,
            //     unit: lineItem.unit,
            //     rate: lineItem.rate,
            //     discountType: lineItem.discountType,
            //     discountValue: lineItem.discountValue,
            //     taxes: lineItem.taxes
            //   );
            // }

            if (selectedLineItems[returnedIndex].runtimeType ==
                InvoiceItemModel) {
              debugPrint("Its InvoiceItemModel");
            } else {
              debugPrint("Its Not InvoiceItemModel");
            }
            selectedLineItems[returnedIndex] = lineItem;
          } else {
            selectedLineItems.add(lineItem);
          }
//InvoiceItemEntity
          calculateListOfTaxes();

          setState(() {});
        },
        items: invoiceDetailResEntity?.items));
  }

  void _openClient() {
    AutoRouter.of(context).push(ClientPopupRoute(
        clientListFromParentClass: invoiceDetailResEntity?.clients,
        selectedClient: selectedClient,
        onSelectClient: (client) {
          final resolvedClient = _resolveClientWithCreditNotes(client);
          if (client != null &&
              selectedClient != null &&
              resolvedClient?.clientId == selectedClient?.clientId) {
            return;
          }
          selectedProject = null;
          selectedClientStaff = [];
          selectedClient = resolvedClient;
          exchangeRateController.clear();
          _syncExchangeRateValue();
          selectedCreditNotes = [];
          _syncFetchedClientStaffSelections(
              resolvedClient?.persons?.map((returnedItem) {
                    return EmailtoMystaffEntity(
                        email: returnedItem.email ?? "",
                        id: returnedItem.id ?? "",
                        name: returnedItem.name ?? "",
                        selected: returnedItem.primary ?? false);
                  }).toList() ??
                  []);
          if (resolvedClient?.id != null) {
            getClientStaffBy(resolvedClient?.id ?? "");
          }
          _fetchSelectedClientDetails(resolvedClient);
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
      case EnumNewInvoiceEstimateType.estimate ||
            EnumNewInvoiceEstimateType.duplicateEstimate ||
            EnumNewInvoiceEstimateType.invoice ||
            EnumNewInvoiceEstimateType.duplicateInvoice:
        return false;
      case EnumNewInvoiceEstimateType.editInvoice ||
            EnumNewInvoiceEstimateType.editEstimate ||
            EnumNewInvoiceEstimateType.convertEstimateToInvoice ||
            EnumNewInvoiceEstimateType.convertProformaToInvoice:
        return true;
    }
  }

  bool isNewEstimateInvoice() {
    if (widget.type == EnumNewInvoiceEstimateType.estimate ||
        widget.type == EnumNewInvoiceEstimateType.invoice) {
      return true;
    }
    return false;
  }

  bool isEstimate() {
    if (widget.type == EnumNewInvoiceEstimateType.estimate ||
        widget.type == EnumNewInvoiceEstimateType.editEstimate ||
        widget.type == EnumNewInvoiceEstimateType.duplicateEstimate) {
      return true;
    }
    return false;
  }

  void _openEmailTo() {
    AutoRouter.of(context).push(EmailToPageRoute(
        clientStaff: clientStaff,
        myStaffList: myStaffList,
        selectedClientStaff: selectedClientStaff,
        selectedMyStaffList: selectedMyStaffList,
        onpressDone: (myStaff, clientStafff) {
          selectedClientStaff = clientStafff;
          selectedMyStaffList = myStaff;
          setState(() {});
        }));
  }

  @override
  Widget getItem(BuildContext context, IndexPath indexPath) {
    if (isEdit() && indexPath.section == 6) {
      return Container(
          width: MediaQuery.of(context).size.width,
          color: AppPallete.white,
          child: TextButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AppAlertWidget(
                        title:
                            "Delete ${isEstimate() ? widget.estimateTitle : "Invoice"}",
                        message:
                            "Are you sure you want to delete this ${isEstimate() ? widget.estimateTitle : "invoice"}?",
                        onTapDelete: () {
                          debugPrint("on tap delete item");
                          AutoRouter.of(context).maybePop();
                          _deleteInvoice();
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
        child: InvoiceInfoWidget(
          invoiceStatusColor: widget.invoiceEntity?.statusColor,
          invoiceRequestModel: invoiceRequestModel,
          type: widget.type,
          estimateTitle: widget.estimateTitle,
        ),
        onTap: () {
          if (isEstimate()) {
            AutoRouter.of(context).push(EstimateAddInfoDetailsRoute(
                invoiceRequestModel: invoiceRequestModel,
                callback: () {
                  setState(() {});
                },
                estimateTitle: widget.estimateTitle));
          } else {
            AutoRouter.of(context).push(InvoiceAddBasicDetailsWidgetRoute(
                invoiceRequestModel: invoiceRequestModel,
                callback: () {
                  setState(() {});
                }));
          }
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
        hintText: isEstimate()
            ? "Will be displayed on the ${widget.estimateTitle.toLowerCase()}"
            : "Will be displayed on the invoice",
      );
    } else if (indexPath.section == 4) {
      return _buildAdditionalDocumentInfo();
    } else if (indexPath.section == 5) {
      return TermsCardWidget(
        onPress: () {
          AutoRouter.of(context).push(InvoiceEstimateTermsInoutPageRoute(
              terms: terms,
              callback: (val) {
                terms = val;
              }));
        },
      );
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
          ),
        ),
      );
    }
    return const SizedBox();
  }

  void _deleteInvoice() {
    if (widget.invoiceEntity != null && widget.invoiceEntity!.id != null) {
      context.read<InvoiceBloc>().add(InvoiceDeleteEvent(
              params: InvoiceDeleteReqParms(
            id: widget.invoiceEntity?.id ?? "",
            type: isEstimate()
                ? EnumDocumentType.estimate
                : EnumDocumentType.invoice,
          )));
    }
  }

  @override
  int numberOfSections() {
    return isEdit() ? 7 : 6;
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

/*
List<PaymentTerms> paymentTerms = [];
  List<PaymentReminder> paymentReminders = [];
  PaymentTerms? selectedPaymentTerms;
  List<RepeatEvery> repeatEveryList = [];
  RepeatEvery? selectedRepeatEvery;
  List<Timezone> timeZones = [];
  Timezone? selectedTimezones;
  PaymentReminder? selectedPaymentReminder;
*/
class InvoiceRequestModel {
  String? no;
  String? heading;
  String? title;
  DateTime? date;
  String? poNumber;
  bool? isRecurring;
  bool? isInfinite;
  String? remaining;
  String? status;
  DateTime? expiryDate;
  PaymentTerms? selectedPaymentTerms;
  RepeatEvery? selectedRepeatEvery;
  Timezone? selectedTimezones;
  PaymentReminder? selectedPaymentReminder;
  DeliveryOption? selectedDeliveryOption;

  InvoiceRequestModel({
    this.no,
    this.heading,
    this.isInfinite,
    this.remaining,
    this.selectedRepeatEvery,
    this.selectedTimezones,
    this.selectedPaymentTerms,
    this.selectedPaymentReminder,
    this.status,
    this.isRecurring,
    this.title,
    this.date,
    this.expiryDate,
    this.poNumber,
    this.selectedDeliveryOption,
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
