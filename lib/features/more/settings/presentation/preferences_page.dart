import 'package:auto_route/auto_route.dart';
import 'package:billbooks_app/core/app_constants.dart';
import 'package:billbooks_app/core/theme/app_fonts.dart';
import 'package:billbooks_app/core/theme/app_pallete.dart';
import 'package:billbooks_app/core/utils/show_toast.dart';
import 'package:billbooks_app/core/utils/utils.dart';
import 'package:billbooks_app/core/widgets/date_formater_popup_widget.dart';
import 'package:billbooks_app/core/widgets/estimate_name_popup_widget.dart';
import 'package:billbooks_app/core/widgets/input_dropdown_view.dart';
import 'package:billbooks_app/core/widgets/input_switch_widget.dart';
import 'package:billbooks_app/core/widgets/loading_page.dart';
import 'package:billbooks_app/core/widgets/new_inputview_widget.dart';
import 'package:billbooks_app/core/widgets/notes_widget.dart';
import 'package:billbooks_app/core/widgets/paper_format_popup_widget.dart';
import 'package:billbooks_app/core/widgets/section_header_widget.dart';
import 'package:billbooks_app/features/general/bloc/general_bloc.dart';
import 'package:billbooks_app/features/more/settings/domain/entity/date_formater.dart';
import 'package:billbooks_app/features/more/settings/domain/entity/estimate_name_entity.dart';
import 'package:billbooks_app/features/more/settings/domain/entity/paper_format_entity.dart';
import 'package:billbooks_app/features/more/settings/domain/entity/preference_details_entity.dart';
import 'package:billbooks_app/features/more/settings/domain/usecase/preference_details_usecase.dart';
import 'package:billbooks_app/features/more/settings/domain/usecase/update_preference_estimate_usecase.dart';
import 'package:billbooks_app/features/more/settings/presentation/bloc/organization_bloc.dart';
import 'package:billbooks_app/features/more/settings/presentation/preference_type%20header_widget.dart';
import 'package:billbooks_app/features/more/settings/presentation/setting_template_page.dart';
import 'package:billbooks_app/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';

import '../../../../core/models/language_model.dart';
import '../../../../core/utils/column_settings_pref.dart';
import '../../../../core/widgets/currency_list_popup_widget.dart';
import '../../../../core/widgets/fiscal_year_popup.dart';
import '../../../../core/widgets/language_list_popup_widget.dart';
import '../../../../core/widgets/payment_terms_popup_widget.dart';
import '../../../clients/presentation/Models/client_currencies.dart';
import '../../../invoice/domain/entities/payment_terms_model.dart';
import '../domain/entity/fiscal_year_entity.dart';
import '../domain/usecase/update_pref_general_usecase.dart';
import '../domain/usecase/update_pref_invoice_usecase.dart';
import '../domain/usecase/update_preference_column_usecase.dart';

enum EnumPreferencesType {
  general,
  invoice,
  estimate,
  invEst,
  proforma,
  dashboard
}

extension EnumPreferencesTypeExtension on EnumPreferencesType {
  String get title {
    switch (this) {
      case EnumPreferencesType.general:
        return "General";
      case EnumPreferencesType.invoice:
        return "Invoice";
      case EnumPreferencesType.estimate:
        return "Estimate";
      case EnumPreferencesType.invEst:
        return "Inv/Est";

      case EnumPreferencesType.proforma:
        return "Proforma";
      case EnumPreferencesType.dashboard:
        return "Dashboard";
    }
  }
}

@RoutePage()
class PreferencesPage extends StatefulWidget {
  const PreferencesPage({super.key});

  @override
  State<PreferencesPage> createState() => _PreferencesPageState();
}

class _PreferencesPageState extends State<PreferencesPage> {
  EnumPreferencesType selectedType = EnumPreferencesType.general;

  TextEditingController invoiceNumberController = TextEditingController();
  TextEditingController invoiceTitleController = TextEditingController();
  TextEditingController notesController = TextEditingController();

  TextEditingController estimateNumberController = TextEditingController();
  TextEditingController estimateNotesController = TextEditingController();
  TextEditingController portalNameController = TextEditingController();

  bool attachPDF = false;
  bool notifyEstimateandInvoiceOpened = false;
  bool notifyApproveDeclined = false;
  bool notifyPaymentMade = false;
  bool isShownSuccessToast = false;

  List<LanguageModel> languages = [];
  List<FiscalYearEntity> fiscalYearList = [];
  List<CurrencyModel> currencies = [];
  List<PaperFormatEntity> paperFormatters = [];
  List<DateFormatEntity> dateFormatterList = [];
  List<PaymentTerms> paymentTerms = [];
  List<EstimateName> estimateNames = [];
  EstimateName? selectedEstimateName;
  CurrencyModel? selectedCurrency;
  FiscalYearEntity? selectedFiscalYear;
  LanguageModel? selectedLanguage;
  PaperFormatEntity? selectedPaperFormatter;
  DateFormatEntity? selectedDateFormatter;
  PaymentTerms? selectedPaymentTerms;
  PreferencesEntity? preferencesEntity;
  UpdatePreferenceColumnReqParams? updatePreferenceColumnReqParams;
  String invoiceTerms = "";
  String estimateTerms = "";
  var _unitSelected = "";
  var _itemSelected = "";
  var _amountSelected = "";
  var _rateSelected = "";

  bool isDateChecked = false;
  bool isTimeChecked = false;
  bool isCustomChecked = false;
  bool isHideQtyChecked = false;
  bool isHideRateChecked = false;
  bool isHideAmountChecked = false;

  bool isBusinessSnapshotChecked = false;
  bool isTotalSalesSnapshotChecked = false;
  bool isUnvoicedAmountChecked = false;
  bool isEstimatedEarningsChecked = false;
  bool isTotalExpensesChecked = false;
  bool isConversionRateChecked = false;
  bool isTotalRecurringChecked = false;

  bool isItemsChecked = false;
  bool isClientChecked = false;
  bool isTotalIncomeChecked = false;
  bool isReceivalesChecked = false;
  bool isOverdueChecked = false;
  bool isSchduledChecked = false;

  final TextEditingController customController = TextEditingController();
  final TextEditingController _itemOtherController = TextEditingController();
  final TextEditingController _unitOtherController = TextEditingController();
  final TextEditingController _amountOtherController = TextEditingController();
  final TextEditingController _rateOtherController = TextEditingController();
  final TextEditingController proformaTitleController = TextEditingController();
  final TextEditingController proformNotesController = TextEditingController();
  final TextEditingController proformaNumberController =
      TextEditingController();

  var radioOptionsStyle = AppFonts.regularStyle(size: 14);

  @override
  void initState() {
    _readPaymentTerms();
    _readFiscalYear();
    _loadCurrencies();
    _loadDateFormatter();
    _loadLanguages();
    _loadPaperFormatter();
    _loadEstimateName();
    _loadPreference();
    super.initState();
  }

  void printInvEstResponse() {
    debugPrint("TODO");
    if (_itemSelected == "Other") {
      debugPrint("Selected Items: ${_itemOtherController.text}");
    } else {
      debugPrint("Selected Items: $_itemSelected");
    }
    var isItemOtherSelected = _itemSelected == "Other";

    if (_unitSelected == "Other") {
      debugPrint("Selected Units: ${_unitOtherController.text}");
    } else {
      debugPrint("Selected Units: $_unitSelected");
    }
    var isUnitOtherSelected = _itemSelected == "Other";

    if (_rateSelected == "Other") {
      debugPrint("Selected Rate: ${_rateOtherController.text}");
    } else {
      debugPrint("Selected Rate: $_rateSelected");
    }
    var isRateOtherSelected = _rateSelected == "Other";

    if (_amountSelected == "Other") {
      debugPrint("Selected Amount: ${_amountOtherController.text}");
    } else {
      debugPrint("Selected Amount : $_amountSelected");
    }
    var isAmountOtherSelected = _amountSelected == "Other";

    var model = InvEstReqParams(
      columnItemTitle: isItemOtherSelected == false ? _itemSelected : "",
      columnItemOther:
          isItemOtherSelected == true ? _itemOtherController.text : "",
      columnUnitTitle: isUnitOtherSelected == false ? _unitSelected : "",
      columnUnitOther:
          isUnitOtherSelected == true ? _unitOtherController.text : "",
      columnRateTitle: isRateOtherSelected == false ? _rateSelected : "",
      columnRateOther:
          isRateOtherSelected == true ? _rateOtherController.text : "",
      columnAmountTitle: isAmountOtherSelected == false ? _amountSelected : "",
      columnAmountOther:
          isAmountOtherSelected == true ? _amountOtherController.text : "",
      columnDate: isDateChecked,
      columnTime: isTimeChecked,
      columnCustom: isCustomChecked,
      columnCustomTitle: customController.text,
      columnQty: isHideQtyChecked,
      columnRate: isHideRateChecked,
      columnAmount: isHideAmountChecked,
    );
    debugPrint(model.toString());

    // context.read<OrganizationBloc>().add(
    //       UpdateInvEstDetailsEvent(invEstReqParams: model),
    //     );
  }

  void _updatePreference() {
    //if (selectedType == EnumPreferencesType.general) {
    context.read<OrganizationBloc>().add(
          UpdatePreferenceGeneralDetailsEvent(
            preferenceUpdateReqParams: UpdatePrefGeneralReqParams(
              portalName: preferencesEntity?.portalName ?? "",
              numberFormat: "",
              paperSize: selectedPaperFormatter?.format ?? "",
              attachPdf: attachPDF,
              notifyApproveDeclined: notifyApproveDeclined,
              notifyPayOnline: notifyPaymentMade,
              notifyInvoiceViewed: notifyEstimateandInvoiceOpened,
              fiscalYear: selectedFiscalYear?.id ?? "",
              currency: selectedCurrency?.currencyId ?? "",
              language: selectedLanguage?.languageId ?? "",
              dateFormat: selectedDateFormatter?.format ?? "",
            ),
          ),
        );
    // }

    // if (selectedType == EnumPreferencesType.invoice) {
    context.read<OrganizationBloc>().add(
          UpdatePreferenceInvoiceDetailsEvent(
            preferenceUpdateReqParams: UpdatePrefInvoiceReqParams(
              heading: invoiceTitleController.text,
              number: invoiceNumberController.text,
              notes: notesController.text,
              paymentTerms: selectedPaymentTerms?.value ?? "",
              template: "",
              terms: invoiceTerms,
            ),
          ),
        );
    // }
    //if (selectedType == EnumPreferencesType.estimate) {
    context.read<OrganizationBloc>().add(
          UpdatePreferenceEstimateDetailsEvent(
            preferenceUpdateReqParams: UpdatePreferenceEstimateReqParams(
              estimateName: selectedEstimateName?.name ?? "",
              estimateNo: estimateNumberController.text,
              estimateNotes: estimateNotesController.text,
              estimateTemplate: '',
              estimateTerms: estimateTerms,
            ),
          ),
        );

    if (updatePreferenceColumnReqParams != null) {
      context.read<OrganizationBloc>().add(
            UpdatePreferenceColumnDetailsEvent(
              preferenceUpdateReqParams: updatePreferenceColumnReqParams!,
            ),
          );
    }

    //}
  }

  @override
  Widget build(BuildContext context) {
    void updateUI() {
      setState(() {});
    }

    /*
 Container(
      //padding: EdgeInsets.all(15),
      color: AppPallete.kF2F2F2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '1. Items',
                  style: AppFonts.regularStyle(),
                ),
*/
    var invEst = Container(
      color: AppPallete.kF2F2F2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 18),
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.only(left: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("1. Business Snapshot"),
                  SizedBox(height: 8),
                  Text(
                    "Choose the key metrics and charts to display for an overview of your business performance.",
                  ),
                  SizedBox(height: 8),
                  CheckboxListTile(
                    controlAffinity:
                        ListTileControlAffinity.leading, // 👈 checkbox left
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    visualDensity: const VisualDensity(
                      horizontal: -4,
                      vertical: -4,
                    ),
                    title: Text('Business Snapshot', style: radioOptionsStyle),
                    value: isBusinessSnapshotChecked,
                    onChanged: (value) =>
                        setState(() => isBusinessSnapshotChecked = value!),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 12),
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("2. Totals"),
                SizedBox(height: 8),
                Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Text(
                    "Select which total figures like sales, expenses, and revenue you want visible on your dashboard.",
                  ),
                ),
                SizedBox(height: 8),
                CheckboxListTile(
                  controlAffinity:
                      ListTileControlAffinity.leading, // 👈 checkbox left
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                  visualDensity: const VisualDensity(
                    horizontal: -4,
                    vertical: -4,
                  ),
                  title: Text('Total Sales', style: radioOptionsStyle),
                  value: isTotalSalesSnapshotChecked,
                  onChanged: (value) =>
                      setState(() => isTotalSalesSnapshotChecked = value!),
                ),
                CheckboxListTile(
                  controlAffinity:
                      ListTileControlAffinity.leading, // 👈 checkbox left
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                  visualDensity: const VisualDensity(
                    horizontal: -4,
                    vertical: -4,
                  ),
                  title: Text('Unvoiced Amount', style: radioOptionsStyle),
                  value: isUnvoicedAmountChecked,
                  onChanged: (value) =>
                      setState(() => isUnvoicedAmountChecked = value!),
                ),
                CheckboxListTile(
                  controlAffinity:
                      ListTileControlAffinity.leading, // 👈 checkbox left
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                  visualDensity: const VisualDensity(
                    horizontal: -4,
                    vertical: -4,
                  ),
                  title: Text('Estimated Earnings', style: radioOptionsStyle),
                  value: isEstimatedEarningsChecked,
                  onChanged: (value) =>
                      setState(() => isEstimatedEarningsChecked = value!),
                ),
                CheckboxListTile(
                  controlAffinity:
                      ListTileControlAffinity.leading, // 👈 checkbox left
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                  visualDensity: const VisualDensity(
                    horizontal: -4,
                    vertical: -4,
                  ),
                  title: Text('Total Expenses', style: radioOptionsStyle),
                  value: isTotalExpensesChecked,
                  onChanged: (value) =>
                      setState(() => isTotalExpensesChecked = value!),
                ),
                CheckboxListTile(
                  controlAffinity:
                      ListTileControlAffinity.leading, // 👈 checkbox left
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                  visualDensity: const VisualDensity(
                    horizontal: -4,
                    vertical: -4,
                  ),
                  title: Text('Conversion Rate', style: radioOptionsStyle),
                  value: isConversionRateChecked,
                  onChanged: (value) =>
                      setState(() => isConversionRateChecked = value!),
                ),
                CheckboxListTile(
                  controlAffinity:
                      ListTileControlAffinity.leading, // 👈 checkbox left
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                  visualDensity: const VisualDensity(
                    horizontal: -4,
                    vertical: -4,
                  ),
                  title: Text('Total Recurring', style: radioOptionsStyle),
                  value: isTotalRecurringChecked,
                  onChanged: (value) =>
                      setState(() => isTotalRecurringChecked = value!),
                ),
              ],
            ),
          ),
          SizedBox(height: 12),
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("3. Date & Time Module"),
                SizedBox(height: 8),
                Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Text(
                    "Control which date-related filters or modules appear for reporting and tracking.",
                  ),
                ),
                SizedBox(height: 8),
                CheckboxListTile(
                  controlAffinity:
                      ListTileControlAffinity.leading, // 👈 checkbox left
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                  visualDensity: const VisualDensity(
                    horizontal: -4,
                    vertical: -4,
                  ),
                  title: Text('Items', style: radioOptionsStyle),
                  value: isItemsChecked,
                  onChanged: (value) => setState(() => isItemsChecked = value!),
                ),
                CheckboxListTile(
                  controlAffinity:
                      ListTileControlAffinity.leading, // 👈 checkbox left
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                  visualDensity: const VisualDensity(
                    horizontal: -4,
                    vertical: -4,
                  ),
                  title: Text('Client', style: radioOptionsStyle),
                  value: isClientChecked,
                  onChanged: (value) =>
                      setState(() => isClientChecked = value!),
                ),
                CheckboxListTile(
                  controlAffinity:
                      ListTileControlAffinity.leading, // 👈 checkbox left
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                  visualDensity: const VisualDensity(
                    horizontal: -4,
                    vertical: -4,
                  ),
                  title: Text('Total Income', style: radioOptionsStyle),
                  value: isTotalIncomeChecked,
                  onChanged: (value) =>
                      setState(() => isTotalIncomeChecked = value!),
                ),
                CheckboxListTile(
                  controlAffinity:
                      ListTileControlAffinity.leading, // 👈 checkbox left
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                  visualDensity: const VisualDensity(
                    horizontal: -4,
                    vertical: -4,
                  ),
                  title: Text('Receivables', style: radioOptionsStyle),
                  value: isReceivalesChecked,
                  onChanged: (value) =>
                      setState(() => isReceivalesChecked = value!),
                ),
                CheckboxListTile(
                  controlAffinity:
                      ListTileControlAffinity.leading, // 👈 checkbox left
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                  visualDensity: const VisualDensity(
                    horizontal: -4,
                    vertical: -4,
                  ),
                  title: Text('Overdue', style: radioOptionsStyle),
                  value: isOverdueChecked,
                  onChanged: (value) =>
                      setState(() => isOverdueChecked = value!),
                ),
                CheckboxListTile(
                  controlAffinity:
                      ListTileControlAffinity.leading, // 👈 checkbox left
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                  visualDensity: const VisualDensity(
                    horizontal: -4,
                    vertical: -4,
                  ),
                  title: Text('Scheduled', style: radioOptionsStyle),
                  value: isSchduledChecked,
                  onChanged: (value) =>
                      setState(() => isSchduledChecked = value!),
                ),
              ],
            ),
          ),
          SizedBox(height: 18),
        ],
      ),
    );

    var dashboard = Container(
      color: AppPallete.kF2F2F2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 18),
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.only(left: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 26),
                  Text("Show or Hide Dashboard components:"),
                  SizedBox(height: 26),
                  Divider(
                    height: 1,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 10),
                  CheckboxListTile(
                    controlAffinity:
                        ListTileControlAffinity.leading, // 👈 checkbox left
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    visualDensity: const VisualDensity(
                      horizontal: -4,
                      vertical: -4,
                    ),
                    title: Text('Business Snapshot', style: radioOptionsStyle),
                    value: isBusinessSnapshotChecked,
                    onChanged: (value) =>
                        setState(() => isBusinessSnapshotChecked = value!),
                  ),
                  SizedBox(height: 10),
                  Divider(
                    height: 1,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 10),
                  CheckboxListTile(
                    controlAffinity:
                        ListTileControlAffinity.leading, // 👈 checkbox left
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    visualDensity: const VisualDensity(
                      horizontal: -4,
                      vertical: -4,
                    ),
                    title: Text('Total Sales', style: radioOptionsStyle),
                    value: isBusinessSnapshotChecked,
                    onChanged: (value) =>
                        setState(() => isBusinessSnapshotChecked = value!),
                  ),
                  CheckboxListTile(
                    controlAffinity:
                        ListTileControlAffinity.leading, // 👈 checkbox left
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    visualDensity: const VisualDensity(
                      horizontal: -4,
                      vertical: -4,
                    ),
                    title: Text('Unvoiced Amount', style: radioOptionsStyle),
                    value: isBusinessSnapshotChecked,
                    onChanged: (value) =>
                        setState(() => isBusinessSnapshotChecked = value!),
                  ),
                  CheckboxListTile(
                    controlAffinity:
                        ListTileControlAffinity.leading, // 👈 checkbox left
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    visualDensity: const VisualDensity(
                      horizontal: -4,
                      vertical: -4,
                    ),
                    title: Text('Estimated Earnings', style: radioOptionsStyle),
                    value: isBusinessSnapshotChecked,
                    onChanged: (value) =>
                        setState(() => isBusinessSnapshotChecked = value!),
                  ),
                  CheckboxListTile(
                    controlAffinity:
                        ListTileControlAffinity.leading, // 👈 checkbox left
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    visualDensity: const VisualDensity(
                      horizontal: -4,
                      vertical: -4,
                    ),
                    title: Text('Total Expenses', style: radioOptionsStyle),
                    value: isBusinessSnapshotChecked,
                    onChanged: (value) =>
                        setState(() => isBusinessSnapshotChecked = value!),
                  ),
                  CheckboxListTile(
                    controlAffinity:
                        ListTileControlAffinity.leading, // 👈 checkbox left
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    visualDensity: const VisualDensity(
                      horizontal: -4,
                      vertical: -4,
                    ),
                    title: Text('Conversion Rate', style: radioOptionsStyle),
                    value: isBusinessSnapshotChecked,
                    onChanged: (value) =>
                        setState(() => isBusinessSnapshotChecked = value!),
                  ),
                  CheckboxListTile(
                    controlAffinity:
                        ListTileControlAffinity.leading, // 👈 checkbox left
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    visualDensity: const VisualDensity(
                      horizontal: -4,
                      vertical: -4,
                    ),
                    title: Text('Total Recurring', style: radioOptionsStyle),
                    value: isBusinessSnapshotChecked,
                    onChanged: (value) =>
                        setState(() => isBusinessSnapshotChecked = value!),
                  ),
                  SizedBox(height: 10),
                  Divider(
                    height: 1,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 10),
                  CheckboxListTile(
                    controlAffinity:
                        ListTileControlAffinity.leading, // 👈 checkbox left
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    visualDensity: const VisualDensity(
                      horizontal: -4,
                      vertical: -4,
                    ),
                    title: Text('Items', style: radioOptionsStyle),
                    value: isBusinessSnapshotChecked,
                    onChanged: (value) =>
                        setState(() => isBusinessSnapshotChecked = value!),
                  ),
                  CheckboxListTile(
                    controlAffinity:
                        ListTileControlAffinity.leading, // 👈 checkbox left
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    visualDensity: const VisualDensity(
                      horizontal: -4,
                      vertical: -4,
                    ),
                    title: Text('Clients', style: radioOptionsStyle),
                    value: isBusinessSnapshotChecked,
                    onChanged: (value) =>
                        setState(() => isBusinessSnapshotChecked = value!),
                  ),
                  CheckboxListTile(
                    controlAffinity:
                        ListTileControlAffinity.leading, // 👈 checkbox left
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    visualDensity: const VisualDensity(
                      horizontal: -4,
                      vertical: -4,
                    ),
                    title: Text('Total Income', style: radioOptionsStyle),
                    value: isBusinessSnapshotChecked,
                    onChanged: (value) =>
                        setState(() => isBusinessSnapshotChecked = value!),
                  ),
                  CheckboxListTile(
                    controlAffinity:
                        ListTileControlAffinity.leading, // 👈 checkbox left
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    visualDensity: const VisualDensity(
                      horizontal: -4,
                      vertical: -4,
                    ),
                    title: Text('Receivables', style: radioOptionsStyle),
                    value: isBusinessSnapshotChecked,
                    onChanged: (value) =>
                        setState(() => isBusinessSnapshotChecked = value!),
                  ),
                  CheckboxListTile(
                    controlAffinity:
                        ListTileControlAffinity.leading, // 👈 checkbox left
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    visualDensity: const VisualDensity(
                      horizontal: -4,
                      vertical: -4,
                    ),
                    title: Text('Overdue', style: radioOptionsStyle),
                    value: isBusinessSnapshotChecked,
                    onChanged: (value) =>
                        setState(() => isBusinessSnapshotChecked = value!),
                  ),
                  CheckboxListTile(
                    controlAffinity:
                        ListTileControlAffinity.leading, // 👈 checkbox left
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    visualDensity: const VisualDensity(
                      horizontal: -4,
                      vertical: -4,
                    ),
                    title: Text('Scheduled', style: radioOptionsStyle),
                    value: isBusinessSnapshotChecked,
                    onChanged: (value) =>
                        setState(() => isBusinessSnapshotChecked = value!),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 12),
        ],
      ),
    );

    var general = Container(
      color: AppPallete.kF2F2F2,
      child: Column(
        children: [
          AppConstants.sizeBoxHeight10,
          NewInputViewWidget(
            title: "Portal Name",
            hintText: "Portal Name",
            controller: portalNameController,
          ),
          InputDropdownView(
            title: "Fiscal Year",
            isRequired: false,
            defaultText: "Tap to Select",
            value: selectedFiscalYear?.fromTo ?? "",
            onPress: () {
              _showFiscalYearPopup();
            },
          ),
          InputDropdownView(
            title: "Base Currency",
            isRequired: false,
            defaultText: "Tap to Select",
            value: selectedCurrency?.name ?? "",
            onPress: () {
              _showCurrencyPopup();
            },
          ),
          InputDropdownView(
            title: "Date Formatter",
            isRequired: false,
            defaultText: "Tap to Select",
            value: selectedDateFormatter?.format ?? "",
            onPress: () {
              _showDateFormatterPopup();
            },
          ),
          InputDropdownView(
            title: "Paper Size",
            isRequired: false,
            defaultText: "Tap to Select",
            value: selectedPaperFormatter?.format ?? "",
            onPress: () {
              _showPaperFormatterPopup();
            },
          ),
          InputDropdownView(
            title: "Language",
            isRequired: false,
            defaultText: "Tap to Select",
            value: selectedLanguage?.name ?? "",
            showDivider: false,
            onPress: () {
              _showLanguagePopup();
            },
          ),
          SectionHeaderWidget(title: "PDF Attachment".toUpperCase()),
          InPutSwitchWidget(
            title: "Attach PDF by default while sending invoices and estimates",
            context: context,
            isRecurringOn: attachPDF,
            onChanged: (val) {
              attachPDF = val;
              updateUI();
            },
            showDivider: false,
          ),
          SectionHeaderWidget(title: "Notifications".toUpperCase()),
          InPutSwitchWidget(
            title: "Notify when estimates and invoices is opened",
            context: context,
            isRecurringOn: notifyEstimateandInvoiceOpened,
            onChanged: (val) {
              notifyEstimateandInvoiceOpened = val;
              updateUI();
            },
            showDivider: true,
          ),
          InPutSwitchWidget(
            title: "Notify when estimates is approved or declined",
            context: context,
            isRecurringOn: notifyApproveDeclined,
            onChanged: (val) {
              notifyApproveDeclined = val;
              updateUI();
            },
            showDivider: true,
          ),
          InPutSwitchWidget(
            title: "Notify when a payment is made",
            context: context,
            isRecurringOn: notifyPaymentMade,
            onChanged: (val) {
              notifyPaymentMade = val;
              updateUI();
            },
            showDivider: false,
          ),
        ],
      ),
    );

    var proforma = Container(
      color: AppPallete.kF2F2F2,
      child: Column(
        children: [
          NewInputViewWidget(
            title: "Proforma Number",
            hintText: "Proforma Number",
            controller: proformaNumberController,
          ),
          NewInputViewWidget(
            title: "Proforma Title",
            hintText: "Proforma Title",
            controller: proformaTitleController,
          ),
          InputDropdownView(
            isRequired: false,
            showDivider: false,
            title: "Payment Terms",
            defaultText: "Tap to Select",
            value: selectedPaymentTerms?.label ?? "",
            onPress: () {
              _showRepaymentPopup();
            },
          ),
          AppConstants.sizeBoxHeight10,
          TemplateWidget(
            callBack: () {
              debugPrint("estimateHeading update..");
              AutoRouter.of(context).push(
                SettingTemplatePageRoute(
                  enumSettingTemplateType: EnumSettingTemplateType.invoice,
                ),
              );
            },
          ),
          AppConstants.sizeBoxHeight10,
          PreferenceTitleArroaWidget(
            title: "Column Settings",
            callback: () {
              AutoRouter.of(context).push(
                UserColumnSettingsPageRoute(
                  updatePreferenceColumnReqParams:
                      updatePreferenceColumnReqParams,
                  onupdateColumnSettings: (reParams) {
                    updatePreferenceColumnReqParams = reParams;
                  },
                ),
              );
            },
          ),
          AppConstants.sizeBoxHeight10,
          PreferenceTitleArroaWidget(
            title: "Terms & Conditions",
            callback: () {
              AutoRouter.of(context).push(
                InvoiceEstimateTermsInoutPageRoute(
                  terms: invoiceTerms,
                  callback: (terms) {
                    invoiceTerms = terms;
                  },
                ),
              );
            },
          ),
          AppConstants.sizeBoxHeight10,
          NotesWidget(
            title: "Customer Notes",
            hintText: "Tap to Enter",
            controller: proformNotesController,
          ),
        ],
      ),
    );

    var invoice = Container(
      color: AppPallete.kF2F2F2,
      child: Column(
        children: [
          NewInputViewWidget(
            title: "Invoice Number",
            hintText: "Invoice Number",
            controller: invoiceNumberController,
          ),
          NewInputViewWidget(
            title: "Invoice Title",
            hintText: "Invoice Title",
            controller: invoiceTitleController,
          ),
          InputDropdownView(
            isRequired: false,
            showDivider: false,
            title: "Payment Terms",
            defaultText: "Tap to Select",
            value: selectedPaymentTerms?.label ?? "",
            onPress: () {
              _showRepaymentPopup();
            },
          ),
          AppConstants.sizeBoxHeight10,
          TemplateWidget(
            callBack: () {
              debugPrint("estimateHeading update..");
              AutoRouter.of(context).push(
                SettingTemplatePageRoute(
                  enumSettingTemplateType: EnumSettingTemplateType.invoice,
                ),
              );
            },
          ),
          AppConstants.sizeBoxHeight10,
          PreferenceTitleArroaWidget(
            title: "Column Settings",
            callback: () {
              AutoRouter.of(context).push(
                UserColumnSettingsPageRoute(
                  updatePreferenceColumnReqParams:
                      updatePreferenceColumnReqParams,
                  onupdateColumnSettings: (reParams) {
                    updatePreferenceColumnReqParams = reParams;
                  },
                ),
              );
            },
          ),
          AppConstants.sizeBoxHeight10,
          PreferenceTitleArroaWidget(
            title: "Terms & Conditions",
            callback: () {
              AutoRouter.of(context).push(
                InvoiceEstimateTermsInoutPageRoute(
                  terms: invoiceTerms,
                  callback: (terms) {
                    invoiceTerms = terms;
                  },
                ),
              );
            },
          ),
          AppConstants.sizeBoxHeight10,
          NotesWidget(
            title: "Customer Notes",
            hintText: "Tap to Enter",
            controller: notesController,
          ),
        ],
      ),
    );
    var estimate = Container(
      color: AppPallete.kF2F2F2,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppConstants.sizeBoxHeight10,
          NewInputViewWidget(
            title: "Estimate Number",
            hintText: "Estimate Number",
            controller: estimateNumberController,
          ),
          InputDropdownView(
            title: "Estimate Name",
            defaultText: "Tap to Select",
            value: selectedEstimateName?.name ?? "",
            onPress: () {
              _showEstimateNamePopup();
            },
          ),
          AppConstants.sizeBoxHeight10,
          TemplateWidget(
            callBack: () {
              AutoRouter.of(context).push(
                SettingTemplatePageRoute(
                  enumSettingTemplateType: EnumSettingTemplateType.estimate,
                ),
              );
            },
          ),
          AppConstants.sizeBoxHeight10,
          PreferenceTitleArroaWidget(
            title: "Terms & Conditions",
            callback: () {
              AutoRouter.of(context).push(
                InvoiceEstimateTermsInoutPageRoute(
                  terms: estimateTerms,
                  callback: (terms) {
                    estimateTerms = terms;
                  },
                ),
              );
            },
          ),
          AppConstants.sizeBoxHeight10,
          NotesWidget(
            title: "Customer Notes",
            hintText: "Tap to Enter",
            controller: estimateNotesController,
          ),
          AppConstants.sizeBoxHeight10,
        ],
      ),
    );

    var invoiceEstimateColumn = Container(
      //padding: EdgeInsets.all(15),
      color: AppPallete.kF2F2F2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('1. Items', style: AppFonts.regularStyle()),
                Padding(
                  padding: const EdgeInsets.only(left: 3.0),
                  child: Column(
                    children: [
                      RadioListTile<String>(
                        title: Text(
                          'Items (default)',
                          style: radioOptionsStyle,
                        ),
                        value: 'Items',
                        groupValue: _itemSelected,
                        onChanged: (value) {
                          setState(() {
                            _itemSelected = value!;
                          });
                        },
                        visualDensity: VisualDensity(
                          horizontal: -4,
                          vertical: -4,
                        ),
                        contentPadding: EdgeInsets.zero,
                      ),
                      RadioListTile<String>(
                        title: Text('Products', style: radioOptionsStyle),
                        value: 'Products',
                        groupValue: _itemSelected,
                        onChanged: (value) {
                          setState(() {
                            _itemSelected = value!;
                          });
                        },
                        visualDensity: VisualDensity(
                          horizontal: -4,
                          vertical: -4,
                        ),
                        contentPadding: EdgeInsets.zero,
                      ),
                      RadioListTile<String>(
                        title: Text('Services', style: radioOptionsStyle),
                        value: 'Services',
                        groupValue: _itemSelected,
                        onChanged: (value) {
                          setState(() {
                            _itemSelected = value!;
                          });
                        },
                        visualDensity: VisualDensity(
                          horizontal: -4,
                          vertical: -4,
                        ),
                        contentPadding: EdgeInsets.zero,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 0),
                  child: Row(
                    children: [
                      Radio<String>(
                        value: 'Other',
                        groupValue: _itemSelected,
                        onChanged: (value) {
                          setState(() {
                            _itemSelected = value!;
                          });
                        },
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _itemSelected = 'Other';
                          });
                        },
                        child: Text('Other:', style: radioOptionsStyle),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: _itemOtherController,
                          enabled: _itemSelected == 'Other',
                          decoration: const InputDecoration(
                            hintText: 'Enter custom value',
                            isDense: true,
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                //Text('Selected: $_selected'),
                if (_itemSelected == 'Other' &&
                    _itemOtherController.text.isNotEmpty)
                  Text('Other value: ${_itemOtherController.text}'),
              ],
            ),
          ),
          SizedBox(height: 10),
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('2. Units', style: AppFonts.regularStyle()),
                Padding(
                  padding: const EdgeInsets.only(left: 3.0),
                  child: Column(
                    children: [
                      RadioListTile<String>(
                        title: Text('Qty (default)', style: radioOptionsStyle),
                        value: 'Qty',
                        groupValue: _unitSelected,
                        onChanged: (value) {
                          setState(() {
                            _unitSelected = value!;
                          });
                        },
                        visualDensity: VisualDensity(
                          horizontal: -4,
                          vertical: -4,
                        ),
                        contentPadding: EdgeInsets.zero,
                      ),
                      RadioListTile<String>(
                        title: Text('Hours', style: radioOptionsStyle),
                        value: 'Hours',
                        groupValue: _unitSelected,
                        onChanged: (value) {
                          setState(() {
                            _unitSelected = value!;
                          });
                        },
                        visualDensity: VisualDensity(
                          horizontal: -4,
                          vertical: -4,
                        ),
                        contentPadding: EdgeInsets.zero,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 0),
                  child: Row(
                    children: [
                      Radio<String>(
                        value: 'Other',
                        groupValue: _unitSelected,
                        onChanged: (value) {
                          setState(() {
                            _unitSelected = value!;
                          });
                        },
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _unitSelected = 'Other';
                          });
                        },
                        child: Text('Other:', style: radioOptionsStyle),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: _unitOtherController,
                          enabled: _unitSelected == 'Other',
                          decoration: const InputDecoration(
                            hintText: 'Enter custom value',
                            isDense: true,
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                //Text('Selected: $_selected'),
                if (_unitSelected == 'Other' &&
                    _unitOtherController.text.isNotEmpty)
                  Text('Other value: ${_unitOtherController.text}'),
              ],
            ),
          ),
          SizedBox(height: 10),
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('3. Rate', style: AppFonts.regularStyle()),
                Padding(
                  padding: const EdgeInsets.only(left: 3.0),
                  child: Column(
                    children: [
                      RadioListTile<String>(
                        title: Text('Rate (default)', style: radioOptionsStyle),
                        value: 'Rate',
                        groupValue: _rateSelected,
                        onChanged: (value) {
                          setState(() {
                            _rateSelected = value!;
                          });
                        },
                        visualDensity: VisualDensity(
                          horizontal: -4,
                          vertical: -4,
                        ),
                        contentPadding: EdgeInsets.zero,
                      ),
                      RadioListTile<String>(
                        title: Text('Price', style: radioOptionsStyle),
                        value: 'Price',
                        groupValue: _rateSelected,
                        onChanged: (value) {
                          setState(() {
                            _rateSelected = value!;
                          });
                        },
                        visualDensity: VisualDensity(
                          horizontal: -4,
                          vertical: -4,
                        ),
                        contentPadding: EdgeInsets.zero,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 0),
                  child: Row(
                    children: [
                      Radio<String>(
                        value: 'Other',
                        groupValue: _rateSelected,
                        onChanged: (value) {
                          setState(() {
                            _rateSelected = value!;
                          });
                        },
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _rateSelected = 'Other';
                          });
                        },
                        child: Text('Other:', style: radioOptionsStyle),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: _rateOtherController,
                          enabled: _rateSelected == 'Other',
                          decoration: const InputDecoration(
                            hintText: 'Enter custom value',
                            isDense: true,
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                //Text('Selected: $_selected'),
                if (_rateSelected == 'Other' &&
                    _rateOtherController.text.isNotEmpty)
                  Text('Other value: ${_rateOtherController.text}'),
              ],
            ),
          ),
          SizedBox(height: 10),
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('4. Amount', style: AppFonts.regularStyle()),
                Padding(
                  padding: const EdgeInsets.only(left: 3.0),
                  child: Column(
                    children: [
                      RadioListTile<String>(
                        title: Text(
                          'Amount (default)',
                          style: radioOptionsStyle,
                          //style: AppFonts.regularStyle(size: 14),
                        ),
                        value: 'Amount',
                        groupValue: _amountSelected,
                        onChanged: (value) {
                          setState(() {
                            _amountSelected = value!;
                          });
                        },
                        visualDensity: VisualDensity(
                          horizontal: -4,
                          vertical: -4,
                        ),
                        contentPadding: EdgeInsets.zero,
                      ),
                      // RadioListTile<String>(
                      //   title: const Text('Price'),
                      //   value: 'Price',
                      //   groupValue: _selected,
                      //   onChanged: (value) {
                      //     setState(() {
                      //       _selected = value!;
                      //     });
                      //   },
                      //   visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                      //   contentPadding: EdgeInsets.zero,
                      // ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 0),
                  child: Row(
                    children: [
                      Radio<String>(
                        value: 'Other',
                        groupValue: _amountSelected,
                        onChanged: (value) {
                          setState(() {
                            _amountSelected = value!;
                          });
                        },
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _amountSelected = 'Other';
                          });
                        },
                        child: Text(
                          'Other:',
                          style: radioOptionsStyle,
                          //style: AppFonts.regularStyle(size: 14),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: _amountOtherController,
                          enabled: _amountSelected == 'Other',
                          decoration: const InputDecoration(
                            hintText: 'Enter custom value',
                            isDense: true,
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                //Text('Selected: $_selected'),
                if (_amountSelected == 'Other' &&
                    _amountOtherController.text.isNotEmpty)
                  Text('Other value: ${_amountOtherController.text}'),
              ],
            ),
          ),
          SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Colors.white,
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Choose custom fields:',
                      style: AppFonts.regularStyle(),
                      //style:
                      //TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8),
                    CheckboxListTile(
                      controlAffinity:
                          ListTileControlAffinity.leading, // 👈 checkbox left
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      visualDensity: const VisualDensity(
                        horizontal: -4,
                        vertical: -4,
                      ),
                      title: Text('Date', style: radioOptionsStyle),
                      value: isDateChecked,
                      onChanged: (value) =>
                          setState(() => isDateChecked = value!),
                    ),
                    CheckboxListTile(
                      controlAffinity:
                          ListTileControlAffinity.leading, // 👈 checkbox left
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      visualDensity: const VisualDensity(
                        horizontal: -4,
                        vertical: -4,
                      ),
                      title: Text('Time', style: radioOptionsStyle),
                      value: isTimeChecked,
                      onChanged: (value) =>
                          setState(() => isTimeChecked = value!),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 3),
                      child: Row(
                        children: [
                          Checkbox(
                            value: isCustomChecked,
                            onChanged: (value) =>
                                setState(() => isCustomChecked = value!),
                            visualDensity: const VisualDensity(
                              horizontal: -4,
                              vertical: -4,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text('Custom:', style: radioOptionsStyle),
                          const SizedBox(width: 5),
                          Expanded(
                            child: TextField(
                              controller: customController,
                              enabled: isCustomChecked,
                              decoration: const InputDecoration(
                                isDense: true,
                                hintText: 'Custom',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                color: Colors.white,
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Choose columns you wish to hide on invoices and estimates:',
                      style: AppFonts.regularStyle(),
                      // style:
                      //     TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8),
                    CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      visualDensity: const VisualDensity(
                        horizontal: -4,
                        vertical: -4,
                      ),
                      title: Text('Hide quantity', style: radioOptionsStyle),
                      value: isHideQtyChecked,
                      onChanged: (value) =>
                          setState(() => isHideQtyChecked = value!),
                    ),
                    CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      visualDensity: const VisualDensity(
                        horizontal: -4,
                        vertical: -4,
                      ),
                      title: Text('Hide rate', style: radioOptionsStyle),
                      value: isHideRateChecked,
                      onChanged: (value) =>
                          setState(() => isHideRateChecked = value!),
                    ),
                    CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      visualDensity: const VisualDensity(
                        horizontal: -4,
                        vertical: -4,
                      ),
                      title: Text('Hide amount', style: radioOptionsStyle),
                      activeColor: Colors.blue,
                      value: isHideAmountChecked,
                      onChanged: (value) =>
                          setState(() => isHideAmountChecked = value!),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),
            ],
          ),
        ],
      ),
    );

    return Scaffold(
      backgroundColor: AppPallete.kF2F2F2,
      appBar: AppBar(
        title: const Text("Preferences"),
        actions: [
          TextButton(
            onPressed: () {
              printInvEstResponse();
            },
            child: Text(
              "Save",
              style: AppFonts.regularStyle(color: AppPallete.blueColor),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(45),
          child: PreferencesTypeHeaderWidget(
            selectedType: selectedType,
            callBack: (type) {
              selectedType = type;
              updateUI();
            },
          ),
        ),
      ),
      body: BlocConsumer<OrganizationBloc, OrganizationState>(
        listener: (context, state) {
          if (state is UpdateInvoiceSettingsErrorState) {
            showToastification(
              context,
              state.errorMessage,
              ToastificationType.error,
            );
          }
          if (state is UpdateEstimateSettingsErrorState) {
            showToastification(
              context,
              state.errorMessage,
              ToastificationType.error,
            );
          }
          if (state is UpdateGeneralSettingsErrorState) {
            showToastification(
              context,
              state.errorMessage,
              ToastificationType.error,
            );
          }

          if (state is UpdateGeneralSettingsSuccessState ||
              state is UpdateInvoiceSettingsSuccessState ||
              state is UpdateEstimateSettingsSuccessState ||
              state is UpdateColumnSettingsSuccessState) {
            if (isShownSuccessToast == false) {
              isShownSuccessToast = true;
              showToastification(
                context,
                "Preferences updated successfully",
                ToastificationType.success,
              );

              String updatedEstimateTitle =
                  selectedEstimateName?.name ?? "Estimate";
              Utils.saveEstimate(updatedEstimateTitle);
              context.read<GeneralBloc>().add(
                    SetEstimateHeading(estimateHeading: updatedEstimateTitle),
                  );

              ColumnSettingsPref columnSettingsPref =
                  ColumnSettingsPref.fromInfo(
                qty: updatePreferenceColumnReqParams?.columnUnitsTitle,
                rate: updatePreferenceColumnReqParams?.columnRateTitle,
                hideQty: updatePreferenceColumnReqParams?.hideColumnQty,
                itemTitle: updatePreferenceColumnReqParams?.columnItemsTitle,
                hideRate: updatePreferenceColumnReqParams?.hideColumnRate,
              );

              Utils.saveColumnSettings(columnSettingsPref);
            }
          }

          if (state is UpdateGeneralSettingsSuccessState &&
              state is UpdateInvoiceSettingsSuccessState &&
              state is UpdateEstimateSettingsSuccessState &&
              state is UpdateColumnSettingsSuccessState) {
            AutoRouter.of(context).maybePop();
          }

          if (state is GetPreferenceSuccessState) {
            debugPrint("Portal Name");
            debugPrint(
              state.preferenceMainResEntity.data?.preferences?.portalName,
            );
            preferencesEntity = state.preferenceMainResEntity.data?.preferences;
            updatePreferenceColumnReqParams = UpdatePreferenceColumnReqParams(
              columnAmountOther: "",
              columnAmountTitle: preferencesEntity?.columnAmountTitle ?? "",
              columnCustom: preferencesEntity?.columnCustom ?? false,
              columnCustomTitle: preferencesEntity?.columnCustomTitle ?? "",
              columnDate: preferencesEntity?.columnDate ?? false,
              columnItemsOther: "",
              columnItemsTitle: preferencesEntity?.columnItemsTitle ?? "",
              columnRateOther: "",
              columnRateTitle: preferencesEntity?.columnRateTitle ?? "",
              columnTime: preferencesEntity?.columnTime ?? false,
              columnUnitsOther: "",
              columnUnitsTitle: preferencesEntity?.columnUnitsTitle ?? "",
              hideColumnAmount: preferencesEntity?.hideColumnAmount ?? false,
              hideColumnQty: preferencesEntity?.hideColumnQty ?? false,
              hideColumnRate: preferencesEntity?.hideColumnRate ?? false,
            );

            estimateNotesController.text =
                preferencesEntity?.estimateNotes ?? "";
            estimateNumberController.text = preferencesEntity?.estimateNo ?? "";
            attachPDF = preferencesEntity?.attachPdf ?? false;
            notifyEstimateandInvoiceOpened =
                preferencesEntity?.notifiedViewedInvoicesEstimates ?? false;
            notifyApproveDeclined =
                preferencesEntity?.notifiedApprovedDeclinedEstimates ?? false;
            notifyPaymentMade = preferencesEntity?.notifiedPayonline ?? false;
            invoiceNumberController.text = preferencesEntity?.invoiceNo ?? "";
            invoiceTitleController.text =
                preferencesEntity?.invoiceHeading ?? "";
            notesController.text = preferencesEntity?.invoiceNotes ?? "";

            portalNameController.text = preferencesEntity?.portalName ?? "";

            invoiceTerms = preferencesEntity?.invoiceTerms ?? "";
            estimateTerms = preferencesEntity?.estimateTerms ?? "";

            _itemSelected = preferencesEntity?.columnItemsTitle ?? "";
            _unitSelected = preferencesEntity?.columnUnitsTitle ?? "";
            _rateSelected = preferencesEntity?.columnRateTitle ?? "";
            selectedCurrency = currencies.firstWhere(
              (returnedCurrency) {
                if (returnedCurrency.currencyId ==
                        preferencesEntity?.currency ||
                    returnedCurrency.code == preferencesEntity?.currency) {
                  return true;
                }
                return false;
              },
              orElse: () {
                return CurrencyModel();
              },
            );

            selectedDateFormatter = dateFormatterList.firstWhere(
              (returneddateFormatter) {
                if (returneddateFormatter.format?.toLowerCase() ==
                    preferencesEntity?.dateFormat?.toLowerCase()) {
                  return true;
                }
                return false;
              },
              orElse: () {
                return DateFormatEntity();
              },
            );

            selectedEstimateName = estimateNames.firstWhere(
              (returnedEstimateName) {
                if (returnedEstimateName.name?.toLowerCase() ==
                    preferencesEntity?.estimateHeading?.toLowerCase()) {
                  return true;
                }
                return false;
              },
              orElse: () {
                return EstimateName();
              },
            );

            selectedFiscalYear = fiscalYearList.firstWhere(
              (returnedFiscalYear) {
                if (returnedFiscalYear.id?.toLowerCase() ==
                    preferencesEntity?.fiscalYear?.toLowerCase()) {
                  return true;
                }
                return false;
              },
              orElse: () {
                return FiscalYearEntity();
              },
            );

            selectedLanguage = languages.firstWhere(
              (returnedLanguage) {
                if (returnedLanguage.languageId?.toLowerCase() ==
                        preferencesEntity?.language?.toLowerCase() ||
                    returnedLanguage.code?.toLowerCase() ==
                        preferencesEntity?.language?.toLowerCase()) {
                  return true;
                }
                return false;
              },
              orElse: () {
                return LanguageModel();
              },
            );

            selectedPaperFormatter = paperFormatters.firstWhere(
              (returnedPaperFormatter) {
                if (returnedPaperFormatter.format?.toLowerCase() ==
                    preferencesEntity?.paperSize?.toLowerCase()) {
                  return true;
                }
                return false;
              },
              orElse: () {
                return PaperFormatEntity();
              },
            );

            selectedPaymentTerms = paymentTerms.firstWhere(
              (returnedPaymentTerms) {
                if (returnedPaymentTerms.value?.toLowerCase() ==
                    preferencesEntity?.paymentTerms?.toLowerCase()) {
                  return true;
                }
                return false;
              },
              orElse: () {
                return PaymentTerms();
              },
            );

            setState(() {});
          }
        },
        builder: (context, state) {
          if (state is UpdateInvoiceSettingsLoadingState ||
              state is UpdateGeneralSettingsLoadingState ||
              state is UpdateEstimateSettingsLoadingState ||
              state is UpdateColumnSettingsLoadingState) {
            return const LoadingPage(title: "Updating Invoice details...");
          }

          if (state is GetPreferenceLoadingState) {
            return const LoadingPage(title: "Loading Preference...");
          }

          return Container(
            color: AppPallete.blueColor,
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Container(
                color: AppPallete.white,
                child: switch (selectedType) {
                  EnumPreferencesType.general => general,
                  EnumPreferencesType.invoice => invoice,
                  EnumPreferencesType.estimate => estimate,
                  EnumPreferencesType.invEst => invEst,
                  EnumPreferencesType.proforma => proforma,
                  EnumPreferencesType.dashboard => dashboard,
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _loadLanguages() async {
    final String response = await rootBundle.loadString(
      'assets/files/languages.json',
    );
    languages = languageMainDataModelFromJson(response).data?.language ?? [];
    selectedLanguage = languages.firstWhere((returnedLanguage) {
      if (returnedLanguage.name?.toLowerCase() == "english") {
        return true;
      }
      return false;
    });
    _reRenderUI();
  }

  Future<void> _loadPaperFormatter() async {
    final String response = await rootBundle.loadString(
      'assets/files/paper_format.json',
    );
    paperFormatters =
        paperFormatMainResEntityFromJson(response).data?.paperFormat ?? [];
  }

  Future<void> _loadCurrencies() async {
    final String response = await rootBundle.loadString(
      'assets/files/currencies.json',
    );
    currencies = currencyMainDataModelFromJson(response).data?.currency ?? [];
  }

  Future<void> _loadDateFormatter() async {
    final String response = await rootBundle.loadString(
      'assets/files/date_formater.json',
    );
    dateFormatterList =
        dateFormaterMainResEntityFromJson(response).data?.dateFormat ?? [];
  }

  Future<void> _loadEstimateName() async {
    final String response = await rootBundle.loadString(
      'assets/files/estimate_name.json',
    );
    estimateNames =
        estimateNameMainResEntityFromJson(response).estimateName ?? [];
  }

  Future<void> _readFiscalYear() async {
    final String response = await rootBundle.loadString(
      'assets/files/fiscal_year.json',
    );
    fiscalYearList =
        fiscalYearMainResEntityFromJson(response).data?.fiscalYear ?? [];
    selectedFiscalYear ??= fiscalYearList.first;
    _reRenderUI();
  }

  Future<void> _readPaymentTerms() async {
    final String response = await rootBundle.loadString(
      'assets/files/payment_terms.json',
    );
    final res = paymentTermsResModelFromJson(response);
    paymentTerms = res.items ?? [];
    selectedPaymentTerms ??= paymentTerms.firstWhere((returnedTerms) {
      return returnedTerms.label?.toLowerCase() == "due on receipt" ||
          returnedTerms.value == "0";
    });
  }

  void _showEstimateNamePopup() {
    showDialog(
      context: context,
      builder: (context) {
        return EstimateNamePopupWidget(
          estimateNameList: estimateNames,
          defaultEstimateName: selectedEstimateName,
          callBack: (terms) {
            selectedEstimateName = terms;
            _reRenderUI();
          },
        );
      },
    );
  }

  void _showRepaymentPopup() {
    showDialog(
      context: context,
      builder: (context) {
        return PaymentTermsPopupWidget(
          paymentTerms: paymentTerms,
          defaultPaymentTerms: selectedPaymentTerms,
          callBack: (terms) {
            selectedPaymentTerms = terms;
            _reRenderUI();
          },
        );
      },
    );
  }

  void _showDateFormatterPopup() {
    showDialog(
      context: context,
      builder: (context) {
        return DateFormaterPopupWidget(
          dateFormaterList: dateFormatterList,
          defaultDateFormater: selectedDateFormatter,
          callBack: (formatter) {
            selectedDateFormatter = formatter;
            _reRenderUI();
          },
        );
      },
    );
  }

  void _showPaperFormatterPopup() {
    showDialog(
      context: context,
      builder: (context) {
        return PaperFormatPopupWidget(
          paperFormatters: paperFormatters,
          defaultPaperFormat: selectedPaperFormatter,
          callBack: (formatter) {
            selectedPaperFormatter = formatter;
            _reRenderUI();
          },
        );
      },
    );
  }

  void _showLanguagePopup() {
    showDialog(
      context: context,
      builder: (context) {
        return LanguageListPopupWidget(
          languages: languages,
          defaultLanguage: selectedLanguage,
          callBack: (language) {
            selectedLanguage = language;
            _reRenderUI();
          },
        );
      },
    );
  }

  void _showFiscalYearPopup() {
    showDialog(
      context: context,
      builder: (context) {
        return FiscalYearPopupWidget(
          fiscalYearList: fiscalYearList,
          defaultFiscalYear: selectedFiscalYear,
          callBack: (fiscalYear) {
            selectedFiscalYear = fiscalYear;
            _reRenderUI();
          },
        );
      },
    );
  }

  void _showCurrencyPopup() {
    showDialog(
      context: context,
      builder: (context) {
        return CurrencyListPopupWidget(
          currencies: currencies,
          defaultCurrency: selectedCurrency,
          callBack: (currency) {
            selectedCurrency = currency;
            _reRenderUI();
          },
        );
      },
    );
  }

  void _reRenderUI() {
    setState(() {});
  }

  void _loadPreference() {
    context.read<OrganizationBloc>().add(
          GetPreferenceDetailsEvent(
            preferenceDetailsReqParams: PreferenceDetailsReqParams(),
          ),
        );
  }
}

class TemplateWidget extends StatelessWidget {
  final Function()? callBack;
  const TemplateWidget({super.key, required this.callBack});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callBack,
      child: Container(
        padding: AppConstants.horizontalVerticalPadding,
        color: AppPallete.white,
        child: Row(
          children: [
            Container(
              color: AppPallete.lightBlueColor,
              width: 40,
              height: 40,
              child: const Icon(Icons.file_copy, color: AppPallete.blueColor),
            ),
            AppConstants.sizeBoxWidth10,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Template", style: AppFonts.regularStyle()),
                  Text(
                    "Classic",
                    style: AppFonts.regularStyle(
                      color: AppPallete.k666666,
                      size: 14,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: AppPallete.borderColor),
          ],
        ),
      ),
    );
  }
}

class PreferenceTitleArroaWidget extends StatelessWidget {
  final String title;
  final Function()? callback;
  const PreferenceTitleArroaWidget({
    super.key,
    required this.title,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        padding: AppConstants.horizonta16lVerticalPadding10,
        color: AppPallete.white,
        child: Row(
          children: [
            Expanded(child: Text(title, style: AppFonts.regularStyle())),
            const Icon(Icons.chevron_right, color: AppPallete.borderColor),
          ],
        ),
      ),
    );
  }
}

class InvEstReqParams {
  final String columnItemTitle;
  final String columnItemOther;
  final String columnUnitTitle;
  final String columnUnitOther;
  final String columnRateTitle;
  final String columnRateOther;
  final String columnAmountTitle;
  final String columnAmountOther;
  final bool columnDate;
  final bool columnTime;
  final bool columnCustom;
  final String columnCustomTitle;
  final bool columnQty;
  final bool columnRate;
  final bool columnAmount;

  InvEstReqParams({
    required this.columnItemOther,
    required this.columnItemTitle,
    required this.columnUnitTitle,
    required this.columnUnitOther,
    required this.columnRateTitle,
    required this.columnRateOther,
    required this.columnAmountTitle,
    required this.columnAmountOther,
    required this.columnDate,
    required this.columnTime,
    required this.columnCustom,
    required this.columnCustomTitle,
    required this.columnQty,
    required this.columnRate,
    required this.columnAmount,
  });

  @override
  String toString() {
    return "selected item name: $columnItemTitle,  selected item other: $columnItemOther";
  }
}
