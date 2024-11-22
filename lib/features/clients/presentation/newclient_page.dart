import 'package:auto_route/auto_route.dart';
import 'package:billbooks_app/core/models/country_model.dart';
import 'package:billbooks_app/core/models/language_model.dart';
import 'package:billbooks_app/core/theme/app_fonts.dart';
import 'package:billbooks_app/core/theme/app_pallete.dart';
import 'package:billbooks_app/core/utils/utils.dart';
import 'package:billbooks_app/core/widgets/input_dropdown_view.dart';
import 'package:billbooks_app/core/widgets/language_list_popup_widget.dart';
import 'package:billbooks_app/core/widgets/new_inputview_widget.dart';
import 'package:billbooks_app/core/widgets/payment_terms_popup_widget.dart';
import 'package:billbooks_app/features/clients/domain/usecase/add_client_usecase.dart';
import 'package:billbooks_app/features/clients/domain/usecase/client_usecase.dart';
import 'package:billbooks_app/features/clients/presentation/Models/client_add_address.dart';
import 'package:billbooks_app/features/clients/presentation/Models/client_currencies.dart';
import 'package:billbooks_app/features/clients/presentation/bloc/client_bloc.dart';
import 'package:billbooks_app/localization/locales.dart';
import 'package:billbooks_app/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';
import 'package:toastification/toastification.dart';
import '../../../../core/widgets/item_separator.dart';
import '../../../core/app_constants.dart';
import '../../../core/utils/show_toast.dart';
import '../../../core/widgets/app_alert_widget.dart';
import '../../../core/widgets/currency_list_popup_widget.dart';
import '../../../core/widgets/loading_page.dart';
import '../../../core/widgets/notes_widget.dart';
import '../../invoice/domain/entities/payment_terms_model.dart';
import '../domain/entities/client_list_entity.dart';
import 'Models/client_person_model.dart';
import 'widgets/newClient_ other_details_input_view.dart';
import 'widgets/new_client_section_widget.dart';
import 'widgets/newclient_Address_details_inputview.dart';
import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';

@RoutePage()
class NewClientPage extends StatefulWidget {
  final ClientEntity? clientEntity;
  final Function() clientRemoved;
  final Function()? refreshClient;
  const NewClientPage({
    Key? key,
    this.clientEntity,
    this.refreshClient,
    required this.clientRemoved,
  }) : super(key: key);

  @override
  State<NewClientPage> createState() => _NewClientPageState();
}

class _NewClientPageState extends State<NewClientPage> {
  ClientEntity? clientEntity;

  TextEditingController companyNameController = TextEditingController();
  TextEditingController primaryContactController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController taxController = TextEditingController();
  TextEditingController websiteController = TextEditingController();
  final FlutterNativeContactPicker _contactPicker =
      FlutterNativeContactPicker();
  TextEditingController emailController = TextEditingController();
  TextEditingController notesController = TextEditingController();

  List<ClientPersonModel> clientPersonList = [];
  bool isValidateForm = false;
  ClientAddAddress? billingAddress;
  ClientAddAddress? shippingAddress;
  List<CurrencyModel> currencies = [];
  List<LanguageModel> languages = [];
  List<PaymentTerms> paymentTerms = [];
  CurrencyModel? selectedCurrency;
  LanguageModel? selectedLanguage;
  PaymentTerms? selectedPaymentTerms;
  bool isRefreshPreviousScreen = false;

  @override
  void initState() {
    clientEntity = widget.clientEntity;
    populateData();
    loadInitialData();
    super.initState();
  }

  bool isEdit() {
    return widget.clientEntity != null;
  }

  void loadInitialData() {
    _loadCurrencies();
    _loadLanguages();
    _readPaymentTerms();
  }

  void populateData() {
    if (clientEntity != null) {
      debugPrint("id: ${clientEntity?.clientId}");
      debugPrint("Website: ${clientEntity?.website}");
      companyNameController.text = clientEntity?.name ?? "";
      primaryContactController.text = clientEntity?.contactName ?? "";
      phoneController.text = clientEntity?.contactPhone ?? "";
      websiteController.text = clientEntity?.website ?? "";
      emailController.text = clientEntity?.contactEmail ?? "";
      notesController.text = clientEntity?.remarks ?? "";
      taxController.text = clientEntity?.registrationNo ?? "";

      var pList = clientEntity?.persons ?? [];
      final primaryIndex = pList.indexWhere((element) {
        return (element.primary ?? false) == true;
      });
      if (primaryIndex >= 0) {
        pList.removeAt(primaryIndex);
      }
      clientPersonList = pList.map((returnedPerson) {
        return ClientPersonModel(
          email: returnedPerson.email ?? "",
          name: returnedPerson.name ?? "",
          phoneNumber: returnedPerson.phone ?? "",
        );
      }).toList();

      billingAddress = ClientAddAddress(
        city: clientEntity?.city ?? "",
        streetAddress: clientEntity?.address ?? "",
        state: clientEntity?.state ?? "",
        pincode: clientEntity?.zipcode ?? "",
        phoneNumber: clientEntity?.phone ?? "",
        country: CountryModel(
            name: clientEntity?.countryName ?? "",
            countryId: clientEntity?.countryId ?? ""),
      );

      shippingAddress = ClientAddAddress(
        city: clientEntity?.shippingCity ?? "",
        streetAddress: clientEntity?.shippingAddress ?? "",
        state: clientEntity?.shippingState ?? "",
        pincode: clientEntity?.shippingZipcode ?? "",
        phoneNumber: clientEntity?.shippingPhone ?? "",
        country: CountryModel(
            name: clientEntity?.shippingCountryName ?? "",
            countryId: clientEntity?.shippingCountryId ?? ""),
      );
    }

    _validateClientForm();
  }

  getAddClientRequest() {
    final addClientReqParams = AddClientUsecaseReqParams(
      name: companyNameController.text,
      address: billingAddress?.streetAddress ?? "",
      id: widget.clientEntity?.clientId ?? "",
      city: billingAddress?.city ?? "",
      state: billingAddress?.state ?? "",
      zipCode: billingAddress?.pincode ?? "",
      phone: billingAddress?.phoneNumber ?? "",
      countryId: billingAddress?.country?.countryId ?? "",
      registrationNo: taxController.text,
      website: websiteController.text,
      currency: selectedCurrency?.currencyId ?? "",
      paymentTerms: selectedPaymentTerms?.value ?? "",
      language: selectedLanguage?.languageId ?? "",
      shippingAddress: shippingAddress?.streetAddress ?? "",
      shippingCity: shippingAddress?.city ?? "",
      shippingCountry: shippingAddress?.country?.countryId ?? "",
      shippingPhone: shippingAddress?.phoneNumber ?? "",
      shippingState: shippingAddress?.state ?? "",
      shippingZipcode: shippingAddress?.pincode ?? "",
      remarks: notesController.text,
      contactEmail: emailController.text,
      contactPhone: phoneController.text,
      contactName: primaryContactController.text,
      clientPersons: clientPersonList,
      contactId: getClientId(),
    );
    context
        .read<ClientBloc>()
        .add(AddClientEvent(addClientUsecaseReqParams: addClientReqParams));
  }

  String getClientId() {
    final persons = clientEntity?.persons ?? [];
    final index = persons.indexWhere((element) {
      return (element.primary ?? false) == true;
    });
    if (index >= 0) {
      return persons[index].id ?? "";
    }
    return "";
  }

  String get currencyDisplayValue {
    if (selectedCurrency != null) {
      return "";
    }
    final code = selectedCurrency?.code ?? "";
    final name = selectedCurrency?.name ?? "";
    if (code.isEmpty || name.isEmpty) {
      return "";
    }
    return "$code - $name";
  }

  void setCurrency() {
    final currency = currencyDisplayValue;
  }

  _popScreen() {
    if (isRefreshPreviousScreen) {
      if (widget.refreshClient != null) {
        widget.refreshClient!();
      }
    }
    AutoRouter.of(context).maybePop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPallete.kF2F2F2,
      appBar: AppBar(
        title: Text(isEdit() ? "Edit Client" : "New Client"),
        leading: IconButton(
            onPressed: () {
              _popScreen();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: AppPallete.blueColor,
            )),
        actions: [
          TextButton(
              onPressed: isValidateForm
                  ? () {
                      getAddClientRequest();
                    }
                  : null,
              child: Text(
                "Save",
                style: AppFonts.regularStyle(
                    color: isValidateForm
                        ? AppPallete.blueColor
                        : AppPallete.blueColor.withOpacity(0.3)),
              ))
        ],
      ),
      body: BlocConsumer<ClientBloc, ClientState>(
        listener: (context, state) {
          if (state is DeleteClientErrorState) {
            showToastification(
                context, state.errorMessage, ToastificationType.error);
          }

          if (state is DeleteClientSuccessState) {
            showToastification(
                context, "Successfully deleted", ToastificationType.success);
            widget.clientRemoved();
            AutoRouter.of(context).popUntilRoot();
          }

          if (state is ClientAddErrorState) {
            showToastification(
                context, state.errorMessage, ToastificationType.error);
          }

          if (state is ClientAddSuccessState) {
            isRefreshPreviousScreen = true;
            showToastification(
                context,
                "Successfully ${isEdit() ? "updated" : "added"}",
                ToastificationType.success);
            _popScreen();
          }
        },
        builder: (context, state) {
          if (state is DeleteClientLoadingState) {
            return const LoadingPage(title: "Deleting client...");
          }

          if (state is ClientAddLoadingState) {
            return LoadingPage(
                title: isEdit() ? "Updating client..." : "Adding client...");
          }

          return SafeArea(
            child: GestureDetector(
              onTap: () {
                Utils.hideKeyboard();
              },
              child: SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (isEdit() == false) AppConstants.sizeBoxHeight10,
                    if (isEdit() == false)
                      Container(
                        color: AppPallete.white,
                        width: MediaQuery.of(context).size.width,
                        child: TextButton(
                            onPressed: () async {
                              bool permissionGranted =
                                  await FlutterContacts.requestPermission();
                              if (permissionGranted) {
                                final contact =
                                    await _contactPicker.selectContact();

                                if (contact != null) {
                                  primaryContactController.text =
                                      contact.fullName ?? "";
                                  final validPhoneNumber = contact.phoneNumbers
                                      ?.firstWhere((element) {
                                    return element.isNotEmpty;
                                  });
                                  phoneController.text = validPhoneNumber ?? "";
                                }
                                setState(() {});
                              }
                            },
                            child: Text(
                              "Import from Contacts",
                              style: AppFonts.buttonTextStyle(),
                            )),
                      ),
                    AppConstants.sizeBoxHeight10,
                    NewInputViewWidget(
                      isRequired: true,
                      title: LocaleData.companyNameTitle.getString(context),
                      controller: companyNameController,
                      hintText: "Client Or Company",
                      onChanged: (val) {
                        _validateClientForm();
                      },
                    ),
                    NewInputViewWidget(
                      title: LocaleData.primaryContactTitle.getString(context),
                      controller: primaryContactController,
                      hintText: "Contact Name",
                      onChanged: (val) {
                        _validateClientForm();
                      },
                    ),
                    NewInputViewWidget(
                      title: LocaleData.emailTitle.getString(context),
                      controller: emailController,
                      hintText: "Email",
                      inputType: TextInputType.emailAddress,
                      onChanged: (val) {
                        _validateClientForm();
                      },
                    ),
                    NewInputViewWidget(
                      isRequired: false,
                      title: LocaleData.phoneTitle.getString(context),
                      controller: phoneController,
                      hintText: "Phone",
                      showDivider: false,
                      inputType: TextInputType.phone,
                      inputAction: TextInputAction.done,
                    ),
                    const SectionTitle(title: "ADDRESS DETAILS"),
                    NewclientAddressDetailsInputview(
                      title: "Billing Address",
                      isRequired: false,
                      onPress: () {
                        AutoRouter.of(context).push(BillingAddressPageRoute(
                            billingAddress: billingAddress,
                            callBack: (addressModel) {
                              billingAddress = addressModel;
                              //setState(() {});
                            }));
                        // Navigator.of(context).push(MaterialPageRoute(
                        //     builder: (context) => BillingAddressPage()));
                      },
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: ItemSeparator(),
                    ),
                    NewclientAddressDetailsInputview(
                      title: "Shipping Address",
                      isRequired: false,
                      onPress: () {
                        AutoRouter.of(context).push(ShippingAddressPageRoute(
                            shippingAddress: shippingAddress,
                            billingAddress: billingAddress,
                            callBack: (addressModel) {
                              shippingAddress = addressModel;
                            }));
                      },
                    ),
                    const SectionTitle(title: "OTHER DETAILS"),
                    InputDropdownView(
                        title: "Currency",
                        isRequired: false,
                        defaultText: "Select Currency",
                        value: selectedCurrency == null
                            ? ""
                            : "${selectedCurrency?.code ?? ""} - ${selectedCurrency?.name ?? ""}",
                        onPress: () {
                          _showCurrencyPopup();
                        }),
                    InputDropdownView(
                        title: "Payment Terms",
                        isRequired: false,
                        defaultText: "Select Payment Terms",
                        value: selectedPaymentTerms?.label ?? "",
                        onPress: () {
                          _showRepaymentPopup();
                        }),
                    OtherDetailsInputView(
                      isRequired: false,
                      title: "Company/Tax ID",
                      controller: taxController,
                      hintText: "ABN, GSTIN etc.",
                    ),
                    OtherDetailsInputView(
                      isRequired: false,
                      title: "Website",
                      controller: websiteController,
                      hintText: "Website",
                      inputType: TextInputType.url,
                    ),
                    InputDropdownView(
                        title: "Language",
                        isRequired: false,
                        value: selectedLanguage?.name ?? "",
                        defaultText: "Select Language",
                        showDivider: false,
                        onPress: () {
                          _showLanguagePopup();
                        }),
                    const SectionTitle(title: "CONTACT PERSONS"),
                    Container(
                      color: AppPallete.white,
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: clientPersonList.length,
                          itemBuilder: (builder, index) {
                            final clientPersonModel = clientPersonList[index];
                            return GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () {
                                AutoRouter.of(context).push(AddPersonPageRoute(
                                    clientPersonModel: clientPersonModel,
                                    callback: (person) {
                                      if (person != null) {
                                        clientPersonList[index] = person;
                                        setState(() {});
                                      }
                                    }));
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 13),
                                      child: Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              clientPersonList.removeAt(index);
                                              setState(() {});
                                            },
                                            child: const Icon(
                                              Icons.remove_circle,
                                              color: AppPallete.red,
                                            ),
                                          ),
                                          AppConstants.sizeBoxWidth10,
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(clientPersonModel.name,
                                                    style: AppFonts
                                                        .regularStyle()),
                                                Text(
                                                  clientPersonModel.email,
                                                  style: AppFonts.regularStyle(
                                                      color: AppPallete.k666666,
                                                      size: 14),
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
                                    const ItemSeparator()
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                    GestureDetector(
                      onTap: () {
                        AutoRouter.of(context)
                            .push(AddPersonPageRoute(callback: (personModel) {
                          if (personModel != null) {
                            clientPersonList.add(personModel);
                            setState(() {});
                          }
                        }));
                      },
                      child: Container(
                        padding: AppConstants.horizontalVerticalPadding,
                        color: AppPallete.white,
                        child: Row(
                          children: [
                            const Icon(
                              Icons.add_circle,
                              color: AppPallete.blueColor,
                            ),
                            AppConstants.sizeBoxWidth10,
                            Text(
                              "Add new contact",
                              style: AppFonts.regularStyle(),
                            ),
                          ],
                        ),
                      ),
                    ),
                    AppConstants.sizeBoxHeight10,
                    NotesWidget(
                      controller: notesController,
                      title: "Remarks",
                      hintText: "Note for internal use",
                    ),
                    if (isEdit()) AppConstants.sizeBoxHeight10,
                    if (isEdit())
                      Container(
                        width: MediaQuery.of(context).size.width,
                        color: AppPallete.white,
                        child: Column(
                          children: [
                            TextButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AppAlertWidget(
                                          title: "Delete Client",
                                          message:
                                              "Are you sure you want to delete this client?",
                                          onTapDelete: () {
                                            debugPrint("on tap delete client");
                                            AutoRouter.of(context).maybePop();
                                            context.read<ClientBloc>().add(
                                                DeleteClientEvent(
                                                    deleteClientParams:
                                                        DeleteClientParams(
                                                            id: widget
                                                                    .clientEntity
                                                                    ?.clientId ??
                                                                "")));
                                          },
                                        );
                                      });
                                },
                                child: Text(
                                  "Delete",
                                  style: AppFonts.regularStyle(
                                      color: AppPallete.red),
                                ))
                          ],
                        ),
                      )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _validateClientForm() {
    bool isValid = false;
    final name = companyNameController.text;
    final contact = primaryContactController.text;
    final email = emailController.text;
    if (name.isNotEmpty && contact.isNotEmpty && email.isNotEmpty) {
      isValid = true;
    }
    if (isValidateForm != isValid) {
      isValidateForm = isValid;
      setState(() {});
    }
  }

  Future<void> _loadLanguages() async {
    final String response =
        await rootBundle.loadString('assets/files/languages.json');
    languages = languageMainDataModelFromJson(response).data?.language ?? [];

    if (clientEntity != null && clientEntity?.language != null) {
      final index = languages.indexWhere((returnedLang) {
        return returnedLang.languageId == clientEntity?.language;
      });
      if (index >= 0) {
        selectedLanguage = languages[index];
        setState(() {});
      }
    }
  }

  Future<void> _loadCurrencies() async {
    final String response =
        await rootBundle.loadString('assets/files/currencies.json');

    currencies = currencyMainDataModelFromJson(response).data?.currency ?? [];

    if (clientEntity != null && clientEntity?.currency != null) {
      final index = currencies.indexWhere((returnedCurrency) {
        return returnedCurrency.currencyId == clientEntity?.currency;
      });
      if (index >= 0) {
        selectedCurrency = currencies[index];
        setState(() {});
      }
    }
  }

  Future<void> _readPaymentTerms() async {
    final String response =
        await rootBundle.loadString('assets/files/payment_terms.json');
    debugPrint(response.toString());

    final res = paymentTermsResModelFromJson(response);
    paymentTerms = res.items ?? [];

    if (clientEntity != null && clientEntity?.paymentTerms != null) {
      final index = paymentTerms.indexWhere((returnedTerms) {
        debugPrint("${returnedTerms.label}");
        return returnedTerms.value == clientEntity?.paymentTerms;
      });
      if (index >= 0) {
        selectedPaymentTerms = paymentTerms[index];
        setState(() {});
      }
    }
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
                setState(() {});
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
                setState(() {});
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
                setState(() {});
              });
        });
  }
}
