import 'package:auto_route/auto_route.dart';
import 'package:billbooks_app/core/app_constants.dart';
import 'package:billbooks_app/core/constants/assets.dart';
import 'package:billbooks_app/core/theme/app_fonts.dart';
import 'package:billbooks_app/core/theme/app_pallete.dart';
import 'package:billbooks_app/core/utils/escape_html_code.dart';
import 'package:billbooks_app/core/utils/show_toast.dart';
import 'package:billbooks_app/core/widgets/fiscal_year_popup.dart';
import 'package:billbooks_app/core/widgets/input_dropdown_view.dart';
import 'package:billbooks_app/core/widgets/item_separator.dart';
import 'package:billbooks_app/core/widgets/loading_page.dart';
import 'package:billbooks_app/core/widgets/new_multiline_input_widget.dart';
import 'package:billbooks_app/features/more/settings/domain/entity/organization_details_entity.dart';
import 'package:billbooks_app/features/more/settings/domain/usecase/organization_list_usecase.dart';
import 'package:billbooks_app/features/more/settings/domain/usecase/update_organization_usecase.dart';
import 'package:billbooks_app/features/more/settings/presentation/bloc/organization_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:toastification/toastification.dart';

import '../../../../core/models/country_model.dart';
import '../../../../core/models/language_model.dart';
import '../../../../core/widgets/country_list_popup_widget.dart';
import '../../../../core/widgets/currency_list_popup_widget.dart';
import '../../../../core/widgets/language_list_popup_widget.dart';
import '../../../../core/widgets/new_inputview_widget.dart';
import '../../../../core/widgets/section_header_widget.dart';
import '../../../../core/widgets/time_zone_popup_widget.dart';
import '../../../clients/presentation/Models/client_currencies.dart';
import '../../../invoice/domain/entities/time_zone_model.dart';
import '../domain/entity/fiscal_year_entity.dart';
import 'package:collection/collection.dart';

@RoutePage()
class OrganizationProfilePage extends StatefulWidget {
  const OrganizationProfilePage({super.key});

  @override
  State<OrganizationProfilePage> createState() =>
      _OrganizationProfilePageState();
}

class _OrganizationProfilePageState extends State<OrganizationProfilePage> {
  TextEditingController companyNameController = TextEditingController();
  TextEditingController streetaddressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController postalController = TextEditingController();
  TextEditingController taxIdController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController faxController = TextEditingController();
  TextEditingController websiteController = TextEditingController();
  TextEditingController primaryContactController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  OrganizationEntity? organizationEntity;
  List<FiscalYearEntity> fiscalYearList = [];
  List<CurrencyModel> currencies = [];
  List<LanguageModel> languages = [];
  List<Timezone> timezones = [];
  List<CountryModel> countries = [];
  CountryModel? selectedCountry;
  CurrencyModel? selectedCurrency;
  LanguageModel? selectedLanguage;
  Timezone? selectedTimezones;
  FiscalYearEntity? selectedFiscalYear;
  var unescape = EscapeHtmlCode();

  @override
  void initState() {
    _readFiscalYear();
    _readTimeZones();
    _loadLanguages();
    _loadCurrencies();
    _loadCountries();
    _getOrganizationDetails();
    super.initState();
  }

  Future<void> _loadLanguages() async {
    final String response =
        await rootBundle.loadString('assets/files/languages.json');
    languages = languageMainDataModelFromJson(response).data?.language ?? [];

    selectedLanguage = languages.firstWhereOrNull((returnedLanguage) {
      if (returnedLanguage.name?.toLowerCase() == "english") {
        return true;
      }
      return false;
    });

    _reRenderUI();
  }

  Future<void> _loadCurrencies() async {
    final String response =
        await rootBundle.loadString('assets/files/currencies.json');
    currencies = currencyMainDataModelFromJson(response).data?.currency ?? [];
  }

  Future<void> _readTimeZones() async {
    final String response =
        await rootBundle.loadString('assets/files/time_zones.json');
    timezones = timeZoneResModelFromJson(response).timezone ?? [];
  }

  void _getOrganizationDetails() {
    context.read<OrganizationBloc>().add(GetOrganizationDetailsEvent(
        organizationReqParams: OrganizationReqParams()));
  }

  Future<void> _readFiscalYear() async {
    final String response =
        await rootBundle.loadString('assets/files/fiscal_year.json');
    fiscalYearList =
        fiscalYearMainResEntityFromJson(response).data?.fiscalYear ?? [];
    selectedFiscalYear ??= fiscalYearList.first;
    _reRenderUI();
  }

  void _populateData() {
    primaryContactController.text =
        organizationEntity?.primarycontactName ?? "";
    emailController.text = organizationEntity?.primarycontactEmail ?? "";
    companyNameController.text = organizationEntity?.name ?? "";

    final countryId = organizationEntity?.countryId;
    if (countryId != null) {
      selectedCountry = countries.firstWhereOrNull(
        (returnedCountry) {
          return returnedCountry.countryId == countryId;
        },
      );
    }

    final currencyId = organizationEntity?.currency;
    if (currencyId != null) {
      selectedCurrency = currencies.firstWhereOrNull(
        (returnedCurrency) {
          return returnedCurrency.currencyId == currencyId ||
              returnedCurrency.code == currencyId;
        },
      );
    }

    final timeZoneId = organizationEntity?.timezoneId;
    if (timeZoneId != null) {
      selectedTimezones = timezones.firstWhereOrNull((returnedTimeZone) {
        return returnedTimeZone.timezoneId == timeZoneId;
      });
    }

    final languageId = organizationEntity?.language;
    if (languageId != null) {
      selectedLanguage = languages.firstWhereOrNull((returnedLng) {
        return returnedLng.code == languageId ||
            returnedLng.languageId == languageId;
      });
    }
    if (organizationEntity != null) {
      companyNameController.text =
          unescape.convert(organizationEntity?.name ?? "");
      streetaddressController.text =
          unescape.convert(organizationEntity?.address ?? "");
      cityController.text = unescape.convert(organizationEntity?.city ?? "");
      stateController.text = unescape.convert(organizationEntity?.state ?? "");
      postalController.text =
          unescape.convert(organizationEntity?.zipcode ?? "");
      taxIdController.text = unescape.convert(organizationEntity?.fax ?? "");
      phoneNumberController.text =
          unescape.convert(organizationEntity?.phone ?? "");
      faxController.text = unescape.convert(organizationEntity?.fax ?? "");
      websiteController.text =
          unescape.convert(organizationEntity?.website ?? "");
    }
  }

  void _updateOrganization() {
    final reqParms = UpdateOrganizationReqParams(
      address: streetaddressController.text,
      website: websiteController.text,
      fiscalYear: selectedFiscalYear?.id ?? "",
      currency: selectedCurrency?.code ?? "",
      language: selectedLanguage?.code ?? "",
      primarycontactEmail: emailController.text,
      primarycontactName: primaryContactController.text,
      registrationNo: taxIdController.text,
      phone: phoneNumberController.text,
      fax: faxController.text,
      state: stateController.text,
      zipcode: postalController.text,
      country: selectedCountry?.countryId ?? "",
      timezone: selectedTimezones?.timezoneId ?? "",
      name: companyNameController.text,
      city: cityController.text,
    );

    debugPrint("Req Params: ${reqParms.address}");

    context.read<OrganizationBloc>().add(
        UpdateOrganizationDetailsEvent(updateOrganizationReqParams: reqParms));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPallete.kF2F2F2,
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                _updateOrganization();
              },
              child: Text(
                "Save",
                style: AppFonts.regularStyle(color: AppPallete.blueColor),
              ))
        ],
        title: const Text("Organization Profile"),
      ),
      body: SafeArea(
        child: BlocConsumer<OrganizationBloc, OrganizationState>(
          listener: (context, state) {
            if (state is OrganizationErrorState) {}

            if (state is OrganizationSuccessState) {
              debugPrint("OrganizationSuccessState");

              organizationEntity =
                  state.organizationDetailsMainResEntity.data?.organization;
              _populateData();
            }

            if (state is UpdateOrganizationSuccessState) {
              showToastification(
                  context,
                  "Your organization profile has been saved",
                  ToastificationType.success);
              AutoRouter.of(context).maybePop();
            }
            if (state is UpdateOrganizationErrorState) {
              showToastification(
                  context, state.errorMessage, ToastificationType.error);
            }
          },
          builder: (context, state) {
            if (state is OrganizationLoadingState) {
              return const LoadingPage(title: "Loading organization...");
            }

            if (state is UpdateOrganizationLoadingState) {
              return const LoadingPage(title: "Updating organization...");
            }

            return SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Column(
                children: [
                  AppConstants.sizeBoxHeight10,
                  Container(
                    width: double.infinity,
                    color: AppPallete.white,
                    //padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              size: 20,
                              Icons.camera_alt_rounded,
                              color: AppPallete.greenColor,
                            )),
                        Center(
                          child: Image.asset(
                            Assets.assetsImagesIcWebwingz,
                            height: 40,
                          ),
                        ),
                      ],
                    ),
                  ),
                  AppConstants.sizeBoxHeight10,
                  OrganizationInfoWidget(
                    companyNameController: companyNameController,
                    streetaddressController: streetaddressController,
                    cityController: cityController,
                    stateController: stateController,
                    postalController: postalController,
                    taxIdController: taxIdController,
                    phoneNumberController: phoneNumberController,
                    faxController: faxController,
                    websiteController: websiteController,
                    organizationEntity:
                        organizationEntity ?? OrganizationEntity(),
                    onTapCountry: () {
                      _showCountryPopup();
                    },
                    selectedCountry: selectedCountry,
                  ),
                  PreferenceWidget(
                    selectedCurrency: selectedCurrency,
                    selectedFiscalYear: selectedFiscalYear,
                    selectedLanguage: selectedLanguage,
                    selectedTimezones: selectedTimezones,
                    unescape: unescape,
                    onTapFiscalYear: () {
                      _showFiscalYearPopup();
                    },
                    onTapCurrency: () {
                      _showCurrencyPopup();
                    },
                    onTapLanguage: () {
                      _showLanguagePopup();
                    },
                    onTapTimeZone: () {
                      _showTimezonePopup();
                    },
                  ),
                  PrimariContacts(
                      primaryContactController: primaryContactController,
                      emailController: emailController)
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _showTimezonePopup() {
    showDialog(
        context: context,
        builder: (context) {
          return TimeZonePopupWidget(
              timeZones: timezones,
              defaultTimeZone: selectedTimezones,
              callBack: (terms) {
                selectedTimezones = terms;
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

  Future<void> _loadCountries() async {
    final String response =
        await rootBundle.loadString('assets/files/countries.json');
    countries = countryMainDataModelFromJson(response).country ?? [];
  }

  void _showCountryPopup() {
    showDialog(
        context: context,
        builder: (context) {
          return CountryListPopupWidget(
              countries: countries,
              defaultCountry: selectedCountry,
              callBack: (country) {
                selectedCountry = country;
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

  void _reRenderUI() {
    setState(() {});
  }
}

class PrimariContacts extends StatelessWidget {
  const PrimariContacts({
    super.key,
    required this.primaryContactController,
    required this.emailController,
  });

  final TextEditingController primaryContactController;
  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppPallete.white,
      child: Column(
        children: [
          const SectionHeaderWidget(
            title: 'PRIMARY CONTACT',
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Text(
              'You can configure email address to communicate with your contacts.',
              style: AppFonts.regularStyle(
                  size: 14, color: AppPallete.borderColor),
            ),
          ),
          const ItemSeparator(),
          NewInputViewWidget(
            title: 'Primary Contact',
            hintText: 'Primary Contact',
            controller: primaryContactController,
          ),
          NewInputViewWidget(
            title: 'Email',
            hintText: 'Email',
            controller: emailController,
            showDivider: false,
            inputAction: TextInputAction.done,
          ),
        ],
      ),
    );
  }
}

class PreferenceWidget extends StatelessWidget {
  final Function() onTapFiscalYear;
  final Function() onTapLanguage;
  final Function() onTapTimeZone;
  final Function() onTapCurrency;
  final CurrencyModel? selectedCurrency;
  final LanguageModel? selectedLanguage;
  final Timezone? selectedTimezones;
  final FiscalYearEntity? selectedFiscalYear;
  final EscapeHtmlCode unescape;

  const PreferenceWidget({
    super.key,
    required this.onTapFiscalYear,
    required this.onTapCurrency,
    required this.onTapLanguage,
    required this.onTapTimeZone,
    this.selectedCurrency,
    this.selectedFiscalYear,
    this.selectedLanguage,
    this.selectedTimezones,
    required this.unescape,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SectionHeaderWidget(
          title: 'PREFERENCES',
        ),
        InputDropdownView(
            title: "Fiscal Year",
            defaultText: "Tap to Select",
            isRequired: false,
            value: unescape.convert(selectedFiscalYear?.fromTo ?? ""),
            onPress: onTapFiscalYear),
        InputDropdownView(
            title: "Base Currency",
            isRequired: false,
            defaultText: "Tap to Select",
            value: unescape.convert(selectedCurrency?.name ?? ""),
            onPress: onTapCurrency),
        InputDropdownView(
            title: "Timezone",
            defaultText: "Tap to Select",
            isRequired: false,
            value: unescape.convert(selectedTimezones?.name ?? ""),
            onPress: onTapTimeZone),
        InputDropdownView(
            title: "Language",
            defaultText: "Tap to Select",
            isRequired: false,
            value: unescape.convert(selectedLanguage?.name ?? ""),
            onPress: onTapLanguage),
      ],
    );
  }
}

class OrganizationInfoWidget extends StatelessWidget {
  const OrganizationInfoWidget({
    super.key,
    required this.companyNameController,
    required this.streetaddressController,
    required this.cityController,
    required this.stateController,
    required this.postalController,
    required this.taxIdController,
    required this.phoneNumberController,
    required this.faxController,
    required this.websiteController,
    required this.organizationEntity,
    required this.onTapCountry,
    this.selectedCountry,
  });

  final TextEditingController companyNameController;
  final TextEditingController streetaddressController;
  final TextEditingController cityController;
  final TextEditingController stateController;
  final TextEditingController postalController;
  final TextEditingController taxIdController;
  final TextEditingController phoneNumberController;
  final TextEditingController faxController;
  final TextEditingController websiteController;
  final OrganizationEntity organizationEntity;
  final CountryModel? selectedCountry;
  final Function() onTapCountry;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppPallete.white,
      child: Column(
        children: [
          NewInputViewWidget(
            title: 'Company Name',
            hintText: 'Company Name',
            controller: companyNameController,
          ),
          NewMultilineInputWidget(
              title: "Street Address",
              hintText: "Tap to Enter",
              isRequired: false,
              controller: streetaddressController),
          NewInputViewWidget(
            title: 'City/Suburb',
            hintText: 'City/Suburb',
            controller: cityController,
            isRequired: false,
          ),
          NewInputViewWidget(
            title: 'State/Country',
            hintText: 'State/Country',
            controller: stateController,
          ),
          NewInputViewWidget(
            title: 'Postal/Zipcode',
            hintText: 'Postal/Zipcode',
            controller: postalController,
            isRequired: false,
          ),
          InputDropdownView(
              title: "Country",
              defaultText: "Tap to Select",
              value: selectedCountry?.name ?? "",
              onPress: onTapCountry),
          NewInputViewWidget(
            title: 'Company/Tax ID',
            hintText: 'Company/Tax ID',
            controller: taxIdController,
            isRequired: false,
          ),
          NewInputViewWidget(
            title: 'Phone Number',
            hintText: 'Phone Number',
            controller: phoneNumberController,
            isRequired: false,
            inputType: TextInputType.phone,
          ),
          NewInputViewWidget(
            title: 'Fax Number',
            hintText: 'Fax Number',
            controller: faxController,
            isRequired: false,
          ),
          NewInputViewWidget(
            title: 'Website',
            hintText: 'Website',
            controller: websiteController,
            isRequired: false,
            showDivider: false,
            inputType: TextInputType.url,
          ),
        ],
      ),
    );
  }
}
