import 'package:billbooks_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:billbooks_app/features/categories/presentation/bloc/category_bloc.dart';
import 'package:billbooks_app/features/clients/presentation/bloc/client_bloc.dart';
import 'package:billbooks_app/features/dashboard/presentation/bloc/accountrecivable_bloc.dart';
import 'package:billbooks_app/features/dashboard/presentation/bloc/authinfo_bloc.dart';
import 'package:billbooks_app/features/dashboard/presentation/bloc/overdueinvoice_bloc.dart';
import 'package:billbooks_app/features/dashboard/presentation/bloc/salesexpenses_bloc.dart';
import 'package:billbooks_app/features/dashboard/presentation/bloc/totalincomes_bloc.dart';
import 'package:billbooks_app/features/dashboard/presentation/bloc/totalreceivable_bloc.dart';
import 'package:billbooks_app/features/estimate/presentation/bloc/estimate_bloc.dart';
import 'package:billbooks_app/features/general/bloc/general_bloc.dart';
import 'package:billbooks_app/features/integrations/presentation/bloc/online_payments_bloc.dart';
import 'package:billbooks_app/features/more/expenses/presentation/bloc/expenses_bloc.dart';
import 'package:billbooks_app/features/more/settings/presentation/bloc/organization_bloc.dart';
import 'package:billbooks_app/features/notifications/bloc/notification_bloc.dart';
import 'package:billbooks_app/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:billbooks_app/features/project/presentation/bloc/project_bloc.dart';
import 'package:billbooks_app/features/taxes/presentation/bloc/tax_bloc.dart';
import 'package:billbooks_app/features/users/presentation/bloc/user_bloc.dart';
import 'package:billbooks_app/init_dependencies.dart';
import 'package:billbooks_app/localization/locales.dart';
import 'package:billbooks_app/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'core/theme/theme.dart';
import 'features/invoice/presentation/bloc/invoice_bloc.dart';
import 'features/item/presentation/bloc/item_bloc.dart';

typedef SalesExpensesBuilder = void Function(
    BuildContext context, void Function() updateSalesExepnses);

typedef OverdueInvoiceBuilder = void Function(
    BuildContext context, void Function() updateOverdueInvoice);
typedef TotalinvoicesBuilder = void Function(
    BuildContext context, void Function() updateTotalInvoice);
typedef TotalReceivablesBuilder = void Function(
    BuildContext context, void Function() updateTotalReceivables);
typedef AccountsReceivablesBuilder = void Function(
    BuildContext context, void Function() updateAccountReceivable);

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(MultiBlocProvider(providers: [
    BlocProvider(
      create: (context) => GeneralBloc(),
    ),
    BlocProvider(
        create: (context) => ProjectBloc(
              projectListUsecase: serviceLocator(),
              addProjectUseCase: serviceLocator(),
              deleteProjectUserCase: serviceLocator(),
              updateProjectStatusUseCase: serviceLocator(),
              projectDetailUseCase: serviceLocator(),
            )),
    BlocProvider(
      create: (context) => CategoryBloc(usecase: serviceLocator()),
    ),
    BlocProvider(
      create: (context) =>
          NotificationBloc(notificationListUsercase: serviceLocator()),
    ),
    BlocProvider(
        create: (context) => OnlinePaymentsBloc(
              serviceLocator(),
              serviceLocator(),
              serviceLocator(),
              serviceLocator(),
              serviceLocator(),
              serviceLocator(),
            )),
    BlocProvider(
        create: (context) => EstimateBloc(
              estimateListUsecase: serviceLocator(),
              estimateDetailUsecase: serviceLocator(),
            )),
    BlocProvider(
        create: (context) => ExpensesBloc(
            expensesListUsecase: serviceLocator(),
            newExpensesUsecase: serviceLocator(),
            deleteExpenseUsecase: serviceLocator())),
    BlocProvider(
        create: (context) => AuthBloc(
              userLogin: serviceLocator(),
              resetPasswordRequestUseCase: serviceLocator(),
              resetPasswordUseCase: serviceLocator(),
              registerUserUseCase: serviceLocator(),
            )),
    BlocProvider(
        create: (context) => UserBloc(
              userListUsecase: serviceLocator(),
            )),
    BlocProvider(
      create: (context) => TaxBloc(
          taxListUsecase: serviceLocator(),
          addTaxUseCase: serviceLocator(),
          deleteTaxUseCase: serviceLocator()),
    ),
    BlocProvider(
        create: (context) =>
            TotalreceivableBloc(totalReceivablesUsecase: serviceLocator())),
    BlocProvider(
        create: (context) => OverdueinvoiceBloc(
              // accountReceivablesUsecase: serviceLocator(),
              // overdueInvoiceUsecase: serviceLocator(),
              // salesExpensesUsecase: serviceLocator(),
              overdueInvoiceUsecase: serviceLocator(),
              // totalReceivablesUsecase: serviceLocator()
            )),
    BlocProvider(
        create: (context) => TotalincomesBloc(
              // accountReceivablesUsecase: serviceLocator(),
              // overdueInvoiceUsecase: serviceLocator(),
              // salesExpensesUsecase: serviceLocator(),
              totalIncomesUsecase: serviceLocator(),
              // totalReceivablesUsecase: serviceLocator()
            )),
    BlocProvider(
        create: (context) => SalesexpensesBloc(
              salesExpensesUsecase: serviceLocator(),

              // totalReceivablesUsecase: serviceLocator()
            )),
    BlocProvider(
        create: (context) => AccountrecivableBloc(
              accountReceivablesUsecase: serviceLocator(),

              // totalReceivablesUsecase: serviceLocator()
            )),
    BlocProvider(
        create: (context) => ProfileBloc(
              selectOrganizationUseCase: serviceLocator(),

              // totalReceivablesUsecase: serviceLocator()
            )),
    BlocProvider(
        create: (context) => AuthinfoBloc(
              authInfoUsecase: serviceLocator(),

              // totalReceivablesUsecase: serviceLocator()
            )),
    BlocProvider(
      create: (context) => ItemBloc(
        itemUsecase: serviceLocator(),
        addItemUseCase: serviceLocator(),
        deleteItemUseCase: serviceLocator(),
        itemMarkActiveUseCase: serviceLocator(),
        itemMarkInActiveUseCase: serviceLocator(),
      ),
    ),
    BlocProvider(
        create: (context) => OrganizationBloc(
              organizationListUsecase: serviceLocator(),
              updateOrganizationUsecase: serviceLocator(),
              preferenceUpdateUsecase: serviceLocator(),
              preferenceDetailsUsecase: serviceLocator(),
              updatePreferenceColumnUsecase: serviceLocator(),
              updatePreferenceEstimateUsecase: serviceLocator(),
              updatePrefGeneralUsecase: serviceLocator(),
              updatePrefInvoiceUsecase: serviceLocator(),
            )),
    BlocProvider(
      create: (context) => InvoiceBloc(
        invoiceDetailUsecase: serviceLocator(),
        invoiceListUsecase: serviceLocator(),
        paymentListUsecase: serviceLocator(),
        paymentDetailsUsecase: serviceLocator(),
        invoiceVoidUsecase: serviceLocator(),
        invoiceUnvoidUsecase: serviceLocator(),
        invoiceMarkassendUsecase: serviceLocator(),
        invoiceDeleteUsecase: serviceLocator(),
        addInvoiceUsecase: serviceLocator(),
        clientStaffUsecase: serviceLocator(),
        getDocumentUsecase: serviceLocator(),
        deletePaymentUsecase: serviceLocator(),
        addPaymentUsecase: serviceLocator(),
        sendDocumentUsecase: serviceLocator(),
      ),
    ),
    BlocProvider(
        create: (context) => ClientBloc(
              clientListUseCase: serviceLocator(),
              deleteClientUseCase: serviceLocator(),
              updateClientStatusUseCase: serviceLocator(),
              clientDetailsUseCase: serviceLocator(),
              addClientUsecase: serviceLocator(),
            )),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FlutterLocalization localization = FlutterLocalization.instance;

  final _appRouter = AppRouter();

  @override
  void initState() {
    configureLocalization();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // var now = DateTime.now();
    // final currentMonth = now.month;
    // final currentYear = now.year;
    // var date = DateTime(currentYear, currentMonth - 1, 0);
    // var lastDay = date.day;
    // debugPrint("Last day: $lastDay");

    final mediaQueryData = MediaQuery.of(context);
    final scale = mediaQueryData.textScaler.clamp(
      minScaleFactor: 1.0, // Minimum scale factor allowed.
      maxScaleFactor: 1.0, // Maximum scale factor allowed.
    );

    return MediaQuery(
        data: mediaQueryData.copyWith(textScaler: scale),
        child: MaterialApp.router(
          title: 'BillBooks',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.themeData,
          supportedLocales: localization.supportedLocales,
          localizationsDelegates: localization.localizationsDelegates,
          routerConfig: _appRouter.config(),
          key: navigatorKey,
          //home: const ProjectListPage(),
        ));
  }

  void configureLocalization() {
    localization.init(mapLocales: LOCALES, initLanguageCode: "en");
    localization.onTranslatedLanguage = onTranslatedLanguage;
  }

  void onTranslatedLanguage(Locale? locale) {
    setState(() {});
  }
}
