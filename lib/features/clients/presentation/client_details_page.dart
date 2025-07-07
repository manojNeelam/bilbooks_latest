import 'dart:async';

import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';
import 'package:auto_route/auto_route.dart';
import 'package:billbooks_app/core/app_constants.dart';
import 'package:billbooks_app/core/theme/app_fonts.dart';
import 'package:billbooks_app/core/theme/app_pallete.dart';
import 'package:billbooks_app/core/utils/currency_helper.dart';
import 'package:billbooks_app/core/utils/show_toast.dart';
import 'package:billbooks_app/core/widgets/cap_status_widget.dart';
import 'package:billbooks_app/core/widgets/item_separator.dart';
import 'package:billbooks_app/core/widgets/loading_page.dart';
import 'package:billbooks_app/features/clients/domain/entities/client_list_entity.dart';
import 'package:billbooks_app/features/clients/domain/usecase/client_usecase.dart';
import 'package:billbooks_app/features/clients/presentation/Models/url_scheme.dart';
import 'package:billbooks_app/features/clients/presentation/bloc/client_bloc.dart';
import 'package:billbooks_app/features/clients/presentation/widgets/client_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'package:toastification/toastification.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/constants/assets.dart';
import '../../../core/models/language_model.dart';
import '../../../core/widgets/app_alert_widget.dart';
import '../../../core/widgets/section_header_widget.dart';
import '../../../router/app_router.dart';
import '../domain/entities/client_details_entity.dart';
import 'Models/client_currencies.dart';

@RoutePage()
class ClientDetailPage extends StatefulWidget {
  final Function()? refreshList;
  final ClientEntity clientEntity;
  const ClientDetailPage(
      {super.key, required this.clientEntity, this.refreshList});

  @override
  State<ClientDetailPage> createState() => _ClientDetailPageState();
}

class _ClientDetailPageState extends State<ClientDetailPage> {
  late ClientEntity clientEntity;
  BuildContext? mainContext;
  bool isRefreshPreviousScreen = false;
  bool removeObservingBloc = false;
  List<LanguageModel> languages = [];
  List<CurrencyModel> currencies = [];
  String langName = "";
  String currencyName = "";
  ClientDetailsDataEntity? clientDetailsDataEntity;
  var clientCurrencySymbol = "";

  void dismissPopup(context) {
    AutoRouter.of(context).maybePop();
  }

  bool isActive() {
    String? status = clientEntity.status;
    if (status != null && status == "1") {
      return true;
    }
    return false;
  }

  void showActiveInactiveAlert() {
    Timer(const Duration(milliseconds: 500), () {
      removeObservingBloc = false;
      _showActiveInactiveDialog();
    });
  }

  void _showActiveInactiveDialog() {
    showDialog(
        context: mainContext!,
        builder: (BuildContext context) {
          return AppAlertWidget(
            title: "Mark as ${isActive() ? "Inactive" : "Active"}",
            message:
                "Are you sure you want to ${isActive() ? "inactive" : "active"} this client?",
            onTapDelete: () {
              dismissPopup(context);
              context.read<ClientBloc>().add(UpdateClientStatusEvent(
                      params: UpdateClientStatusParams(
                    id: clientEntity.clientId ?? "",
                    isActive: isActive(),
                  )));
            },
            alertType: EnumAppAlertType.ok,
          );
        });
  }

  void showDeleteAlert() {
    Timer(const Duration(milliseconds: 500), () {
      _showAlert();
    });
  }

  void _showAlert() {
    showDialog(
        context: mainContext!,
        builder: (BuildContext context) {
          return AppAlertWidget(
            title: "Delete Client",
            message: "Are you sure you want to delete this client?",
            onTapDelete: () {
              dismissPopup(context);
              context.read<ClientBloc>().add(DeleteClientEvent(
                  deleteClientParams:
                      DeleteClientParams(id: clientEntity.clientId ?? "")));
            },
            alertType: EnumAppAlertType.delete,
          );
        });
  }

  @override
  void initState() {
    mainContext = context;
    clientEntity = widget.clientEntity;
    _loadLanguages();
    _loadCurrencies();

    getClientDetails();
    super.initState();
  }

  String _getCurrencyName() {
    String currencySymbol = "-";
    if (clientEntity.currency != null) {
      final index = currencies.indexWhere((returnedCurrency) {
        return returnedCurrency.currencyId == clientEntity.currency;
      });
      if (index >= 0) {
        currencySymbol = currencies[index].code ?? "-";
        debugPrint(currencySymbol);
      }
    }
    return currencySymbol;
  }

  String _getLanguageName() {
    if (clientEntity.language != null) {
      final index = languages.indexWhere((returnedLang) {
        return returnedLang.languageId == clientEntity.language;
      });
      if (index >= 0) {
        String name = languages[index].code ?? "-";
        debugPrint(name);
        return name;
      }
    }
    return "-";
  }

  Future<void> _loadLanguages() async {
    final String response =
        await rootBundle.loadString('assets/files/languages.json');
    languages = languageMainDataModelFromJson(response).data?.language ?? [];
    langName = _getLanguageName();
    setState(() {});
  }

  Future<void> _loadCurrencies() async {
    final String response =
        await rootBundle.loadString('assets/files/currencies.json');
    currencies = currencyMainDataModelFromJson(response).data?.currency ?? [];
    currencyName = _getCurrencyName();
    setState(() {});
  }

  void getClientDetails() {
    context.read<ClientBloc>().add(GetClientDetailsEvent(
        clientDetailsReqParams:
            ClientDetailsReqParams(id: clientEntity.clientId ?? "")));
  }

  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  void _popScreen() {
    if (isRefreshPreviousScreen) {
      if (widget.refreshList != null) {
        widget.refreshList!();
      }
    }
    AutoRouter.of(context).maybePop();
  }

//mailto:smith@example.org?subject=News&body=New%20plugin

  Future<void> launchMail(String email) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
      query: encodeQueryParameters(<String, String>{
        'subject': '',
      }),
    );

    // final Uri emailLaunchUri = Uri.parse(
    //     "${EnumUrlScheme.mail.path}$email?subject=subject comes here&body=body comes here");
    debugPrint("Email: $emailLaunchUri");
    if (await canLaunchUrl(emailLaunchUri)) {
      launchUrl(emailLaunchUri);
    } else {
      debugPrint("Unable to launch email");
    }
  }

  Future<void> launchCall(String phone) async {
    final Uri emailLaunchUri = Uri.parse("${EnumUrlScheme.call.path}$phone");
    debugPrint("Call: $emailLaunchUri");
    if (await canLaunchUrl(emailLaunchUri)) {
      launchUrl(emailLaunchUri);
    } else {
      debugPrint("Unable to launch call");
    }
  }

  Future<void> launchSMS(String phone) async {
    final Uri callLaunchUri = Uri.parse("${EnumUrlScheme.sms.path}$phone");
    debugPrint("SMS: $callLaunchUri");
    if (await canLaunchUrl(callLaunchUri)) {
      launchUrl(callLaunchUri);
    } else {
      debugPrint("Unable to launch sms");
    }
  }

  String get currencySymbol {
    if (clientDetailsDataEntity?.client?.currencyCode != null) {
      final symbol = CurrencyHelper()
          .getSymbolById(clientDetailsDataEntity?.client?.currencyCode ?? "");
      return symbol ?? "";
    }
    return "";
  }

  String get getTotalSales {
    if (clientDetailsDataEntity?.totals != null) {
      return "${clientDetailsDataEntity?.totals?.sales ?? "0"}";
    }
    return "0";
  }

  String get getTotalReceipts {
    if (clientDetailsDataEntity?.totals != null) {
      return "${clientDetailsDataEntity?.totals?.receipts ?? "0"}";
    }
    return "0";
  }

  String get getTotalBalanceDue {
    return "0";
  }

  String get getInvoiceTotalCount {
    if (clientDetailsDataEntity?.invoices != null) {
      return "${clientDetailsDataEntity?.invoices?.length ?? "0"}";
    }
    return "0";
  }

  String get getEstimateTotalCount {
    if (clientDetailsDataEntity?.estimates != null) {
      return "${clientDetailsDataEntity?.estimates?.length ?? "0"}";
    }
    return "0";
  }

  String get getProjectTotalCount {
    if (clientDetailsDataEntity?.projects != null) {
      return "${clientDetailsDataEntity?.projects?.length ?? "0"}";
    }
    return "0";
  }

  String get getExpensesTotalCount {
    if (clientDetailsDataEntity?.expenses != null) {
      return "${clientDetailsDataEntity?.expenses?.length ?? "0"}";
    }
    return "0";
  }

  String getClientAddress() {
    final address = clientEntity.address ?? "";
    if (address.isNotEmpty) {
      return address;
    }
    var fullAddress = "";
    final city = clientEntity.city ?? "";
    final state = clientEntity.state ?? "";
    final zipCode = clientEntity.zipcode ?? "";
    if (city.isNotEmpty) {
      fullAddress = city;
    }
    if (state.isNotEmpty) {
      if (fullAddress.isNotEmpty) {
        fullAddress = "$fullAddress, $state";
      } else {
        fullAddress = state;
      }
    }

    if (zipCode.isNotEmpty) {
      if (fullAddress.isNotEmpty) {
        fullAddress = "$fullAddress, $zipCode";
      } else {
        fullAddress = zipCode;
      }
    }
    return fullAddress;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppPallete.lightBlueColor,
        title: const Text("Client"),
        actions: [
          TextButton(
              onPressed: () {
                removeObservingBloc = true;
                AutoRouter.of(context).push(NewClientPageRoute(
                    clientEntity: clientEntity,
                    refreshClient: () {
                      removeObservingBloc = false;
                      isRefreshPreviousScreen = true;
                      getClientDetails();
                    },
                    onPopBack: () {
                      removeObservingBloc = false;
                    },
                    clientRemoved: () {
                      debugPrint("clientRemoved");
                      removeObservingBloc = false;
                      isRefreshPreviousScreen = true;
                      _popScreen();
                    }));
              },
              child: Text(
                "Edit",
                style: AppFonts.regularStyle(color: AppPallete.blueColor),
              ))
        ],
        leading: IconButton(
            onPressed: () {
              _popScreen();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: AppPallete.blueColor,
            )),
      ),
      body: SafeArea(
        child: BlocConsumer<ClientBloc, ClientState>(
          listener: (context, state) {
            if (removeObservingBloc) {
              return;
            }
            if (state is UpdateClientErrorState) {
              showToastification(
                  context, state.errorMessage, ToastificationType.error);
            }
            if (state is UpdateClientSuccessState) {
              isRefreshPreviousScreen = true;
              showToastification(
                  context,
                  "Successfully marked client as ${isActive() ? "inactive" : "active"}.",
                  ToastificationType.success);
              //_popScreen();
              getClientDetails();
            }
            if (state is ClientDetailsSuccessState) {
              clientDetailsDataEntity = state.clientDetailsMainResEntity.data;
              final clientObj = state.clientDetailsMainResEntity.data?.client;

              clientCurrencySymbol = currencySymbol;
              debugPrint("Name: (${clientObj?.name ?? ""}");
              if (clientObj != null) {
                clientEntity = clientObj;
                currencyName = _getCurrencyName();
                langName = _getLanguageName();
              }
            }
            if (state is DeleteClientErrorState) {
              showToastification(
                  context, state.errorMessage, ToastificationType.error);
            }
            if (state is DeleteClientSuccessState) {
              isRefreshPreviousScreen = true;
              showToastification(
                  context, "Successfully deleted", ToastificationType.success);
              _popScreen();
            }
          },
          builder: (context, state) {
            if (removeObservingBloc == false) {
              if (state is DeleteClientLoadingState) {
                return const LoadingPage(title: "Deleting client...");
              }
              if (state is UpdateClientLoadingState) {
                return LoadingPage(
                    title: isActive()
                        ? "Mark as inactive..."
                        : "Mark as active...");
              }
              if (state is ClientDetailsLoadingState) {
                return const LoadingPage(title: "Fetching details...");
              }
            }

            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(bottom: 16),
                    decoration:
                        const BoxDecoration(color: AppPallete.lightBlueColor),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if ((clientEntity.name ?? "").isNotEmpty)
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(
                              ((clientEntity.name ?? "").capitalize()),
                              style: AppFonts.mediumStyle(
                                  color: AppPallete.blueColor, size: 22),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        AppConstants.sizeBoxHeight10,
                        if ((clientEntity.contactName ?? "").isNotEmpty)
                          Wrap(
                            children: [
                              const SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Text(
                                  (clientEntity.contactName ?? ""),
                                  style: AppFonts.regularStyle(
                                      color: AppPallete.black, size: 16),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        AppConstants.sizeBoxHeight10,
                        if ((clientEntity.contactEmail ?? "").isNotEmpty)
                          Wrap(
                            children: [
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                clientEntity.contactEmail ?? "",
                                style: AppFonts.regularStyle(
                                    color: AppPallete.k666666, size: 14),
                              ),
                            ],
                          ),
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  if (clientEntity.contactPhone != null) {
                                    String phone =
                                        clientEntity.contactPhone ?? "";
                                    await launchSMS(phone);
                                  }
                                },
                                child: headerActionCell(context,
                                    actionButtonType:
                                        ClientActionButtonType.message),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  if (clientEntity.contactEmail != null) {
                                    String phone =
                                        clientEntity.contactPhone ?? "";
                                    await launchCall(phone);
                                  }
                                },
                                child: headerActionCell(context,
                                    actionButtonType:
                                        ClientActionButtonType.call),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  if (clientEntity.contactEmail != null) {
                                    String email =
                                        clientEntity.contactEmail ?? "";
                                    await launchMail(email);
                                  }
                                },
                                child: headerActionCell(context,
                                    actionButtonType:
                                        ClientActionButtonType.mail),
                              ),
                              GestureDetector(
                                onTap: () {
                                  showAdaptiveActionSheet(
                                    context: context,
                                    useRootNavigator: true,
                                    androidBorderRadius: 30,
                                    isDismissible: true,
                                    actions: <BottomSheetAction>[
                                      BottomSheetAction(
                                          title: Text(
                                            isActive()
                                                ? "Mark as Inactive"
                                                : "Mark as Active",
                                            style: AppFonts.regularStyle(
                                                color: AppPallete.blueColor,
                                                size: 16),
                                          ),
                                          onPressed: (context) {
                                            dismissPopup(context);
                                            showActiveInactiveAlert();
                                          }),
                                      BottomSheetAction(
                                          title: Text(
                                            "Delete",
                                            style: AppFonts.regularStyle(
                                                color: AppPallete.red,
                                                size: 16),
                                          ),
                                          onPressed: (context) {
                                            dismissPopup(context);
                                            showDeleteAlert();
                                          }),
                                    ],
                                    cancelAction: CancelAction(
                                        title: Text(
                                      'Cancel',
                                      style: AppFonts.mediumStyle(
                                          color: AppPallete.blueColor,
                                          size: 16),
                                    )), // onPressed parameter is optional by default will dismiss the ActionSheet
                                  );
                                },
                                child: headerActionCell(context,
                                    actionButtonType:
                                        ClientActionButtonType.more),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 13),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                getClientAddress(),
                                style: AppFonts.regularStyle(
                                    size: 16, color: AppPallete.textColor),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Remarks/Notes:",
                                style: AppFonts.regularStyle(
                                    color: AppPallete.k666666),
                              ),
                              Text(
                                clientEntity.remarks ?? "",
                                style: AppFonts.regularStyle(),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              currencyLanguageWidget(context,
                                  title: "Currency: ", value: currencyName),
                              const SizedBox(
                                height: 5,
                              ),
                              currencyLanguageWidget(context,
                                  title: "Language: ", value: langName),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SectionHeaderWidget(
                    title: "SUMMARY",
                  ),
                  Container(
                      decoration: const BoxDecoration(color: AppPallete.white),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 13),
                      child: Column(
                        children: [
                          summaryItem(context,
                              title: 'Total Sales',
                              value: "$clientCurrencySymbol $getTotalSales",
                              textColor: AppPallete.blueColor),
                          AppConstants.sepSizeBox5,
                          summaryItem(context,
                              title: 'Total Receipts',
                              value: "$clientCurrencySymbol $getTotalReceipts",
                              textColor: AppPallete.greenColor),
                          AppConstants.sepSizeBox5,
                          summaryItem(context,
                              title: "Balance Due",
                              value:
                                  "$clientCurrencySymbol $getTotalBalanceDue",
                              textColor: AppPallete.red),
                        ],
                      )),
                  const SectionHeaderWidget(title: "Activity"),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        activities(context,
                            title: "Invoices", value: getInvoiceTotalCount),
                        activities(context,
                            title: "Estimates", value: getEstimateTotalCount),
                        activities(context,
                            title: "Expenses", value: getExpensesTotalCount),
                        activities(context,
                            title: "Projects",
                            value: getProjectTotalCount,
                            showSeparator: false),
                      ],
                    ),
                  ),
                  const SectionHeaderWidget(title: "Contact Persons"),
                  for (final person in clientEntity.persons ?? [])
                    primaryPerson(context, person),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget headerActionCell(BuildContext context,
      {required ClientActionButtonType actionButtonType}) {
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
            style: AppFonts.regularStyle(size: 12, color: AppPallete.blueColor),
          ),
        ],
      ),
    );
  }

  Widget currencyLanguageWidget(BuildContext context,
      {required String title, required String value}) {
    return RichText(
        text: TextSpan(
            style: AppFonts.regularStyle(color: AppPallete.k666666),
            text: title,
            children: [
          TextSpan(
              text: value,
              style:
                  AppFonts.regularStyle(color: AppPallete.textColor, size: 16))
        ]));
  }

  Widget summaryItem(BuildContext context,
      {required String title,
      required String value,
      required Color textColor}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: AppFonts.regularStyle(),
          ),
          Text(
            value,
            style: AppFonts.regularStyle(color: textColor),
          ),
        ],
      ),
    );
  }

  Widget primaryPerson(BuildContext context, PersonEntity personEntity) {
    return SwipeActionCell(
      trailingActions: [
        SwipeAction(
            style: AppFonts.regularStyle(color: AppPallete.white),
            icon: const Icon(
              Icons.call,
              color: AppPallete.white,
            ),
            widthSpace: 50,
            onTap: (CompletionHandler handler) async {
              await handler(false);
              if (personEntity.phone != null &&
                  personEntity.phone!.isNotEmpty) {
                await launchCall(personEntity.phone ?? "");
              }
            },
            color: AppPallete.greenColor),
        SwipeAction(
            style: AppFonts.regularStyle(color: AppPallete.white),
            icon: const Icon(
              Icons.share,
              color: AppPallete.white,
            ),
            widthSpace: 50,
            onTap: (CompletionHandler handler) async {
              await handler(false);
              if (personEntity.email != null &&
                  personEntity.email!.isNotEmpty) {
                await launchMail(personEntity.email ?? "");
              }
            },
            color: AppPallete.blueColor),
        SwipeAction(
            style: AppFonts.regularStyle(color: AppPallete.white),
            icon: const Icon(
              Icons.messenger_rounded,
              color: AppPallete.white,
            ),
            widthSpace: 50,
            onTap: (CompletionHandler handler) async {
              await handler(false);
              if (personEntity.phone != null &&
                  personEntity.phone!.isNotEmpty) {
                await launchSMS(personEntity.phone ?? "");
              }
            },
            color: AppPallete.borderColor),
      ],
      key: ObjectKey(personEntity),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 13),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          personEntity.name ?? "",
                          style: AppFonts.regularStyle(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          personEntity.email ?? "",
                          style: AppFonts.regularStyle(
                              color: AppPallete.k666666, size: 14),
                        ),
                      ],
                    ),
                  ),
                  if ((personEntity.primary ?? false) == true)
                    const CapsuleStatusWidget(
                        title: "Primary",
                        hasborder: true,
                        backgroundColor: AppPallete.white,
                        textColor: AppPallete.greenColor)
                ],
              ),
            ),
            const ItemSeparator(),
          ],
        ),
      ),
    );
  }

  Widget activities(BuildContext context,
      {bool showSeparator = true,
      required String title,
      required String value}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 13),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: AppFonts.regularStyle(
                    color: AppPallete.textColor, size: 16),
              ),
              Row(
                children: [
                  Text(
                    value,
                    style: AppFonts.regularStyle(
                        color: AppPallete.textColor, size: 16),
                  ),
                  const Icon(
                    Icons.chevron_right,
                    color: AppPallete.borderColor,
                  )
                ],
              )
            ],
          ),
        ),
        if (showSeparator) const ItemSeparator(),
      ],
    );
  }
}

enum ClientActionButtonType { message, call, mail, more }

extension ActionButtonTypeExtension on ClientActionButtonType {
  String get name {
    switch (this) {
      case ClientActionButtonType.message:
        return "Message";
      case ClientActionButtonType.call:
        return "Call";
      case ClientActionButtonType.mail:
        return "Mail";
      case ClientActionButtonType.more:
        return "More";
    }
  }

  String get imageName {
    switch (this) {
      case ClientActionButtonType.message:
        return Assets.assetsImagesIcMessage;
      case ClientActionButtonType.call:
        return Assets.assetsImagesIcCall;
      case ClientActionButtonType.mail:
        return Assets.assetsImagesIcSend;
      case ClientActionButtonType.more:
        return Assets.assetsImagesIcMore;
    }
  }
}
