import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:billbooks_app/core/app_constants.dart';
import 'package:billbooks_app/core/theme/app_fonts.dart';
import 'package:billbooks_app/core/theme/app_pallete.dart';
import 'package:billbooks_app/core/utils/show_toast.dart';
import 'package:billbooks_app/core/widgets/date_formater_popup_widget.dart';
import 'package:billbooks_app/core/widgets/estimate_name_popup_widget.dart';
import 'package:billbooks_app/core/widgets/input_dropdown_view.dart';
import 'package:billbooks_app/core/widgets/input_switch_widget.dart';
import 'package:billbooks_app/core/widgets/loading_page.dart';
import 'package:billbooks_app/core/widgets/new_inputview_widget.dart';
import 'package:billbooks_app/core/widgets/notes_widget.dart';
import 'package:billbooks_app/core/widgets/paper_format_popup_widget.dart';
import 'package:billbooks_app/core/widgets/section_header_widget.dart';
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

enum EnumPreferencesType { general, invoice, estimate }

extension EnumPreferencesTypeExtension on EnumPreferencesType {
  String get title {
    switch (this) {
      case EnumPreferencesType.general:
        return "General";
      case EnumPreferencesType.invoice:
        return "Invoice";
      case EnumPreferencesType.estimate:
        return "Estimate";
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

  void _updatePreference() {
    //if (selectedType == EnumPreferencesType.general) {
    context.read<OrganizationBloc>().add(UpdatePreferenceGeneralDetailsEvent(
            preferenceUpdateReqParams: UpdatePrefGeneralReqParams(
          portalName: "SSMK",
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
        )));
    // }

    // if (selectedType == EnumPreferencesType.invoice) {
    context.read<OrganizationBloc>().add(UpdatePreferenceInvoiceDetailsEvent(
            preferenceUpdateReqParams: UpdatePrefInvoiceReqParams(
          heading: invoiceTitleController.text,
          number: invoiceNumberController.text,
          notes: notesController.text,
          paymentTerms: selectedPaymentTerms?.value ?? "",
          template: "",
          terms: invoiceTerms,
        )));
    // }
    //if (selectedType == EnumPreferencesType.estimate) {
    context.read<OrganizationBloc>().add(UpdatePreferenceEstimateDetailsEvent(
        preferenceUpdateReqParams: UpdatePreferenceEstimateReqParams(
            estimateName: selectedEstimateName?.name ?? "",
            estimateNo: estimateNumberController.text,
            estimateNotes: estimateNotesController.text,
            estimateTemplate: '',
            estimateTerms: estimateTerms)));

    if (updatePreferenceColumnReqParams != null) {
      context.read<OrganizationBloc>().add(UpdatePreferenceColumnDetailsEvent(
          preferenceUpdateReqParams: updatePreferenceColumnReqParams!));
    }

    //}
  }

  @override
  Widget build(BuildContext context) {
    void updateUI() {
      setState(() {});
    }

    var general = Container(
      color: AppPallete.kF2F2F2,
      child: Column(
        children: [
          AppConstants.sizeBoxHeight10,
          InputDropdownView(
              title: "Fiscal Year",
              isRequired: false,
              defaultText: "Tap to Select",
              value: selectedFiscalYear?.fromTo ?? "",
              onPress: () {
                _showFiscalYearPopup();
              }),
          InputDropdownView(
              title: "Base Currency",
              isRequired: false,
              defaultText: "Tap to Select",
              value: selectedCurrency?.name ?? "",
              onPress: () {
                _showCurrencyPopup();
              }),
          InputDropdownView(
              title: "Date Formatter",
              isRequired: false,
              defaultText: "Tap to Select",
              value: selectedDateFormatter?.format ?? "",
              onPress: () {
                _showDateFormatterPopup();
              }),
          InputDropdownView(
              title: "Paper Size",
              isRequired: false,
              defaultText: "Tap to Select",
              value: selectedPaperFormatter?.format ?? "",
              onPress: () {
                _showPaperFormatterPopup();
              }),
          InputDropdownView(
              title: "Language",
              isRequired: false,
              defaultText: "Tap to Select",
              value: selectedLanguage?.name ?? "",
              showDivider: false,
              onPress: () {
                _showLanguagePopup();
              }),
          SectionHeaderWidget(title: "PDF Attachment".toUpperCase()),
          InPutSwitchWidget(
              title:
                  "Attach PDF by default while sending invoices and estimates",
              context: context,
              isRecurringOn: attachPDF,
              onChanged: (val) {
                attachPDF = val;
                updateUI();
              },
              showDivider: false),
          SectionHeaderWidget(title: "Notifications".toUpperCase()),
          InPutSwitchWidget(
              title: "Notify when estimates and invoices is opened",
              context: context,
              isRecurringOn: notifyEstimateandInvoiceOpened,
              onChanged: (val) {
                notifyEstimateandInvoiceOpened = val;
                updateUI();
              },
              showDivider: true),
          InPutSwitchWidget(
              title: "Notify when estimates is approved or declined",
              context: context,
              isRecurringOn: notifyApproveDeclined,
              onChanged: (val) {
                notifyApproveDeclined = val;
                updateUI();
              },
              showDivider: true),
          InPutSwitchWidget(
              title: "Notify when a payment is made",
              context: context,
              isRecurringOn: notifyPaymentMade,
              onChanged: (val) {
                notifyPaymentMade = val;
                updateUI();
              },
              showDivider: false),
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
              controller: invoiceNumberController),
          NewInputViewWidget(
              title: "Invoice Title",
              hintText: "Invoice Title",
              controller: invoiceTitleController),
          InputDropdownView(
              isRequired: false,
              showDivider: false,
              title: "Payment Terms",
              defaultText: "Tap to Select",
              value: selectedPaymentTerms?.label ?? "",
              onPress: () {
                _showRepaymentPopup();
              }),
          AppConstants.sizeBoxHeight10,
          TemplateWidget(
            callBack: () {
              AutoRouter.of(context).push(SettingTemplatePageRoute(
                  enumSettingTemplateType: EnumSettingTemplateType.invoice));
            },
          ),
          AppConstants.sizeBoxHeight10,
          PreferenceTitleArroaWidget(
            title: "Column Settings",
            callback: () {
              AutoRouter.of(context).push(UserColumnSettingsPageRoute(
                  preferencesEntity: preferencesEntity,
                  onupdateColumnSettings: (reParams) {
                    updatePreferenceColumnReqParams = reParams;
                  }));
            },
          ),
          AppConstants.sizeBoxHeight10,
          PreferenceTitleArroaWidget(
            title: "Terms & Conditions",
            callback: () {
              AutoRouter.of(context).push(InvoiceEstimateTermsInoutPageRoute(
                terms: invoiceTerms,
                callback: (terms) {
                  invoiceTerms = terms;
                },
              ));
            },
          ),
          AppConstants.sizeBoxHeight10,
          NotesWidget(
            title: "Customer Notes",
            hintText: "Tap to Enter",
            controller: notesController,
          )
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
              controller: estimateNumberController),
          InputDropdownView(
              title: "Estimate Name",
              defaultText: "Tap to Select",
              value: selectedEstimateName?.name ?? "",
              onPress: () {
                _showEstimateNamePopup();
              }),
          AppConstants.sizeBoxHeight10,
          TemplateWidget(callBack: () {
            AutoRouter.of(context).push(SettingTemplatePageRoute(
                enumSettingTemplateType: EnumSettingTemplateType.estimate));
          }),
          AppConstants.sizeBoxHeight10,
          PreferenceTitleArroaWidget(
            title: "Terms & Conditions",
            callback: () {
              AutoRouter.of(context).push(InvoiceEstimateTermsInoutPageRoute(
                terms: estimateTerms,
                callback: (terms) {
                  estimateTerms = terms;
                },
              ));
            },
          ),
          AppConstants.sizeBoxHeight10,
          NotesWidget(
              title: "Customer Notes",
              hintText: "Tap to Enter",
              controller: estimateNotesController),
          AppConstants.sizeBoxHeight10,
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
                _updatePreference();
              },
              child: Text(
                "Save",
                style: AppFonts.regularStyle(color: AppPallete.blueColor),
              ))
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
                context, state.errorMessage, ToastificationType.error);
          }
          if (state is UpdateEstimateSettingsErrorState) {
            showToastification(
                context, state.errorMessage, ToastificationType.error);
          }
          if (state is UpdateGeneralSettingsErrorState) {
            showToastification(
                context, state.errorMessage, ToastificationType.error);
          }

          if (state is UpdateGeneralSettingsSuccessState ||
              state is UpdateInvoiceSettingsSuccessState ||
              state is UpdateEstimateSettingsSuccessState ||
              state is UpdateColumnSettingsSuccessState) {
            if (isShownSuccessToast == false) {
              isShownSuccessToast = true;
              showToastification(context, "Preferences updated successfully",
                  ToastificationType.success);
            }
            AutoRouter.of(context).maybePop();
          }

          if (state is GetPreferenceSuccessState) {
            debugPrint("Portal Name");
            debugPrint(
                state.preferenceMainResEntity.data?.preferences?.portalName);
            preferencesEntity = state.preferenceMainResEntity.data?.preferences;
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

            invoiceTerms = preferencesEntity?.invoiceTerms ?? "";
            estimateTerms = preferencesEntity?.estimateTerms ?? "";

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

            selectedDateFormatter =
                dateFormatterList.firstWhere((returneddateFormatter) {
              if (returneddateFormatter.format?.toLowerCase() ==
                  preferencesEntity?.dateFormat?.toLowerCase()) {
                return true;
              }
              return false;
            }, orElse: () {
              return DateFormatEntity();
            });

            selectedEstimateName =
                estimateNames.firstWhere((returnedEstimateName) {
              if (returnedEstimateName.name?.toLowerCase() ==
                  preferencesEntity?.estimateHeading?.toLowerCase()) {
                return true;
              }
              return false;
            }, orElse: () {
              return EstimateName();
            });

            selectedFiscalYear =
                fiscalYearList.firstWhere((returnedFiscalYear) {
              if (returnedFiscalYear.id?.toLowerCase() ==
                  preferencesEntity?.fiscalYear?.toLowerCase()) {
                return true;
              }
              return false;
            }, orElse: () {
              return FiscalYearEntity();
            });

            selectedLanguage = languages.firstWhere((returnedLanguage) {
              if (returnedLanguage.languageId?.toLowerCase() ==
                      preferencesEntity?.language?.toLowerCase() ||
                  returnedLanguage.code?.toLowerCase() ==
                      preferencesEntity?.language?.toLowerCase()) {
                return true;
              }
              return false;
            }, orElse: () {
              return LanguageModel();
            });

            selectedPaperFormatter =
                paperFormatters.firstWhere((returnedPaperFormatter) {
              if (returnedPaperFormatter.format?.toLowerCase() ==
                  preferencesEntity?.paperSize?.toLowerCase()) {
                return true;
              }
              return false;
            }, orElse: () {
              return PaperFormatEntity();
            });

            selectedPaymentTerms =
                paymentTerms.firstWhere((returnedPaymentTerms) {
              if (returnedPaymentTerms.value?.toLowerCase() ==
                  preferencesEntity?.paymentTerms?.toLowerCase()) {
                return true;
              }
              return false;
            }, orElse: () {
              return PaymentTerms();
            });

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
                color: AppPallete.greenColor,
                child: switch (selectedType) {
                  EnumPreferencesType.general => general,
                  EnumPreferencesType.invoice => invoice,
                  EnumPreferencesType.estimate => estimate,
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _loadLanguages() async {
    final String response =
        await rootBundle.loadString('assets/files/languages.json');
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
    final String response =
        await rootBundle.loadString('assets/files/paper_format.json');
    paperFormatters =
        paperFormatMainResEntityFromJson(response).data?.paperFormat ?? [];
  }

  Future<void> _loadCurrencies() async {
    final String response =
        await rootBundle.loadString('assets/files/currencies.json');
    currencies = currencyMainDataModelFromJson(response).data?.currency ?? [];
  }

  Future<void> _loadDateFormatter() async {
    final String response =
        await rootBundle.loadString('assets/files/date_formater.json');
    dateFormatterList =
        dateFormaterMainResEntityFromJson(response).data?.dateFormat ?? [];
  }

  Future<void> _loadEstimateName() async {
    final String response =
        await rootBundle.loadString('assets/files/estimate_name.json');
    estimateNames =
        estimateNameMainResEntityFromJson(response).estimateName ?? [];
  }

  Future<void> _readFiscalYear() async {
    final String response =
        await rootBundle.loadString('assets/files/fiscal_year.json');
    fiscalYearList =
        fiscalYearMainResEntityFromJson(response).data?.fiscalYear ?? [];
    selectedFiscalYear ??= fiscalYearList.first;
    _reRenderUI();
  }

  Future<void> _readPaymentTerms() async {
    final String response =
        await rootBundle.loadString('assets/files/payment_terms.json');
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
              });
        });
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
              });
        });
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
              });
        });
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
              });
        });
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
              });
        });
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
              });
        });
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
              });
        });
  }

  void _reRenderUI() {
    setState(() {});
  }

  void _loadPreference() {
    context.read<OrganizationBloc>().add(GetPreferenceDetailsEvent(
        preferenceDetailsReqParams: PreferenceDetailsReqParams()));
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
              child: const Icon(
                Icons.file_copy,
                color: AppPallete.blueColor,
              ),
            ),
            AppConstants.sizeBoxWidth10,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Template",
                    style: AppFonts.regularStyle(),
                  ),
                  Text(
                    "Classic",
                    style: AppFonts.regularStyle(
                        color: AppPallete.k666666, size: 14),
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
    );
  }
}

class PreferenceTitleArroaWidget extends StatelessWidget {
  final String title;
  final Function()? callback;
  const PreferenceTitleArroaWidget(
      {super.key, required this.title, required this.callback});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        padding: AppConstants.horizonta16lVerticalPadding10,
        color: AppPallete.white,
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: AppFonts.regularStyle(),
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: AppPallete.borderColor,
            )
          ],
        ),
      ),
    );
  }
}
