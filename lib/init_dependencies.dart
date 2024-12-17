import 'package:billbooks_app/core/api/api_client.dart';
import 'package:billbooks_app/features/auth/data/datasources/remote/auth_remote_data_source.dart';
import 'package:billbooks_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:billbooks_app/features/auth/domain/repository/auth_repository.dart';
import 'package:billbooks_app/features/auth/domain/usecases/user_signup.dart';
import 'package:billbooks_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:billbooks_app/features/categories/data/datasource/remote/category_remote_datasource.dart';
import 'package:billbooks_app/features/categories/domain/usecase/category_list_usecase.dart';
import 'package:billbooks_app/features/categories/presentation/bloc/category_bloc.dart';
import 'package:billbooks_app/features/clients/data/datasource/remote/client_remote_datasource.dart';
import 'package:billbooks_app/features/clients/data/repository/client_repository_impl.dart';
import 'package:billbooks_app/features/clients/domain/repository/client_repository.dart';
import 'package:billbooks_app/features/clients/domain/usecase/add_client_usecase.dart';
import 'package:billbooks_app/features/clients/domain/usecase/client_usecase.dart';
import 'package:billbooks_app/features/clients/presentation/bloc/client_bloc.dart';
import 'package:billbooks_app/features/dashboard/data/remote/datasource/dashboard_remote_datasource.dart';
import 'package:billbooks_app/features/dashboard/data/repository_impl/dashboard_repository_impl.dart';
import 'package:billbooks_app/features/dashboard/domain/repository/dashboard_repository.dart';
import 'package:billbooks_app/features/dashboard/domain/usecase/account_receivables_usecase.dart';
import 'package:billbooks_app/features/dashboard/domain/usecase/auth_info_usecase.dart';
import 'package:billbooks_app/features/dashboard/domain/usecase/overdue_invoice_usecase.dart';
import 'package:billbooks_app/features/dashboard/domain/usecase/sales_expenses_usecase.dart';
import 'package:billbooks_app/features/dashboard/domain/usecase/total_incomes_usecase.dart';
import 'package:billbooks_app/features/dashboard/domain/usecase/total_receivables_usecase.dart';
import 'package:billbooks_app/features/dashboard/presentation/bloc/accountrecivable_bloc.dart';
import 'package:billbooks_app/features/dashboard/presentation/bloc/authinfo_bloc.dart';
import 'package:billbooks_app/features/dashboard/presentation/bloc/overdueinvoice_bloc.dart';
import 'package:billbooks_app/features/dashboard/presentation/bloc/salesexpenses_bloc.dart';
import 'package:billbooks_app/features/dashboard/presentation/bloc/totalincomes_bloc.dart';
import 'package:billbooks_app/features/dashboard/presentation/bloc/totalreceivable_bloc.dart';
import 'package:billbooks_app/features/email%20templates/data/datasource/remote/email_template_remotedatasource.dart';
import 'package:billbooks_app/features/email%20templates/data/repository_impl/email_template_repository_impl.dart';
import 'package:billbooks_app/features/email%20templates/domain/repository/email_template_repository.dart';
import 'package:billbooks_app/features/email%20templates/domain/usecase/email_template_usecase.dart';
import 'package:billbooks_app/features/email%20templates/presentation/bloc/email_templates_bloc.dart';
import 'package:billbooks_app/features/estimate/data/datasource/estimate_data_source.dart';
import 'package:billbooks_app/features/estimate/data/repository_impl/estimate_repository_impl.dart';
import 'package:billbooks_app/features/estimate/domain/repository/estimate_repository.dart';
import 'package:billbooks_app/features/estimate/domain/usecase/estimate_detail_usecase.dart';
import 'package:billbooks_app/features/estimate/domain/usecase/estimate_list_usecase.dart';
import 'package:billbooks_app/features/estimate/presentation/bloc/estimate_bloc.dart';
import 'package:billbooks_app/features/general/bloc/general_bloc.dart';
import 'package:billbooks_app/features/integrations/data/datasource/integration_remote_datasource.dart';
import 'package:billbooks_app/features/integrations/domain/repository/online_payment_repository.dart';
import 'package:billbooks_app/features/integrations/domain/usecase/online_payment_details_usecase.dart';
import 'package:billbooks_app/features/integrations/presentation/bloc/online_payments_bloc.dart';
import 'package:billbooks_app/features/invoice/data/datasource/remote/invoice_remote_datasource.dart';
import 'package:billbooks_app/features/invoice/data/repository/invoice_repository_impl.dart';
import 'package:billbooks_app/features/invoice/domain/repository/invoice_repository.dart';
import 'package:billbooks_app/features/invoice/domain/usecase/add_invoice_usecase.dart';
import 'package:billbooks_app/features/invoice/domain/usecase/client_staff_usecase.dart';
import 'package:billbooks_app/features/invoice/domain/usecase/delete_payment_usecase.dart';
import 'package:billbooks_app/features/invoice/domain/usecase/get_document_usecase.dart';
import 'package:billbooks_app/features/invoice/domain/usecase/invoice_delete_usecase.dart';
import 'package:billbooks_app/features/invoice/domain/usecase/invoice_list_usecase.dart';
import 'package:billbooks_app/features/invoice/domain/usecase/invoice_markassend_usecase.dart';
import 'package:billbooks_app/features/invoice/domain/usecase/invoice_unvoid_usecase.dart';
import 'package:billbooks_app/features/invoice/domain/usecase/invoice_usecase.dart';
import 'package:billbooks_app/features/invoice/domain/usecase/invoice_void_usecase.dart';
import 'package:billbooks_app/features/invoice/domain/usecase/payment_details_usecase.dart';
import 'package:billbooks_app/features/invoice/domain/usecase/payment_list_usecase.dart';
import 'package:billbooks_app/features/invoice/domain/usecase/send_document_usecase.dart';
import 'package:billbooks_app/features/invoice/presentation/bloc/invoice_bloc.dart';
import 'package:billbooks_app/features/item/data/datasource/remote/item_remote_datasource.dart';
import 'package:billbooks_app/features/item/domain/repository/item_repository.dart';
import 'package:billbooks_app/features/item/domain/usecase/item_usecase.dart';
import 'package:billbooks_app/features/item/presentation/bloc/item_bloc.dart';
import 'package:billbooks_app/features/more/expenses/data/datasource/remote/expenses_remote_datasource.dart';
import 'package:billbooks_app/features/more/expenses/data/repository/expenses_repository_impl.dart';
import 'package:billbooks_app/features/more/expenses/domain/repository/expenses_repository.dart';
import 'package:billbooks_app/features/more/expenses/domain/usecase/delete_expense_usecase.dart';
import 'package:billbooks_app/features/more/expenses/domain/usecase/expenses_list_usecase.dart';
import 'package:billbooks_app/features/more/expenses/domain/usecase/new_expenses_usecase.dart';
import 'package:billbooks_app/features/more/expenses/presentation/bloc/expenses_bloc.dart';
import 'package:billbooks_app/features/more/settings/data/remote/organization_remote_datasource.dart';
import 'package:billbooks_app/features/more/settings/domain/repository/organization_repository.dart';
import 'package:billbooks_app/features/more/settings/domain/usecase/organization_list_usecase.dart';
import 'package:billbooks_app/features/more/settings/domain/usecase/preference_details_usecase.dart';
import 'package:billbooks_app/features/more/settings/domain/usecase/preference_update_usecase.dart';
import 'package:billbooks_app/features/more/settings/domain/usecase/update_organization_usecase.dart';
import 'package:billbooks_app/features/more/settings/domain/usecase/update_pref_general_usecase.dart';
import 'package:billbooks_app/features/more/settings/domain/usecase/update_pref_invoice_usecase.dart';
import 'package:billbooks_app/features/more/settings/domain/usecase/update_preference_column_usecase.dart';
import 'package:billbooks_app/features/more/settings/presentation/bloc/organization_bloc.dart';
import 'package:billbooks_app/features/notifications/bloc/notification_bloc.dart';
import 'package:billbooks_app/features/notifications/data/datasource/remote/notification_datasource.dart';
import 'package:billbooks_app/features/notifications/data/repository/notification_repository_impl.dart';
import 'package:billbooks_app/features/notifications/domain/repository/notification_repository.dart';
import 'package:billbooks_app/features/notifications/domain/usecase/notification_list_usercase.dart';
import 'package:billbooks_app/features/profile/data/remote/profile_datasource.dart';
import 'package:billbooks_app/features/profile/data/repository/repository_impl.dart';
import 'package:billbooks_app/features/profile/domain/repository/repository.dart';
import 'package:billbooks_app/features/profile/domain/usecase/profile_usecase.dart';
import 'package:billbooks_app/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:billbooks_app/features/project/data/datasource/project_datasource.dart';
import 'package:billbooks_app/features/project/data/repository/project_repository_impl.dart';
import 'package:billbooks_app/features/project/domain/repository/project_repository.dart';
import 'package:billbooks_app/features/project/domain/usecase/project_usecase.dart';
import 'package:billbooks_app/features/project/presentation/bloc/project_bloc.dart';
import 'package:billbooks_app/features/taxes/data/datasource/remote/tax_remote_datasource.dart';
import 'package:billbooks_app/features/taxes/data/repository/tax_repository_impl.dart';
import 'package:billbooks_app/features/taxes/domain/repository/tax_repository.dart';
import 'package:billbooks_app/features/taxes/domain/usecase/tax_list_usecase.dart';
import 'package:billbooks_app/features/taxes/presentation/bloc/tax_bloc.dart';
import 'package:billbooks_app/features/users/data/datasource/remote/user_remote_datasource.dart';
import 'package:billbooks_app/features/users/data/repository/user_repository_imp.dart';
import 'package:billbooks_app/features/users/domain/repository/user_repository.dart';
import 'package:billbooks_app/features/users/domain/usecases/user_list_usecase.dart';
import 'package:billbooks_app/features/users/presentation/bloc/user_bloc.dart';
import 'package:get_it/get_it.dart';

import 'features/categories/data/repository/category_repository_impl.dart';
import 'features/categories/domain/repository/category_repository.dart';
import 'features/integrations/data/repositories/online_payment_repository_impl.dart';
import 'features/invoice/domain/usecase/add_payment_usecase.dart';
import 'features/item/data/repository/item_repository_impl.dart';
import 'features/more/settings/data/repository/organization_repositoryimpl.dart';
import 'features/more/settings/domain/usecase/update_preference_estimate_usecase.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  final apiClient = APIClient();
  serviceLocator.registerFactory(() => apiClient);
  _initAuth();
  _notification();
  _initClient();
  _initInvoice();
  _initItem();
  _initTax();
  _initProject();
  _initUsers();
  _initExpenses();
  _initCategories();
  _initOrganization();
  _initOnlinePayments();
  _initEstimates();
  _initDashboard();
  _initProfile();
  _emailTemplate();
}

void _initCategories() {
  serviceLocator.registerFactory<CategoryRemoteDatasource>(() =>
      CategoryRemoteDatasourceImpl(apiClient: serviceLocator<APIClient>()));
  serviceLocator.registerFactory<CategoryRepository>(
      () => CategoryRepositoryImpl(categoryRemoteDatasource: serviceLocator()));
  serviceLocator.registerFactory(
      () => CategoryListUsecase(categoryRepository: serviceLocator()));
  serviceLocator
      .registerLazySingleton(() => CategoryBloc(usecase: serviceLocator()));
}

void _emailTemplate() {
  serviceLocator.registerFactory<EmailTemplateRemotedatasource>(() =>
      EmailTemplateRemotedatasourceImpl(
          apiClient: serviceLocator<APIClient>()));
  serviceLocator.registerFactory<EmailTemplateRepository>(() =>
      EmailTemplateRepositoryImpl(
          emailTemplateRemotedatasource: serviceLocator()));

  serviceLocator.registerFactory(() =>
      UpDateEmailTemplateUsecase(emailTemplateRepository: serviceLocator()));
  serviceLocator.registerFactory(
      () => EmailTemplateUsecase(emailTemplateRepository: serviceLocator()));

  serviceLocator.registerLazySingleton(() => EmailTemplatesBloc(
      emailTemplateUsecase: serviceLocator(),
      upDateEmailTemplateUsecase: serviceLocator()));
}

void _notification() {
  serviceLocator.registerFactory<NotificationRemoteDatasource>(() =>
      NotificationRemoteDatasourceImpl(apiClient: serviceLocator<APIClient>()));
  serviceLocator.registerFactory<NotificationRepository>(() =>
      NotificationRepositoryImpl(
          notificationRemoteDatasourceImpl: serviceLocator()));
  serviceLocator.registerFactory(
      () => NotificationListUsercase(notificationRepository: serviceLocator()));
  serviceLocator.registerLazySingleton(
      () => NotificationBloc(notificationListUsercase: serviceLocator()));
}

void _initProfile() {
  serviceLocator.registerLazySingleton(() => GeneralBloc());
  serviceLocator.registerFactory<ProfileRemoteDataSource>(() =>
      ProfileRemoteDataSourceImpl(apiClient: serviceLocator<APIClient>()));
  serviceLocator.registerFactory<ProfileRepository>(
      () => ProfileRepositoryImpl(profileRemoteDataSource: serviceLocator()));
  serviceLocator.registerFactory(
      () => SelectOrganizationUseCase(profileRepository: serviceLocator()));
  serviceLocator.registerFactory(
      () => UpdateProfileUsecase(profileRepository: serviceLocator()));

  serviceLocator.registerLazySingleton(() => ProfileBloc(
        selectOrganizationUseCase: serviceLocator(),
        updateProfileUsecase: serviceLocator(),
      ));
}

void _initOrganization() {
  serviceLocator.registerFactory<OrganizationRemoteDatasource>(() =>
      OrganizationRemoteDatasourceImpl(apiClient: serviceLocator<APIClient>()));
  serviceLocator.registerFactory<OrganizationRepository>(() =>
      OrganizationRepositoryimpl(
          organizationRemoteDatasource: serviceLocator()));
  serviceLocator.registerFactory(
      () => OrganizationListUsecase(organizationRepository: serviceLocator()));
  serviceLocator.registerFactory(() =>
      UpdateOrganizationUsecase(organizationRepository: serviceLocator()));

  serviceLocator.registerFactory(
      () => PreferenceUpdateUsecase(organizationRepository: serviceLocator()));

  serviceLocator.registerFactory(
      () => PreferenceDetailsUsecase(organizationRepository: serviceLocator()));

  serviceLocator.registerFactory(() =>
      UpdatePreferenceColumnUsecase(organizationRepository: serviceLocator()));

  serviceLocator.registerFactory(() => UpdatePreferenceEstimateUsecase(
      organizationRepository: serviceLocator()));

  serviceLocator.registerFactory(
      () => UpdatePrefInvoiceUsecase(organizationRepository: serviceLocator()));

  serviceLocator.registerFactory(
      () => UpdatePrefGeneralUsecase(organizationRepository: serviceLocator()));

  serviceLocator.registerLazySingleton(() => OrganizationBloc(
      organizationListUsecase: serviceLocator(),
      updateOrganizationUsecase: serviceLocator(),
      preferenceUpdateUsecase: serviceLocator(),
      preferenceDetailsUsecase: serviceLocator(),
      updatePreferenceColumnUsecase: serviceLocator(),
      updatePreferenceEstimateUsecase: serviceLocator(),
      updatePrefGeneralUsecase: serviceLocator(),
      updatePrefInvoiceUsecase: serviceLocator()));
}

void _initOnlinePayments() {
  serviceLocator.registerFactory<OnlinePaymentsRemoteDatasource>(() =>
      OnlinePaymentsRemoteDatasourceImpl(
          apiClient: serviceLocator<APIClient>()));
  serviceLocator.registerFactory<OnlinePaymentRepository>(() =>
      OnlinePaymentRepositoryImpl(
          onlinePaymentsRemoteDatasource: serviceLocator()));
  serviceLocator.registerFactory(() =>
      OnlinePaymentDetailsUsecase(onlinePaymentRepository: serviceLocator()));
  serviceLocator.registerFactory(
      () => PaypalUsecase(onlinePaymentRepository: serviceLocator()));

  serviceLocator.registerFactory(
      () => AuthorizeUseCase(onlinePaymentRepository: serviceLocator()));
  serviceLocator.registerFactory(
      () => BrainTreeUseCase(onlinePaymentRepository: serviceLocator()));

  serviceLocator.registerFactory(
      () => CheckoutUseCase(onlinePaymentRepository: serviceLocator()));

  serviceLocator.registerFactory(
      () => StripeUseCase(onlinePaymentRepository: serviceLocator()));

  serviceLocator.registerLazySingleton(() => OnlinePaymentsBloc(
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
      ));
}

void _initDashboard() {
  serviceLocator.registerFactory<DashboardRemoteDatasource>(
      () => DashboardRemoteDatasourceImpl(apiClient: serviceLocator()));
  serviceLocator.registerFactory<DashboardRepository>(() =>
      DashboardRepositoryImpl(dashboardRemoteDatasource: serviceLocator()));

  serviceLocator.registerFactory(
      () => TotalReceivablesUsecase(dashboardRepository: serviceLocator()));

  serviceLocator.registerFactory(
      () => TotalIncomesUsecase(dashboardRepository: serviceLocator()));

  serviceLocator.registerFactory(
      () => SalesExpensesUsecase(dashboardRepository: serviceLocator()));

  serviceLocator.registerFactory(
      () => AccountReceivablesUsecase(dashboardRepository: serviceLocator()));

  serviceLocator.registerFactory(
      () => OverdueInvoiceUsecase(dashboardRepository: serviceLocator()));

  serviceLocator.registerFactory(
      () => AuthInfoUsecase(dashboardRepository: serviceLocator()));

  serviceLocator.registerLazySingleton(() => TotalincomesBloc(
        // accountReceivablesUsecase: serviceLocator(),
        // overdueInvoiceUsecase: serviceLocator(),
        // salesExpensesUsecase: serviceLocator(),
        totalIncomesUsecase: serviceLocator(),
        //totalReceivablesUsecase: serviceLocator(),
      ));

  serviceLocator.registerLazySingleton(() => OverdueinvoiceBloc(
        // accountReceivablesUsecase: serviceLocator(),
        overdueInvoiceUsecase: serviceLocator(),
        // salesExpensesUsecase: serviceLocator(),
        //totalReceivablesUsecase: serviceLocator(),
      ));

  serviceLocator.registerLazySingleton(() => AccountrecivableBloc(
        accountReceivablesUsecase: serviceLocator(),
        //overdueInvoiceUsecase: serviceLocator(),
        // salesExpensesUsecase: serviceLocator(),
        //totalReceivablesUsecase: serviceLocator(),
      ));
  serviceLocator.registerLazySingleton(() => SalesexpensesBloc(
        salesExpensesUsecase: serviceLocator(),
        //overdueInvoiceUsecase: serviceLocator(),
        // salesExpensesUsecase: serviceLocator(),
        //totalReceivablesUsecase: serviceLocator(),
      ));

  serviceLocator.registerLazySingleton(() => TotalreceivableBloc(
        totalReceivablesUsecase: serviceLocator(),
      ));
  serviceLocator.registerLazySingleton(() => AuthinfoBloc(
        authInfoUsecase: serviceLocator(),
      ));
}

void _initEstimates() {
  serviceLocator.registerFactory<EstimateDataSource>(
      () => EstimateDataSourceImpl(apiClient: serviceLocator<APIClient>()));
  serviceLocator.registerFactory<EstimateRepository>(
      () => EstimateRepositoryImpl(estimateDataSource: serviceLocator()));
  serviceLocator.registerFactory(
      () => EstimateListUsecase(estimateRepository: serviceLocator()));

  serviceLocator.registerFactory(
      () => EstimateDetailUsecase(estimateRepository: serviceLocator()));
  serviceLocator.registerLazySingleton(() => EstimateBloc(
        estimateListUsecase: serviceLocator(),
        estimateDetailUsecase: serviceLocator(),
      ));
}

void _initExpenses() {
  serviceLocator.registerFactory<ExpensesRemoteDatasource>(() =>
      ExpensesRemoteDatasourceImpl(apiClient: serviceLocator<APIClient>()));
  serviceLocator.registerFactory<ExpensesRepository>(
      () => ExpensesRepositoryImpl(expensesRemoteDatasource: serviceLocator()));
  serviceLocator.registerFactory(
      () => ExpensesListUsecase(expensesRepository: serviceLocator()));

  serviceLocator.registerFactory(
      () => DeleteExpenseUsecase(expensesRepository: serviceLocator()));

  serviceLocator.registerFactory(
      () => NewExpensesUsecase(expensesRepository: serviceLocator()));
  serviceLocator.registerLazySingleton(() => ExpensesBloc(
      expensesListUsecase: serviceLocator(),
      newExpensesUsecase: serviceLocator(),
      deleteExpenseUsecase: serviceLocator()));
}

void _initUsers() {
  serviceLocator.registerFactory<UserRemoteDatasource>(
      () => UserRemoteDatasourceImp(apiClient: serviceLocator<APIClient>()));
  serviceLocator.registerFactory<UserRepository>(
      () => UserRepositoryImp(userRemoteDatasource: serviceLocator()));
  serviceLocator
      .registerFactory(() => UserListUsecase(userRepository: serviceLocator()));
  serviceLocator
      .registerLazySingleton(() => UserBloc(userListUsecase: serviceLocator()));
}

void _initProject() {
  serviceLocator.registerFactory<ProjectDatasource>(
      () => ProjectDatasourceImpl(apiClient: serviceLocator()));
  serviceLocator.registerFactory<ProjectRepository>(
      () => ProjectRepositoryImpl(projectDatasource: serviceLocator()));

  serviceLocator.registerFactory(
      () => ProjectListUsecase(projectRepository: serviceLocator()));
  serviceLocator.registerFactory(
      () => AddProjectUseCase(projectRepository: serviceLocator()));
  serviceLocator.registerFactory(
      () => DeleteProjectUserCase(projectRepository: serviceLocator()));

  serviceLocator.registerFactory(
      () => UpdateProjectStatusUseCase(projectRepository: serviceLocator()));

  serviceLocator.registerFactory(
      () => ProjectDetailUseCase(projectRepository: serviceLocator()));
  serviceLocator.registerLazySingleton(() => ProjectBloc(
        projectListUsecase: serviceLocator(),
        addProjectUseCase: serviceLocator(),
        deleteProjectUserCase: serviceLocator(),
        updateProjectStatusUseCase: serviceLocator(),
        projectDetailUseCase: serviceLocator(),
      ));
}

void _initTax() {
  serviceLocator.registerFactory<TaxRemoteDatasource>(
    () => TaxRemoteDatasourceImpl(apiClient: serviceLocator<APIClient>()),
  );
  serviceLocator.registerFactory<TaxRepository>(() => TaxRepositoryImpl(
      taxRemoteDatasource: serviceLocator<TaxRemoteDatasource>()));
  serviceLocator
      .registerFactory(() => TaxListUsecase(taxRepository: serviceLocator()));
  serviceLocator
      .registerFactory(() => AddTaxUseCase(taxRepository: serviceLocator()));
  serviceLocator
      .registerFactory(() => TaxDeleteUseCase(taxRepository: serviceLocator()));
  serviceLocator.registerLazySingleton(() => TaxBloc(
      taxListUsecase: serviceLocator(),
      addTaxUseCase: serviceLocator(),
      deleteTaxUseCase: serviceLocator()));
}

void _initClient() {
  serviceLocator.registerFactory<ClientRemoteDataSource>(
    () => ClientRemoteDataSourceImpl(serviceLocator<APIClient>()),
  );
  serviceLocator.registerFactory<ClientRepository>(
      () => ClientRepositoryImpl(serviceLocator<ClientRemoteDataSource>()));
  serviceLocator.registerFactory(() => ClientListUseCase(serviceLocator()));
  serviceLocator.registerFactory(
      () => DeleteClientUseCase(clientRepository: serviceLocator()));
  serviceLocator.registerFactory(
      () => UpdateClientStatusUseCase(clientRepository: serviceLocator()));

  serviceLocator.registerFactory(
      () => ClientDetailsUseCase(clientRepository: serviceLocator()));

  serviceLocator.registerFactory(
      () => AddClientUsecase(clientRepository: serviceLocator()));

  serviceLocator.registerLazySingleton(() => ClientBloc(
        clientListUseCase: serviceLocator(),
        deleteClientUseCase: serviceLocator(),
        updateClientStatusUseCase: serviceLocator(),
        clientDetailsUseCase: serviceLocator(),
        addClientUsecase: serviceLocator(),
      ));
}

void _initItem() {
  serviceLocator.registerFactory<ItemRemoteDatasource>(
      () => ItemRemoteDatasourceImpl(apiClient: serviceLocator<APIClient>()));
  serviceLocator.registerFactory<ItemRepository>(
      () => ItemRepositoryImpl(itemRemoteDatasource: serviceLocator()));
  serviceLocator
      .registerFactory(() => ItemUsecase(itemRepository: serviceLocator()));
  serviceLocator
      .registerFactory(() => AddItemUseCase(itemRepository: serviceLocator()));

  serviceLocator.registerFactory(
      () => ItemMarkActiveUseCase(itemRepository: serviceLocator()));

  serviceLocator.registerFactory(
      () => ItemMarkInActiveUseCase(itemRepository: serviceLocator()));

  serviceLocator.registerFactory(
      () => DeleteItemUseCase(itemRepository: serviceLocator()));
  serviceLocator.registerLazySingleton(() => ItemBloc(
        itemUsecase: serviceLocator(),
        addItemUseCase: serviceLocator(),
        deleteItemUseCase: serviceLocator(),
        itemMarkActiveUseCase: serviceLocator(),
        itemMarkInActiveUseCase: serviceLocator(),
      ));
}

void _initInvoice() {
  serviceLocator.registerFactory<InvoiceRemoteDatasource>(() =>
      InvoiceRemoteDatasourceImpl(apiClient: serviceLocator<APIClient>()));
  serviceLocator.registerFactory<InvoiceRepository>(
      () => InvoiceRepositoryImpl(invoiceRemoteDatasource: serviceLocator()));
  serviceLocator.registerFactory(
      () => InvoiceDetailUsecase(invoiceRepository: serviceLocator()));
  serviceLocator.registerFactory(
      () => InvoiceListUsecase(invoiceRepository: serviceLocator()));

  serviceLocator.registerFactory(
      () => PaymentListUsecase(invoiceRepository: serviceLocator()));

  serviceLocator.registerFactory(
      () => PaymentDetailsUsecase(invoiceRepository: serviceLocator()));
  serviceLocator.registerFactory(
      () => InvoiceVoidUsecase(invoiceRepository: serviceLocator()));

  serviceLocator.registerFactory(
      () => InvoiceUnvoidUsecase(invoiceRepository: serviceLocator()));

  serviceLocator.registerFactory(
      () => InvoiceDeleteUsecase(invoiceRepository: serviceLocator()));

  serviceLocator.registerFactory(
      () => InvoiceMarkassendUsecase(invoiceRepository: serviceLocator()));

  serviceLocator.registerFactory(
      () => AddInvoiceUsecase(invoiceRepository: serviceLocator()));
  serviceLocator.registerFactory(
      () => ClientStaffUsecase(invoiceRepository: serviceLocator()));

  serviceLocator.registerFactory(
      () => GetDocumentUsecase(invoiceRepository: serviceLocator()));

  serviceLocator.registerFactory(
      () => DeletePaymentUsecase(invoiceRepository: serviceLocator()));

  serviceLocator.registerFactory(
      () => AddPaymentUsecase(invoiceRepository: serviceLocator()));

  serviceLocator.registerFactory(
      () => SendDocumentUsecase(invoiceRepository: serviceLocator()));

  serviceLocator.registerLazySingleton(() => InvoiceBloc(
        invoiceDetailUsecase: serviceLocator(),
        invoiceListUsecase: serviceLocator(),
        paymentListUsecase: serviceLocator(),
        paymentDetailsUsecase: serviceLocator(),
        invoiceVoidUsecase: serviceLocator(),
        invoiceUnvoidUsecase: serviceLocator(),
        invoiceDeleteUsecase: serviceLocator(),
        invoiceMarkassendUsecase: serviceLocator(),
        addInvoiceUsecase: serviceLocator(),
        clientStaffUsecase: serviceLocator(),
        getDocumentUsecase: serviceLocator(),
        deletePaymentUsecase: serviceLocator(),
        addPaymentUsecase: serviceLocator(),
        sendDocumentUsecase: serviceLocator(),
      ));
}

void _initAuth() {
  serviceLocator.registerFactory<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(serviceLocator<APIClient>()),
  );
  serviceLocator.registerFactory<AuthRepository>(
      () => AuthRepositoryImp(serviceLocator<AuthRemoteDataSource>()));
  serviceLocator.registerFactory(() => UserLogin(serviceLocator()));

  serviceLocator.registerFactory(() => ResetPasswordUseCase(serviceLocator()));
  serviceLocator
      .registerFactory(() => ResetPasswordRequestUseCase(serviceLocator()));

  serviceLocator.registerFactory(
      () => RegisterUserUseCase(authRepository: serviceLocator()));
  serviceLocator.registerLazySingleton(() => AuthBloc(
        userLogin: serviceLocator(),
        resetPasswordUseCase: serviceLocator(),
        resetPasswordRequestUseCase: serviceLocator(),
        registerUserUseCase: serviceLocator(),
      ));
}
