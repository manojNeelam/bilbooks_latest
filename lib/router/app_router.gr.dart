// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    AddCreateNotePageRoute.name: (routeData) {
      final args = routeData.argsAs<AddCreateNotePageRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: AddCreateNotePage(
          key: args.key,
          screenType: args.screenType,
          creditNoteId: args.creditNoteId,
          onrefreshPage: args.onrefreshPage,
        ),
      );
    },
    AddNewInvoiceEstimatePageRoute.name: (routeData) {
      final args = routeData.argsAs<AddNewInvoiceEstimatePageRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: AddNewInvoiceEstimatePage(
          key: args.key,
          invoiceEntity: args.invoiceEntity,
          estimateTitle: args.estimateTitle,
          type: args.type,
          refreshCallBack: args.refreshCallBack,
          invoiceDetailResEntity: args.invoiceDetailResEntity,
          startObserveBlocBack: args.startObserveBlocBack,
          deletedItem: args.deletedItem,
        ),
      );
    },
    AddNewLineItemPageRoute.name: (routeData) {
      final args = routeData.argsAs<AddNewLineItemPageRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: AddNewLineItemPage(
          key: args.key,
          items: args.items,
          enterItemModel: args.enterItemModel,
          taxes: args.taxes,
          updateLineItem: args.updateLineItem,
          updateIndex: args.updateIndex,
        ),
      );
    },
    AddPaymentPageRoute.name: (routeData) {
      final args = routeData.argsAs<AddPaymentPageRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: AddPaymentPage(
          key: args.key,
          balanceAmount: args.balanceAmount,
          id: args.id,
          paymentEntity: args.paymentEntity,
          refreshPage: args.refreshPage,
          emailList: args.emailList,
          startObserveBlocBack: args.startObserveBlocBack,
        ),
      );
    },
    AddPersonPageRoute.name: (routeData) {
      final args = routeData.argsAs<AddPersonPageRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: AddPersonPage(
          key: args.key,
          clientPersonModel: args.clientPersonModel,
          callback: args.callback,
        ),
      );
    },
    AddProjectPageRoute.name: (routeData) {
      final args = routeData.argsAs<AddProjectPageRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: AddProjectPage(
          key: args.key,
          projectEntity: args.projectEntity,
          deletedProject: args.deletedProject,
          updatedProject: args.updatedProject,
          popBack: args.popBack,
          clientEntity: args.clientEntity,
        ),
      );
    },
    AddTaxPageRoute.name: (routeData) {
      final args = routeData.argsAs<AddTaxPageRouteArgs>(
          orElse: () => const AddTaxPageRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: AddTaxPage(
          key: args.key,
          taxEntity: args.taxEntity,
          refreshPage: args.refreshPage,
        ),
      );
    },
    AuthorizePageRoute.name: (routeData) {
      final args = routeData.argsAs<AuthorizePageRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: AuthorizePage(
          key: args.key,
          onlinePaymentsEntity: args.onlinePaymentsEntity,
          refreshList: args.refreshList,
        ),
      );
    },
    BillingAddressPageRoute.name: (routeData) {
      final args = routeData.argsAs<BillingAddressPageRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: BillingAddressPage(
          key: args.key,
          billingAddress: args.billingAddress,
          callBack: args.callBack,
        ),
      );
    },
    BraintreePageRoute.name: (routeData) {
      final args = routeData.argsAs<BraintreePageRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: BraintreePage(
          key: args.key,
          onlinePaymentsEntity: args.onlinePaymentsEntity,
          refreshList: args.refreshList,
        ),
      );
    },
    CategoriesRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const Categories(),
      );
    },
    CategoryListPageRoute.name: (routeData) {
      final args = routeData.argsAs<CategoryListPageRouteArgs>(
          orElse: () => const CategoryListPageRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CategoryListPage(
          key: args.key,
          categoryEntity: args.categoryEntity,
          onSelectCategory: args.onSelectCategory,
        ),
      );
    },
    CheckoutPageRoute.name: (routeData) {
      final args = routeData.argsAs<CheckoutPageRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CheckoutPage(
          key: args.key,
          onlinePaymentsEntity: args.onlinePaymentsEntity,
          refreshList: args.refreshList,
        ),
      );
    },
    ClientDetailPageRoute.name: (routeData) {
      final args = routeData.argsAs<ClientDetailPageRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ClientDetailPage(
          key: args.key,
          clientEntity: args.clientEntity,
          refreshList: args.refreshList,
        ),
      );
    },
    ClientListPageRoute.name: (routeData) {
      final args = routeData.argsAs<ClientListPageRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ClientListPage(
          key: args.key,
          builder: args.builder,
        ),
      );
    },
    ClientPopupRoute.name: (routeData) {
      final args = routeData.argsAs<ClientPopupRouteArgs>(
          orElse: () => const ClientPopupRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ClientPopup(
          key: args.key,
          selectedClient: args.selectedClient,
          onSelectClient: args.onSelectClient,
          clientListFromParentClass: args.clientListFromParentClass,
        ),
      );
    },
    ClientSortPageRoute.name: (routeData) {
      final args = routeData.argsAs<ClientSortPageRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ClientSortPage(
          key: args.key,
          callBack: args.callBack,
          selectedOrderBy: args.selectedOrderBy,
          selectedType: args.selectedType,
          selectedClientSortBy: args.selectedClientSortBy,
        ),
      );
    },
    CreditNotesListPageRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CreditNotesListPage(),
      );
    },
    EmailTemplatePageRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const EmailTemplatePage(),
      );
    },
    EmailToPageRoute.name: (routeData) {
      final args = routeData.argsAs<EmailToPageRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: EmailToPage(
          key: args.key,
          clientStaff: args.clientStaff,
          myStaffList: args.myStaffList,
          selectedClientStaff: args.selectedClientStaff,
          selectedMyStaffList: args.selectedMyStaffList,
          onpressDone: args.onpressDone,
        ),
      );
    },
    EstimateAddInfoDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<EstimateAddInfoDetailsRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: EstimateAddInfoDetails(
          key: args.key,
          estimateTitle: args.estimateTitle,
          invoiceRequestModel: args.invoiceRequestModel,
          callback: args.callback,
        ),
      );
    },
    EstimateSortPageRoute.name: (routeData) {
      final args = routeData.argsAs<EstimateSortPageRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: EstimateSortPage(
          key: args.key,
          callBack: args.callBack,
          selectedEstimateSortBy: args.selectedEstimateSortBy,
          selectedOrderBy: args.selectedOrderBy,
          selectedType: args.selectedType,
        ),
      );
    },
    ExpensesListPageRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ExpensesListPage(),
      );
    },
    ExpensesSortPageRoute.name: (routeData) {
      final args = routeData.argsAs<ExpensesSortPageRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ExpensesSortPage(
          key: args.key,
          callBack: args.callBack,
          selectedType: args.selectedType,
          selectedExpenseSortBy: args.selectedExpenseSortBy,
          selectedOrderBy: args.selectedOrderBy,
        ),
      );
    },
    ForgotPasswordPageRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ForgotPasswordPage(),
      );
    },
    GeneralRoute.name: (routeData) {
      final args = routeData.argsAs<GeneralRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: General(
          key: args.key,
          authInfoMainDataEntity: args.authInfoMainDataEntity,
        ),
      );
    },
    InvoiceAddBasicDetailsWidgetRoute.name: (routeData) {
      final args = routeData.argsAs<InvoiceAddBasicDetailsWidgetRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: InvoiceAddBasicDetailsWidget(
          key: args.key,
          invoiceRequestModel: args.invoiceRequestModel,
          callback: args.callback,
        ),
      );
    },
    InvoiceDetailPageRoute.name: (routeData) {
      final args = routeData.argsAs<InvoiceDetailPageRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: InvoiceDetailPage(
          key: args.key,
          invoiceEntity: args.invoiceEntity,
          type: args.type,
          refreshList: args.refreshList,
          startObserveBlocBack: args.startObserveBlocBack,
          estimateTitle: args.estimateTitle,
        ),
      );
    },
    InvoiceEstimateTermsInoutPageRoute.name: (routeData) {
      final args = routeData.argsAs<InvoiceEstimateTermsInoutPageRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: InvoiceEstimateTermsInoutPage(
          key: args.key,
          terms: args.terms,
          callback: args.callback,
        ),
      );
    },
    InvoiceHistoryListRoute.name: (routeData) {
      final args = routeData.argsAs<InvoiceHistoryListRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: InvoiceHistoryList(
          key: args.key,
          historyList: args.historyList,
        ),
      );
    },
    InvoiceSortPageRoute.name: (routeData) {
      final args = routeData.argsAs<InvoiceSortPageRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: InvoiceSortPage(
          key: args.key,
          callBack: args.callBack,
          selectedType: args.selectedType,
          selectedInvoiceSortBy: args.selectedInvoiceSortBy,
          selectedOrderBy: args.selectedOrderBy,
        ),
      );
    },
    ItemListRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ItemList(),
      );
    },
    ItemSortPageRoute.name: (routeData) {
      final args = routeData.argsAs<ItemSortPageRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ItemSortPage(
          key: args.key,
          callBack: args.callBack,
          selectedItemSortBy: args.selectedItemSortBy,
          selectedOrderBy: args.selectedOrderBy,
          selectedType: args.selectedType,
        ),
      );
    },
    ItemsPopupRoute.name: (routeData) {
      final args = routeData.argsAs<ItemsPopupRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ItemsPopup(
          key: args.key,
          selectedItem: args.selectedItem,
          onSelectedItem: args.onSelectedItem,
          itemsListFromBaseClass: args.itemsListFromBaseClass,
        ),
      );
    },
    LayoutBuilderDemoRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const LayoutBuilderDemo(),
      );
    },
    LineItemTotalSelectionPageRoute.name: (routeData) {
      final args = routeData.argsAs<LineItemTotalSelectionPageRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: LineItemTotalSelectionPage(
          key: args.key,
          shippingDiscountModel: args.shippingDiscountModel,
          callBack: args.callBack,
        ),
      );
    },
    LoginPageRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const LoginPage(),
      );
    },
    MorePageRoute.name: (routeData) {
      final args = routeData.argsAs<MorePageRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: MorePage(
          key: args.key,
          authInfoMainDataEntity: args.authInfoMainDataEntity,
        ),
      );
    },
    MoreReportsPageRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MoreReportsPage(),
      );
    },
    NewClientPageRoute.name: (routeData) {
      final args = routeData.argsAs<NewClientPageRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: NewClientPage(
          key: args.key,
          clientEntity: args.clientEntity,
          refreshClient: args.refreshClient,
          clientRemoved: args.clientRemoved,
          onPopBack: args.onPopBack,
        ),
      );
    },
    NewExpensesRoute.name: (routeData) {
      final args = routeData.argsAs<NewExpensesRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: NewExpenses(
          key: args.key,
          expenseScreenType: args.expenseScreenType,
          refreshPage: args.refreshPage,
          expenseEntity: args.expenseEntity,
        ),
      );
    },
    NewItemPageRoute.name: (routeData) {
      final args = routeData.argsAs<NewItemPageRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: NewItemPage(
          key: args.key,
          itemListEntity: args.itemListEntity,
          refreshPage: args.refreshPage,
          isFromDuplicate: args.isFromDuplicate,
          popBack: args.popBack,
        ),
      );
    },
    NotificationPageRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const NotificationPage(),
      );
    },
    OnlinePaymentsPageRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const OnlinePaymentsPage(),
      );
    },
    OrganizationProfilePageRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const OrganizationProfilePage(),
      );
    },
    PaymentListPageRoute.name: (routeData) {
      final args = routeData.argsAs<PaymentListPageRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: PaymentListPage(
          key: args.key,
          refreshPage: args.refreshPage,
          payments: args.payments,
          balanceAmount: args.balanceAmount,
          invoiceId: args.invoiceId,
          emailList: args.emailList,
        ),
      );
    },
    PaypalPageRoute.name: (routeData) {
      final args = routeData.argsAs<PaypalPageRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: PaypalPage(
          key: args.key,
          onlinePaymentsEntity: args.onlinePaymentsEntity,
          refreshList: args.refreshList,
        ),
      );
    },
    PdfviewerPageRoute.name: (routeData) {
      final args = routeData.argsAs<PdfviewerPageRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: PdfviewerPage(
          key: args.key,
          enumPageType: args.enumPageType,
          id: args.id,
          isPrint: args.isPrint,
        ),
      );
    },
    PlanExpiredPageRoute.name: (routeData) {
      final args = routeData.argsAs<PlanExpiredPageRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: PlanExpiredPage(
          key: args.key,
          planName: args.planName,
        ),
      );
    },
    PreferencesPageRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const PreferencesPage(),
      );
    },
    ProjectDetailPageRoute.name: (routeData) {
      final args = routeData.argsAs<ProjectDetailPageRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ProjectDetailPage(
          key: args.key,
          projectEntity: args.projectEntity,
          refreshPage: args.refreshPage,
        ),
      );
    },
    ProjectListPageRoute.name: (routeData) {
      final args = routeData.argsAs<ProjectListPageRouteArgs>(
          orElse: () => const ProjectListPageRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ProjectListPage(
          key: args.key,
          isFromMore: args.isFromMore,
        ),
      );
    },
    ProjectPopupRoute.name: (routeData) {
      final args = routeData.argsAs<ProjectPopupRouteArgs>(
          orElse: () => const ProjectPopupRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ProjectPopup(
          key: args.key,
          onSelectProject: args.onSelectProject,
          selectedProject: args.selectedProject,
          clientId: args.clientId,
          selectedClient: args.selectedClient,
        ),
      );
    },
    ProjectSortPageRoute.name: (routeData) {
      final args = routeData.argsAs<ProjectSortPageRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ProjectSortPage(
          key: args.key,
          callBack: args.callBack,
          selectedOrderBy: args.selectedOrderBy,
          selectedProjectSortBy: args.selectedProjectSortBy,
          selectedType: args.selectedType,
        ),
      );
    },
    ReportCollectionsPageRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ReportCollectionsPage(),
      );
    },
    ReportExpensesPageRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ReportExpensesPage(),
      );
    },
    ReportInvoicePageRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ReportInvoicePage(),
      );
    },
    ReportItemSalesPageRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ReportItemSalesPage(),
      );
    },
    ReportOutstandingsPageRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ReportOutstandingsPage(),
      );
    },
    ReportProfitAndLossPageRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ReportProfitAndLossPage(),
      );
    },
    ReportSalesTaxPageRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ReportSalesTaxPage(),
      );
    },
    SendInvoiceEstimatePageRoute.name: (routeData) {
      final args = routeData.argsAs<SendInvoiceEstimatePageRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: SendInvoiceEstimatePage(
          key: args.key,
          params: args.params,
        ),
      );
    },
    SendtoBccPageRoute.name: (routeData) {
      final args = routeData.argsAs<SendtoBccPageRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: SendtoBccPage(
          key: args.key,
          onpressDone: args.onpressDone,
          list: args.list,
          selectedList: args.selectedList,
        ),
      );
    },
    SettingTemplatePageRoute.name: (routeData) {
      final args = routeData.argsAs<SettingTemplatePageRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: SettingTemplatePage(
          key: args.key,
          enumSettingTemplateType: args.enumSettingTemplateType,
        ),
      );
    },
    SettingsPageRoute.name: (routeData) {
      final args = routeData.argsAs<SettingsPageRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: SettingsPage(
          key: args.key,
          authInfoMainDataEntity: args.authInfoMainDataEntity,
        ),
      );
    },
    ShippingAddressPageRoute.name: (routeData) {
      final args = routeData.argsAs<ShippingAddressPageRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ShippingAddressPage(
          key: args.key,
          billingAddress: args.billingAddress,
          shippingAddress: args.shippingAddress,
          callBack: args.callBack,
        ),
      );
    },
    SignUpPageRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SignUpPage(),
      );
    },
    SplashPageRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SplashPage(),
      );
    },
    StripePageRoute.name: (routeData) {
      final args = routeData.argsAs<StripePageRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: StripePage(
          key: args.key,
          onlinePaymentsEntity: args.onlinePaymentsEntity,
          refreshList: args.refreshList,
        ),
      );
    },
    TaxesListPageRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const TaxesListPage(),
      );
    },
    TermsConditionPageRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const TermsConditionPage(),
      );
    },
    UpdateEmailTemplatePageRoute.name: (routeData) {
      final args = routeData.argsAs<UpdateEmailTemplatePageRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: UpdateEmailTemplatePage(
          key: args.key,
          title: args.title,
          message: args.message,
          subject: args.subject,
          type: args.type,
          refreshPage: args.refreshPage,
        ),
      );
    },
    UpdateUserProfilePageRoute.name: (routeData) {
      final args = routeData.argsAs<UpdateUserProfilePageRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: UpdateUserProfilePage(
          key: args.key,
          authInfoMainDataEntity: args.authInfoMainDataEntity,
        ),
      );
    },
    UserColumnSettingsPageRoute.name: (routeData) {
      final args = routeData.argsAs<UserColumnSettingsPageRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: UserColumnSettingsPage(
          key: args.key,
          onupdateColumnSettings: args.onupdateColumnSettings,
          updatePreferenceColumnReqParams: args.updatePreferenceColumnReqParams,
        ),
      );
    },
    UserProfilePageRoute.name: (routeData) {
      final args = routeData.argsAs<UserProfilePageRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: UserProfilePage(
          key: args.key,
          authInfoMainDataEntity: args.authInfoMainDataEntity,
          refresh: args.refresh,
          updateAuthInfo: args.updateAuthInfo,
        ),
      );
    },
    UsersListPageRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const UsersListPage(),
      );
    },
  };
}

/// generated route for
/// [AddCreateNotePage]
class AddCreateNotePageRoute extends PageRouteInfo<AddCreateNotePageRouteArgs> {
  AddCreateNotePageRoute({
    Key? key,
    required CreditNoteScreenType screenType,
    String creditNoteId = "0",
    dynamic Function()? onrefreshPage,
    List<PageRouteInfo>? children,
  }) : super(
          AddCreateNotePageRoute.name,
          args: AddCreateNotePageRouteArgs(
            key: key,
            screenType: screenType,
            creditNoteId: creditNoteId,
            onrefreshPage: onrefreshPage,
          ),
          initialChildren: children,
        );

  static const String name = 'AddCreateNotePageRoute';

  static const PageInfo<AddCreateNotePageRouteArgs> page =
      PageInfo<AddCreateNotePageRouteArgs>(name);
}

class AddCreateNotePageRouteArgs {
  const AddCreateNotePageRouteArgs({
    this.key,
    required this.screenType,
    this.creditNoteId = "0",
    this.onrefreshPage,
  });

  final Key? key;

  final CreditNoteScreenType screenType;

  final String creditNoteId;

  final dynamic Function()? onrefreshPage;

  @override
  String toString() {
    return 'AddCreateNotePageRouteArgs{key: $key, screenType: $screenType, creditNoteId: $creditNoteId, onrefreshPage: $onrefreshPage}';
  }
}

/// generated route for
/// [AddNewInvoiceEstimatePage]
class AddNewInvoiceEstimatePageRoute
    extends PageRouteInfo<AddNewInvoiceEstimatePageRouteArgs> {
  AddNewInvoiceEstimatePageRoute({
    Key? key,
    InvoiceEntity? invoiceEntity,
    String estimateTitle = "estimate",
    required EnumNewInvoiceEstimateType type,
    required dynamic Function() refreshCallBack,
    required InvoiceDetailResEntity? invoiceDetailResEntity,
    required dynamic Function() startObserveBlocBack,
    required dynamic Function() deletedItem,
    List<PageRouteInfo>? children,
  }) : super(
          AddNewInvoiceEstimatePageRoute.name,
          args: AddNewInvoiceEstimatePageRouteArgs(
            key: key,
            invoiceEntity: invoiceEntity,
            estimateTitle: estimateTitle,
            type: type,
            refreshCallBack: refreshCallBack,
            invoiceDetailResEntity: invoiceDetailResEntity,
            startObserveBlocBack: startObserveBlocBack,
            deletedItem: deletedItem,
          ),
          initialChildren: children,
        );

  static const String name = 'AddNewInvoiceEstimatePageRoute';

  static const PageInfo<AddNewInvoiceEstimatePageRouteArgs> page =
      PageInfo<AddNewInvoiceEstimatePageRouteArgs>(name);
}

class AddNewInvoiceEstimatePageRouteArgs {
  const AddNewInvoiceEstimatePageRouteArgs({
    this.key,
    this.invoiceEntity,
    this.estimateTitle = "estimate",
    required this.type,
    required this.refreshCallBack,
    required this.invoiceDetailResEntity,
    required this.startObserveBlocBack,
    required this.deletedItem,
  });

  final Key? key;

  final InvoiceEntity? invoiceEntity;

  final String estimateTitle;

  final EnumNewInvoiceEstimateType type;

  final dynamic Function() refreshCallBack;

  final InvoiceDetailResEntity? invoiceDetailResEntity;

  final dynamic Function() startObserveBlocBack;

  final dynamic Function() deletedItem;

  @override
  String toString() {
    return 'AddNewInvoiceEstimatePageRouteArgs{key: $key, invoiceEntity: $invoiceEntity, estimateTitle: $estimateTitle, type: $type, refreshCallBack: $refreshCallBack, invoiceDetailResEntity: $invoiceDetailResEntity, startObserveBlocBack: $startObserveBlocBack, deletedItem: $deletedItem}';
  }
}

/// generated route for
/// [AddNewLineItemPage]
class AddNewLineItemPageRoute
    extends PageRouteInfo<AddNewLineItemPageRouteArgs> {
  AddNewLineItemPageRoute({
    Key? key,
    List<ItemListEntity>? items,
    required dynamic Function(
      InvoiceItemEntity?,
      int?,
    ) enterItemModel,
    required List<TaxEntity> taxes,
    InvoiceItemEntity? updateLineItem,
    int? updateIndex,
    List<PageRouteInfo>? children,
  }) : super(
          AddNewLineItemPageRoute.name,
          args: AddNewLineItemPageRouteArgs(
            key: key,
            items: items,
            enterItemModel: enterItemModel,
            taxes: taxes,
            updateLineItem: updateLineItem,
            updateIndex: updateIndex,
          ),
          initialChildren: children,
        );

  static const String name = 'AddNewLineItemPageRoute';

  static const PageInfo<AddNewLineItemPageRouteArgs> page =
      PageInfo<AddNewLineItemPageRouteArgs>(name);
}

class AddNewLineItemPageRouteArgs {
  const AddNewLineItemPageRouteArgs({
    this.key,
    this.items,
    required this.enterItemModel,
    required this.taxes,
    this.updateLineItem,
    this.updateIndex,
  });

  final Key? key;

  final List<ItemListEntity>? items;

  final dynamic Function(
    InvoiceItemEntity?,
    int?,
  ) enterItemModel;

  final List<TaxEntity> taxes;

  final InvoiceItemEntity? updateLineItem;

  final int? updateIndex;

  @override
  String toString() {
    return 'AddNewLineItemPageRouteArgs{key: $key, items: $items, enterItemModel: $enterItemModel, taxes: $taxes, updateLineItem: $updateLineItem, updateIndex: $updateIndex}';
  }
}

/// generated route for
/// [AddPaymentPage]
class AddPaymentPageRoute extends PageRouteInfo<AddPaymentPageRouteArgs> {
  AddPaymentPageRoute({
    Key? key,
    required String balanceAmount,
    required String id,
    PaymentEntity? paymentEntity,
    required dynamic Function() refreshPage,
    required List<EmailtoMystaffEntity> emailList,
    required dynamic Function() startObserveBlocBack,
    List<PageRouteInfo>? children,
  }) : super(
          AddPaymentPageRoute.name,
          args: AddPaymentPageRouteArgs(
            key: key,
            balanceAmount: balanceAmount,
            id: id,
            paymentEntity: paymentEntity,
            refreshPage: refreshPage,
            emailList: emailList,
            startObserveBlocBack: startObserveBlocBack,
          ),
          initialChildren: children,
        );

  static const String name = 'AddPaymentPageRoute';

  static const PageInfo<AddPaymentPageRouteArgs> page =
      PageInfo<AddPaymentPageRouteArgs>(name);
}

class AddPaymentPageRouteArgs {
  const AddPaymentPageRouteArgs({
    this.key,
    required this.balanceAmount,
    required this.id,
    this.paymentEntity,
    required this.refreshPage,
    required this.emailList,
    required this.startObserveBlocBack,
  });

  final Key? key;

  final String balanceAmount;

  final String id;

  final PaymentEntity? paymentEntity;

  final dynamic Function() refreshPage;

  final List<EmailtoMystaffEntity> emailList;

  final dynamic Function() startObserveBlocBack;

  @override
  String toString() {
    return 'AddPaymentPageRouteArgs{key: $key, balanceAmount: $balanceAmount, id: $id, paymentEntity: $paymentEntity, refreshPage: $refreshPage, emailList: $emailList, startObserveBlocBack: $startObserveBlocBack}';
  }
}

/// generated route for
/// [AddPersonPage]
class AddPersonPageRoute extends PageRouteInfo<AddPersonPageRouteArgs> {
  AddPersonPageRoute({
    Key? key,
    ClientPersonModel? clientPersonModel,
    required dynamic Function(ClientPersonModel?) callback,
    List<PageRouteInfo>? children,
  }) : super(
          AddPersonPageRoute.name,
          args: AddPersonPageRouteArgs(
            key: key,
            clientPersonModel: clientPersonModel,
            callback: callback,
          ),
          initialChildren: children,
        );

  static const String name = 'AddPersonPageRoute';

  static const PageInfo<AddPersonPageRouteArgs> page =
      PageInfo<AddPersonPageRouteArgs>(name);
}

class AddPersonPageRouteArgs {
  const AddPersonPageRouteArgs({
    this.key,
    this.clientPersonModel,
    required this.callback,
  });

  final Key? key;

  final ClientPersonModel? clientPersonModel;

  final dynamic Function(ClientPersonModel?) callback;

  @override
  String toString() {
    return 'AddPersonPageRouteArgs{key: $key, clientPersonModel: $clientPersonModel, callback: $callback}';
  }
}

/// generated route for
/// [AddProjectPage]
class AddProjectPageRoute extends PageRouteInfo<AddProjectPageRouteArgs> {
  AddProjectPageRoute({
    Key? key,
    ProjectEntity? projectEntity,
    required dynamic Function() deletedProject,
    required dynamic Function() updatedProject,
    required dynamic Function() popBack,
    ClientEntity? clientEntity,
    List<PageRouteInfo>? children,
  }) : super(
          AddProjectPageRoute.name,
          args: AddProjectPageRouteArgs(
            key: key,
            projectEntity: projectEntity,
            deletedProject: deletedProject,
            updatedProject: updatedProject,
            popBack: popBack,
            clientEntity: clientEntity,
          ),
          initialChildren: children,
        );

  static const String name = 'AddProjectPageRoute';

  static const PageInfo<AddProjectPageRouteArgs> page =
      PageInfo<AddProjectPageRouteArgs>(name);
}

class AddProjectPageRouteArgs {
  const AddProjectPageRouteArgs({
    this.key,
    this.projectEntity,
    required this.deletedProject,
    required this.updatedProject,
    required this.popBack,
    this.clientEntity,
  });

  final Key? key;

  final ProjectEntity? projectEntity;

  final dynamic Function() deletedProject;

  final dynamic Function() updatedProject;

  final dynamic Function() popBack;

  final ClientEntity? clientEntity;

  @override
  String toString() {
    return 'AddProjectPageRouteArgs{key: $key, projectEntity: $projectEntity, deletedProject: $deletedProject, updatedProject: $updatedProject, popBack: $popBack, clientEntity: $clientEntity}';
  }
}

/// generated route for
/// [AddTaxPage]
class AddTaxPageRoute extends PageRouteInfo<AddTaxPageRouteArgs> {
  AddTaxPageRoute({
    Key? key,
    TaxEntity? taxEntity,
    dynamic Function()? refreshPage,
    List<PageRouteInfo>? children,
  }) : super(
          AddTaxPageRoute.name,
          args: AddTaxPageRouteArgs(
            key: key,
            taxEntity: taxEntity,
            refreshPage: refreshPage,
          ),
          initialChildren: children,
        );

  static const String name = 'AddTaxPageRoute';

  static const PageInfo<AddTaxPageRouteArgs> page =
      PageInfo<AddTaxPageRouteArgs>(name);
}

class AddTaxPageRouteArgs {
  const AddTaxPageRouteArgs({
    this.key,
    this.taxEntity,
    this.refreshPage,
  });

  final Key? key;

  final TaxEntity? taxEntity;

  final dynamic Function()? refreshPage;

  @override
  String toString() {
    return 'AddTaxPageRouteArgs{key: $key, taxEntity: $taxEntity, refreshPage: $refreshPage}';
  }
}

/// generated route for
/// [AuthorizePage]
class AuthorizePageRoute extends PageRouteInfo<AuthorizePageRouteArgs> {
  AuthorizePageRoute({
    Key? key,
    OnlinePaymentsEntity? onlinePaymentsEntity,
    required dynamic Function() refreshList,
    List<PageRouteInfo>? children,
  }) : super(
          AuthorizePageRoute.name,
          args: AuthorizePageRouteArgs(
            key: key,
            onlinePaymentsEntity: onlinePaymentsEntity,
            refreshList: refreshList,
          ),
          initialChildren: children,
        );

  static const String name = 'AuthorizePageRoute';

  static const PageInfo<AuthorizePageRouteArgs> page =
      PageInfo<AuthorizePageRouteArgs>(name);
}

class AuthorizePageRouteArgs {
  const AuthorizePageRouteArgs({
    this.key,
    this.onlinePaymentsEntity,
    required this.refreshList,
  });

  final Key? key;

  final OnlinePaymentsEntity? onlinePaymentsEntity;

  final dynamic Function() refreshList;

  @override
  String toString() {
    return 'AuthorizePageRouteArgs{key: $key, onlinePaymentsEntity: $onlinePaymentsEntity, refreshList: $refreshList}';
  }
}

/// generated route for
/// [BillingAddressPage]
class BillingAddressPageRoute
    extends PageRouteInfo<BillingAddressPageRouteArgs> {
  BillingAddressPageRoute({
    Key? key,
    ClientAddAddress? billingAddress,
    required dynamic Function(ClientAddAddress) callBack,
    List<PageRouteInfo>? children,
  }) : super(
          BillingAddressPageRoute.name,
          args: BillingAddressPageRouteArgs(
            key: key,
            billingAddress: billingAddress,
            callBack: callBack,
          ),
          initialChildren: children,
        );

  static const String name = 'BillingAddressPageRoute';

  static const PageInfo<BillingAddressPageRouteArgs> page =
      PageInfo<BillingAddressPageRouteArgs>(name);
}

class BillingAddressPageRouteArgs {
  const BillingAddressPageRouteArgs({
    this.key,
    this.billingAddress,
    required this.callBack,
  });

  final Key? key;

  final ClientAddAddress? billingAddress;

  final dynamic Function(ClientAddAddress) callBack;

  @override
  String toString() {
    return 'BillingAddressPageRouteArgs{key: $key, billingAddress: $billingAddress, callBack: $callBack}';
  }
}

/// generated route for
/// [BraintreePage]
class BraintreePageRoute extends PageRouteInfo<BraintreePageRouteArgs> {
  BraintreePageRoute({
    Key? key,
    OnlinePaymentsEntity? onlinePaymentsEntity,
    required dynamic Function() refreshList,
    List<PageRouteInfo>? children,
  }) : super(
          BraintreePageRoute.name,
          args: BraintreePageRouteArgs(
            key: key,
            onlinePaymentsEntity: onlinePaymentsEntity,
            refreshList: refreshList,
          ),
          initialChildren: children,
        );

  static const String name = 'BraintreePageRoute';

  static const PageInfo<BraintreePageRouteArgs> page =
      PageInfo<BraintreePageRouteArgs>(name);
}

class BraintreePageRouteArgs {
  const BraintreePageRouteArgs({
    this.key,
    this.onlinePaymentsEntity,
    required this.refreshList,
  });

  final Key? key;

  final OnlinePaymentsEntity? onlinePaymentsEntity;

  final dynamic Function() refreshList;

  @override
  String toString() {
    return 'BraintreePageRouteArgs{key: $key, onlinePaymentsEntity: $onlinePaymentsEntity, refreshList: $refreshList}';
  }
}

/// generated route for
/// [Categories]
class CategoriesRoute extends PageRouteInfo<void> {
  const CategoriesRoute({List<PageRouteInfo>? children})
      : super(
          CategoriesRoute.name,
          initialChildren: children,
        );

  static const String name = 'CategoriesRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CategoryListPage]
class CategoryListPageRoute extends PageRouteInfo<CategoryListPageRouteArgs> {
  CategoryListPageRoute({
    Key? key,
    CategoryEntity? categoryEntity,
    dynamic Function(CategoryEntity?)? onSelectCategory,
    List<PageRouteInfo>? children,
  }) : super(
          CategoryListPageRoute.name,
          args: CategoryListPageRouteArgs(
            key: key,
            categoryEntity: categoryEntity,
            onSelectCategory: onSelectCategory,
          ),
          initialChildren: children,
        );

  static const String name = 'CategoryListPageRoute';

  static const PageInfo<CategoryListPageRouteArgs> page =
      PageInfo<CategoryListPageRouteArgs>(name);
}

class CategoryListPageRouteArgs {
  const CategoryListPageRouteArgs({
    this.key,
    this.categoryEntity,
    this.onSelectCategory,
  });

  final Key? key;

  final CategoryEntity? categoryEntity;

  final dynamic Function(CategoryEntity?)? onSelectCategory;

  @override
  String toString() {
    return 'CategoryListPageRouteArgs{key: $key, categoryEntity: $categoryEntity, onSelectCategory: $onSelectCategory}';
  }
}

/// generated route for
/// [CheckoutPage]
class CheckoutPageRoute extends PageRouteInfo<CheckoutPageRouteArgs> {
  CheckoutPageRoute({
    Key? key,
    OnlinePaymentsEntity? onlinePaymentsEntity,
    required dynamic Function() refreshList,
    List<PageRouteInfo>? children,
  }) : super(
          CheckoutPageRoute.name,
          args: CheckoutPageRouteArgs(
            key: key,
            onlinePaymentsEntity: onlinePaymentsEntity,
            refreshList: refreshList,
          ),
          initialChildren: children,
        );

  static const String name = 'CheckoutPageRoute';

  static const PageInfo<CheckoutPageRouteArgs> page =
      PageInfo<CheckoutPageRouteArgs>(name);
}

class CheckoutPageRouteArgs {
  const CheckoutPageRouteArgs({
    this.key,
    this.onlinePaymentsEntity,
    required this.refreshList,
  });

  final Key? key;

  final OnlinePaymentsEntity? onlinePaymentsEntity;

  final dynamic Function() refreshList;

  @override
  String toString() {
    return 'CheckoutPageRouteArgs{key: $key, onlinePaymentsEntity: $onlinePaymentsEntity, refreshList: $refreshList}';
  }
}

/// generated route for
/// [ClientDetailPage]
class ClientDetailPageRoute extends PageRouteInfo<ClientDetailPageRouteArgs> {
  ClientDetailPageRoute({
    Key? key,
    required ClientEntity clientEntity,
    dynamic Function()? refreshList,
    List<PageRouteInfo>? children,
  }) : super(
          ClientDetailPageRoute.name,
          args: ClientDetailPageRouteArgs(
            key: key,
            clientEntity: clientEntity,
            refreshList: refreshList,
          ),
          initialChildren: children,
        );

  static const String name = 'ClientDetailPageRoute';

  static const PageInfo<ClientDetailPageRouteArgs> page =
      PageInfo<ClientDetailPageRouteArgs>(name);
}

class ClientDetailPageRouteArgs {
  const ClientDetailPageRouteArgs({
    this.key,
    required this.clientEntity,
    this.refreshList,
  });

  final Key? key;

  final ClientEntity clientEntity;

  final dynamic Function()? refreshList;

  @override
  String toString() {
    return 'ClientDetailPageRouteArgs{key: $key, clientEntity: $clientEntity, refreshList: $refreshList}';
  }
}

/// generated route for
/// [ClientListPage]
class ClientListPageRoute extends PageRouteInfo<ClientListPageRouteArgs> {
  ClientListPageRoute({
    Key? key,
    required void Function(
      BuildContext,
      void Function(),
    ) builder,
    List<PageRouteInfo>? children,
  }) : super(
          ClientListPageRoute.name,
          args: ClientListPageRouteArgs(
            key: key,
            builder: builder,
          ),
          initialChildren: children,
        );

  static const String name = 'ClientListPageRoute';

  static const PageInfo<ClientListPageRouteArgs> page =
      PageInfo<ClientListPageRouteArgs>(name);
}

class ClientListPageRouteArgs {
  const ClientListPageRouteArgs({
    this.key,
    required this.builder,
  });

  final Key? key;

  final void Function(
    BuildContext,
    void Function(),
  ) builder;

  @override
  String toString() {
    return 'ClientListPageRouteArgs{key: $key, builder: $builder}';
  }
}

/// generated route for
/// [ClientPopup]
class ClientPopupRoute extends PageRouteInfo<ClientPopupRouteArgs> {
  ClientPopupRoute({
    Key? key,
    ClientEntity? selectedClient,
    dynamic Function(ClientEntity?)? onSelectClient,
    List<ClientEntity>? clientListFromParentClass,
    List<PageRouteInfo>? children,
  }) : super(
          ClientPopupRoute.name,
          args: ClientPopupRouteArgs(
            key: key,
            selectedClient: selectedClient,
            onSelectClient: onSelectClient,
            clientListFromParentClass: clientListFromParentClass,
          ),
          initialChildren: children,
        );

  static const String name = 'ClientPopupRoute';

  static const PageInfo<ClientPopupRouteArgs> page =
      PageInfo<ClientPopupRouteArgs>(name);
}

class ClientPopupRouteArgs {
  const ClientPopupRouteArgs({
    this.key,
    this.selectedClient,
    this.onSelectClient,
    this.clientListFromParentClass,
  });

  final Key? key;

  final ClientEntity? selectedClient;

  final dynamic Function(ClientEntity?)? onSelectClient;

  final List<ClientEntity>? clientListFromParentClass;

  @override
  String toString() {
    return 'ClientPopupRouteArgs{key: $key, selectedClient: $selectedClient, onSelectClient: $onSelectClient, clientListFromParentClass: $clientListFromParentClass}';
  }
}

/// generated route for
/// [ClientSortPage]
class ClientSortPageRoute extends PageRouteInfo<ClientSortPageRouteArgs> {
  ClientSortPageRoute({
    Key? key,
    required dynamic Function(
      EnumClientType,
      EnumOrderBy,
      EnumClientSortBy,
    ) callBack,
    required EnumOrderBy selectedOrderBy,
    required EnumClientType selectedType,
    required EnumClientSortBy selectedClientSortBy,
    List<PageRouteInfo>? children,
  }) : super(
          ClientSortPageRoute.name,
          args: ClientSortPageRouteArgs(
            key: key,
            callBack: callBack,
            selectedOrderBy: selectedOrderBy,
            selectedType: selectedType,
            selectedClientSortBy: selectedClientSortBy,
          ),
          initialChildren: children,
        );

  static const String name = 'ClientSortPageRoute';

  static const PageInfo<ClientSortPageRouteArgs> page =
      PageInfo<ClientSortPageRouteArgs>(name);
}

class ClientSortPageRouteArgs {
  const ClientSortPageRouteArgs({
    this.key,
    required this.callBack,
    required this.selectedOrderBy,
    required this.selectedType,
    required this.selectedClientSortBy,
  });

  final Key? key;

  final dynamic Function(
    EnumClientType,
    EnumOrderBy,
    EnumClientSortBy,
  ) callBack;

  final EnumOrderBy selectedOrderBy;

  final EnumClientType selectedType;

  final EnumClientSortBy selectedClientSortBy;

  @override
  String toString() {
    return 'ClientSortPageRouteArgs{key: $key, callBack: $callBack, selectedOrderBy: $selectedOrderBy, selectedType: $selectedType, selectedClientSortBy: $selectedClientSortBy}';
  }
}

/// generated route for
/// [CreditNotesListPage]
class CreditNotesListPageRoute extends PageRouteInfo<void> {
  const CreditNotesListPageRoute({List<PageRouteInfo>? children})
      : super(
          CreditNotesListPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'CreditNotesListPageRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [EmailTemplatePage]
class EmailTemplatePageRoute extends PageRouteInfo<void> {
  const EmailTemplatePageRoute({List<PageRouteInfo>? children})
      : super(
          EmailTemplatePageRoute.name,
          initialChildren: children,
        );

  static const String name = 'EmailTemplatePageRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [EmailToPage]
class EmailToPageRoute extends PageRouteInfo<EmailToPageRouteArgs> {
  EmailToPageRoute({
    Key? key,
    required List<EmailtoMystaffEntity> clientStaff,
    required List<EmailtoMystaffEntity> myStaffList,
    required List<EmailtoMystaffEntity> selectedClientStaff,
    required List<EmailtoMystaffEntity> selectedMyStaffList,
    required dynamic Function(
      List<EmailtoMystaffEntity>,
      List<EmailtoMystaffEntity>,
    ) onpressDone,
    List<PageRouteInfo>? children,
  }) : super(
          EmailToPageRoute.name,
          args: EmailToPageRouteArgs(
            key: key,
            clientStaff: clientStaff,
            myStaffList: myStaffList,
            selectedClientStaff: selectedClientStaff,
            selectedMyStaffList: selectedMyStaffList,
            onpressDone: onpressDone,
          ),
          initialChildren: children,
        );

  static const String name = 'EmailToPageRoute';

  static const PageInfo<EmailToPageRouteArgs> page =
      PageInfo<EmailToPageRouteArgs>(name);
}

class EmailToPageRouteArgs {
  const EmailToPageRouteArgs({
    this.key,
    required this.clientStaff,
    required this.myStaffList,
    required this.selectedClientStaff,
    required this.selectedMyStaffList,
    required this.onpressDone,
  });

  final Key? key;

  final List<EmailtoMystaffEntity> clientStaff;

  final List<EmailtoMystaffEntity> myStaffList;

  final List<EmailtoMystaffEntity> selectedClientStaff;

  final List<EmailtoMystaffEntity> selectedMyStaffList;

  final dynamic Function(
    List<EmailtoMystaffEntity>,
    List<EmailtoMystaffEntity>,
  ) onpressDone;

  @override
  String toString() {
    return 'EmailToPageRouteArgs{key: $key, clientStaff: $clientStaff, myStaffList: $myStaffList, selectedClientStaff: $selectedClientStaff, selectedMyStaffList: $selectedMyStaffList, onpressDone: $onpressDone}';
  }
}

/// generated route for
/// [EstimateAddInfoDetails]
class EstimateAddInfoDetailsRoute
    extends PageRouteInfo<EstimateAddInfoDetailsRouteArgs> {
  EstimateAddInfoDetailsRoute({
    Key? key,
    required String estimateTitle,
    required InvoiceRequestModel invoiceRequestModel,
    required dynamic Function()? callback,
    List<PageRouteInfo>? children,
  }) : super(
          EstimateAddInfoDetailsRoute.name,
          args: EstimateAddInfoDetailsRouteArgs(
            key: key,
            estimateTitle: estimateTitle,
            invoiceRequestModel: invoiceRequestModel,
            callback: callback,
          ),
          initialChildren: children,
        );

  static const String name = 'EstimateAddInfoDetailsRoute';

  static const PageInfo<EstimateAddInfoDetailsRouteArgs> page =
      PageInfo<EstimateAddInfoDetailsRouteArgs>(name);
}

class EstimateAddInfoDetailsRouteArgs {
  const EstimateAddInfoDetailsRouteArgs({
    this.key,
    required this.estimateTitle,
    required this.invoiceRequestModel,
    required this.callback,
  });

  final Key? key;

  final String estimateTitle;

  final InvoiceRequestModel invoiceRequestModel;

  final dynamic Function()? callback;

  @override
  String toString() {
    return 'EstimateAddInfoDetailsRouteArgs{key: $key, estimateTitle: $estimateTitle, invoiceRequestModel: $invoiceRequestModel, callback: $callback}';
  }
}

/// generated route for
/// [EstimateSortPage]
class EstimateSortPageRoute extends PageRouteInfo<EstimateSortPageRouteArgs> {
  EstimateSortPageRoute({
    Key? key,
    required dynamic Function(
      EnumEstimateType,
      EnumOrderBy,
      EnumEstimateSortBy,
    ) callBack,
    required EnumEstimateSortBy selectedEstimateSortBy,
    required EnumOrderBy selectedOrderBy,
    required EnumEstimateType selectedType,
    List<PageRouteInfo>? children,
  }) : super(
          EstimateSortPageRoute.name,
          args: EstimateSortPageRouteArgs(
            key: key,
            callBack: callBack,
            selectedEstimateSortBy: selectedEstimateSortBy,
            selectedOrderBy: selectedOrderBy,
            selectedType: selectedType,
          ),
          initialChildren: children,
        );

  static const String name = 'EstimateSortPageRoute';

  static const PageInfo<EstimateSortPageRouteArgs> page =
      PageInfo<EstimateSortPageRouteArgs>(name);
}

class EstimateSortPageRouteArgs {
  const EstimateSortPageRouteArgs({
    this.key,
    required this.callBack,
    required this.selectedEstimateSortBy,
    required this.selectedOrderBy,
    required this.selectedType,
  });

  final Key? key;

  final dynamic Function(
    EnumEstimateType,
    EnumOrderBy,
    EnumEstimateSortBy,
  ) callBack;

  final EnumEstimateSortBy selectedEstimateSortBy;

  final EnumOrderBy selectedOrderBy;

  final EnumEstimateType selectedType;

  @override
  String toString() {
    return 'EstimateSortPageRouteArgs{key: $key, callBack: $callBack, selectedEstimateSortBy: $selectedEstimateSortBy, selectedOrderBy: $selectedOrderBy, selectedType: $selectedType}';
  }
}

/// generated route for
/// [ExpensesListPage]
class ExpensesListPageRoute extends PageRouteInfo<void> {
  const ExpensesListPageRoute({List<PageRouteInfo>? children})
      : super(
          ExpensesListPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'ExpensesListPageRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ExpensesSortPage]
class ExpensesSortPageRoute extends PageRouteInfo<ExpensesSortPageRouteArgs> {
  ExpensesSortPageRoute({
    Key? key,
    required dynamic Function(
      EnumExpensesType,
      EnumOrderBy,
      EnumExpensesSortBy,
    ) callBack,
    required EnumExpensesType selectedType,
    required EnumExpensesSortBy selectedExpenseSortBy,
    required EnumOrderBy selectedOrderBy,
    List<PageRouteInfo>? children,
  }) : super(
          ExpensesSortPageRoute.name,
          args: ExpensesSortPageRouteArgs(
            key: key,
            callBack: callBack,
            selectedType: selectedType,
            selectedExpenseSortBy: selectedExpenseSortBy,
            selectedOrderBy: selectedOrderBy,
          ),
          initialChildren: children,
        );

  static const String name = 'ExpensesSortPageRoute';

  static const PageInfo<ExpensesSortPageRouteArgs> page =
      PageInfo<ExpensesSortPageRouteArgs>(name);
}

class ExpensesSortPageRouteArgs {
  const ExpensesSortPageRouteArgs({
    this.key,
    required this.callBack,
    required this.selectedType,
    required this.selectedExpenseSortBy,
    required this.selectedOrderBy,
  });

  final Key? key;

  final dynamic Function(
    EnumExpensesType,
    EnumOrderBy,
    EnumExpensesSortBy,
  ) callBack;

  final EnumExpensesType selectedType;

  final EnumExpensesSortBy selectedExpenseSortBy;

  final EnumOrderBy selectedOrderBy;

  @override
  String toString() {
    return 'ExpensesSortPageRouteArgs{key: $key, callBack: $callBack, selectedType: $selectedType, selectedExpenseSortBy: $selectedExpenseSortBy, selectedOrderBy: $selectedOrderBy}';
  }
}

/// generated route for
/// [ForgotPasswordPage]
class ForgotPasswordPageRoute extends PageRouteInfo<void> {
  const ForgotPasswordPageRoute({List<PageRouteInfo>? children})
      : super(
          ForgotPasswordPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'ForgotPasswordPageRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [General]
class GeneralRoute extends PageRouteInfo<GeneralRouteArgs> {
  GeneralRoute({
    Key? key,
    required AuthInfoMainDataEntity authInfoMainDataEntity,
    List<PageRouteInfo>? children,
  }) : super(
          GeneralRoute.name,
          args: GeneralRouteArgs(
            key: key,
            authInfoMainDataEntity: authInfoMainDataEntity,
          ),
          initialChildren: children,
        );

  static const String name = 'GeneralRoute';

  static const PageInfo<GeneralRouteArgs> page =
      PageInfo<GeneralRouteArgs>(name);
}

class GeneralRouteArgs {
  const GeneralRouteArgs({
    this.key,
    required this.authInfoMainDataEntity,
  });

  final Key? key;

  final AuthInfoMainDataEntity authInfoMainDataEntity;

  @override
  String toString() {
    return 'GeneralRouteArgs{key: $key, authInfoMainDataEntity: $authInfoMainDataEntity}';
  }
}

/// generated route for
/// [InvoiceAddBasicDetailsWidget]
class InvoiceAddBasicDetailsWidgetRoute
    extends PageRouteInfo<InvoiceAddBasicDetailsWidgetRouteArgs> {
  InvoiceAddBasicDetailsWidgetRoute({
    Key? key,
    required InvoiceRequestModel invoiceRequestModel,
    required dynamic Function()? callback,
    List<PageRouteInfo>? children,
  }) : super(
          InvoiceAddBasicDetailsWidgetRoute.name,
          args: InvoiceAddBasicDetailsWidgetRouteArgs(
            key: key,
            invoiceRequestModel: invoiceRequestModel,
            callback: callback,
          ),
          initialChildren: children,
        );

  static const String name = 'InvoiceAddBasicDetailsWidgetRoute';

  static const PageInfo<InvoiceAddBasicDetailsWidgetRouteArgs> page =
      PageInfo<InvoiceAddBasicDetailsWidgetRouteArgs>(name);
}

class InvoiceAddBasicDetailsWidgetRouteArgs {
  const InvoiceAddBasicDetailsWidgetRouteArgs({
    this.key,
    required this.invoiceRequestModel,
    required this.callback,
  });

  final Key? key;

  final InvoiceRequestModel invoiceRequestModel;

  final dynamic Function()? callback;

  @override
  String toString() {
    return 'InvoiceAddBasicDetailsWidgetRouteArgs{key: $key, invoiceRequestModel: $invoiceRequestModel, callback: $callback}';
  }
}

/// generated route for
/// [InvoiceDetailPage]
class InvoiceDetailPageRoute extends PageRouteInfo<InvoiceDetailPageRouteArgs> {
  InvoiceDetailPageRoute({
    Key? key,
    required InvoiceEntity invoiceEntity,
    required EnumNewInvoiceEstimateType type,
    dynamic Function()? refreshList,
    required dynamic Function() startObserveBlocBack,
    required String estimateTitle,
    List<PageRouteInfo>? children,
  }) : super(
          InvoiceDetailPageRoute.name,
          args: InvoiceDetailPageRouteArgs(
            key: key,
            invoiceEntity: invoiceEntity,
            type: type,
            refreshList: refreshList,
            startObserveBlocBack: startObserveBlocBack,
            estimateTitle: estimateTitle,
          ),
          initialChildren: children,
        );

  static const String name = 'InvoiceDetailPageRoute';

  static const PageInfo<InvoiceDetailPageRouteArgs> page =
      PageInfo<InvoiceDetailPageRouteArgs>(name);
}

class InvoiceDetailPageRouteArgs {
  const InvoiceDetailPageRouteArgs({
    this.key,
    required this.invoiceEntity,
    required this.type,
    this.refreshList,
    required this.startObserveBlocBack,
    required this.estimateTitle,
  });

  final Key? key;

  final InvoiceEntity invoiceEntity;

  final EnumNewInvoiceEstimateType type;

  final dynamic Function()? refreshList;

  final dynamic Function() startObserveBlocBack;

  final String estimateTitle;

  @override
  String toString() {
    return 'InvoiceDetailPageRouteArgs{key: $key, invoiceEntity: $invoiceEntity, type: $type, refreshList: $refreshList, startObserveBlocBack: $startObserveBlocBack, estimateTitle: $estimateTitle}';
  }
}

/// generated route for
/// [InvoiceEstimateTermsInoutPage]
class InvoiceEstimateTermsInoutPageRoute
    extends PageRouteInfo<InvoiceEstimateTermsInoutPageRouteArgs> {
  InvoiceEstimateTermsInoutPageRoute({
    Key? key,
    required String terms,
    required dynamic Function(String) callback,
    List<PageRouteInfo>? children,
  }) : super(
          InvoiceEstimateTermsInoutPageRoute.name,
          args: InvoiceEstimateTermsInoutPageRouteArgs(
            key: key,
            terms: terms,
            callback: callback,
          ),
          initialChildren: children,
        );

  static const String name = 'InvoiceEstimateTermsInoutPageRoute';

  static const PageInfo<InvoiceEstimateTermsInoutPageRouteArgs> page =
      PageInfo<InvoiceEstimateTermsInoutPageRouteArgs>(name);
}

class InvoiceEstimateTermsInoutPageRouteArgs {
  const InvoiceEstimateTermsInoutPageRouteArgs({
    this.key,
    required this.terms,
    required this.callback,
  });

  final Key? key;

  final String terms;

  final dynamic Function(String) callback;

  @override
  String toString() {
    return 'InvoiceEstimateTermsInoutPageRouteArgs{key: $key, terms: $terms, callback: $callback}';
  }
}

/// generated route for
/// [InvoiceHistoryList]
class InvoiceHistoryListRoute
    extends PageRouteInfo<InvoiceHistoryListRouteArgs> {
  InvoiceHistoryListRoute({
    Key? key,
    required List<InvoiceHistoryEntity> historyList,
    List<PageRouteInfo>? children,
  }) : super(
          InvoiceHistoryListRoute.name,
          args: InvoiceHistoryListRouteArgs(
            key: key,
            historyList: historyList,
          ),
          initialChildren: children,
        );

  static const String name = 'InvoiceHistoryListRoute';

  static const PageInfo<InvoiceHistoryListRouteArgs> page =
      PageInfo<InvoiceHistoryListRouteArgs>(name);
}

class InvoiceHistoryListRouteArgs {
  const InvoiceHistoryListRouteArgs({
    this.key,
    required this.historyList,
  });

  final Key? key;

  final List<InvoiceHistoryEntity> historyList;

  @override
  String toString() {
    return 'InvoiceHistoryListRouteArgs{key: $key, historyList: $historyList}';
  }
}

/// generated route for
/// [InvoiceSortPage]
class InvoiceSortPageRoute extends PageRouteInfo<InvoiceSortPageRouteArgs> {
  InvoiceSortPageRoute({
    Key? key,
    required dynamic Function(
      EnumInvoiceType,
      EnumOrderBy,
      EnumInvoiceSortBy,
    ) callBack,
    required EnumInvoiceType selectedType,
    required EnumInvoiceSortBy selectedInvoiceSortBy,
    required EnumOrderBy selectedOrderBy,
    List<PageRouteInfo>? children,
  }) : super(
          InvoiceSortPageRoute.name,
          args: InvoiceSortPageRouteArgs(
            key: key,
            callBack: callBack,
            selectedType: selectedType,
            selectedInvoiceSortBy: selectedInvoiceSortBy,
            selectedOrderBy: selectedOrderBy,
          ),
          initialChildren: children,
        );

  static const String name = 'InvoiceSortPageRoute';

  static const PageInfo<InvoiceSortPageRouteArgs> page =
      PageInfo<InvoiceSortPageRouteArgs>(name);
}

class InvoiceSortPageRouteArgs {
  const InvoiceSortPageRouteArgs({
    this.key,
    required this.callBack,
    required this.selectedType,
    required this.selectedInvoiceSortBy,
    required this.selectedOrderBy,
  });

  final Key? key;

  final dynamic Function(
    EnumInvoiceType,
    EnumOrderBy,
    EnumInvoiceSortBy,
  ) callBack;

  final EnumInvoiceType selectedType;

  final EnumInvoiceSortBy selectedInvoiceSortBy;

  final EnumOrderBy selectedOrderBy;

  @override
  String toString() {
    return 'InvoiceSortPageRouteArgs{key: $key, callBack: $callBack, selectedType: $selectedType, selectedInvoiceSortBy: $selectedInvoiceSortBy, selectedOrderBy: $selectedOrderBy}';
  }
}

/// generated route for
/// [ItemList]
class ItemListRoute extends PageRouteInfo<void> {
  const ItemListRoute({List<PageRouteInfo>? children})
      : super(
          ItemListRoute.name,
          initialChildren: children,
        );

  static const String name = 'ItemListRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ItemSortPage]
class ItemSortPageRoute extends PageRouteInfo<ItemSortPageRouteArgs> {
  ItemSortPageRoute({
    Key? key,
    required dynamic Function(
      EnumItemType,
      EnumOrderBy,
      EnumItemSortBy,
    ) callBack,
    required EnumItemSortBy selectedItemSortBy,
    required EnumOrderBy selectedOrderBy,
    required EnumItemType selectedType,
    List<PageRouteInfo>? children,
  }) : super(
          ItemSortPageRoute.name,
          args: ItemSortPageRouteArgs(
            key: key,
            callBack: callBack,
            selectedItemSortBy: selectedItemSortBy,
            selectedOrderBy: selectedOrderBy,
            selectedType: selectedType,
          ),
          initialChildren: children,
        );

  static const String name = 'ItemSortPageRoute';

  static const PageInfo<ItemSortPageRouteArgs> page =
      PageInfo<ItemSortPageRouteArgs>(name);
}

class ItemSortPageRouteArgs {
  const ItemSortPageRouteArgs({
    this.key,
    required this.callBack,
    required this.selectedItemSortBy,
    required this.selectedOrderBy,
    required this.selectedType,
  });

  final Key? key;

  final dynamic Function(
    EnumItemType,
    EnumOrderBy,
    EnumItemSortBy,
  ) callBack;

  final EnumItemSortBy selectedItemSortBy;

  final EnumOrderBy selectedOrderBy;

  final EnumItemType selectedType;

  @override
  String toString() {
    return 'ItemSortPageRouteArgs{key: $key, callBack: $callBack, selectedItemSortBy: $selectedItemSortBy, selectedOrderBy: $selectedOrderBy, selectedType: $selectedType}';
  }
}

/// generated route for
/// [ItemsPopup]
class ItemsPopupRoute extends PageRouteInfo<ItemsPopupRouteArgs> {
  ItemsPopupRoute({
    Key? key,
    ItemListEntity? selectedItem,
    required dynamic Function(ItemListEntity?) onSelectedItem,
    List<ItemListEntity>? itemsListFromBaseClass,
    List<PageRouteInfo>? children,
  }) : super(
          ItemsPopupRoute.name,
          args: ItemsPopupRouteArgs(
            key: key,
            selectedItem: selectedItem,
            onSelectedItem: onSelectedItem,
            itemsListFromBaseClass: itemsListFromBaseClass,
          ),
          initialChildren: children,
        );

  static const String name = 'ItemsPopupRoute';

  static const PageInfo<ItemsPopupRouteArgs> page =
      PageInfo<ItemsPopupRouteArgs>(name);
}

class ItemsPopupRouteArgs {
  const ItemsPopupRouteArgs({
    this.key,
    this.selectedItem,
    required this.onSelectedItem,
    this.itemsListFromBaseClass,
  });

  final Key? key;

  final ItemListEntity? selectedItem;

  final dynamic Function(ItemListEntity?) onSelectedItem;

  final List<ItemListEntity>? itemsListFromBaseClass;

  @override
  String toString() {
    return 'ItemsPopupRouteArgs{key: $key, selectedItem: $selectedItem, onSelectedItem: $onSelectedItem, itemsListFromBaseClass: $itemsListFromBaseClass}';
  }
}

/// generated route for
/// [LayoutBuilderDemo]
class LayoutBuilderDemoRoute extends PageRouteInfo<void> {
  const LayoutBuilderDemoRoute({List<PageRouteInfo>? children})
      : super(
          LayoutBuilderDemoRoute.name,
          initialChildren: children,
        );

  static const String name = 'LayoutBuilderDemoRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [LineItemTotalSelectionPage]
class LineItemTotalSelectionPageRoute
    extends PageRouteInfo<LineItemTotalSelectionPageRouteArgs> {
  LineItemTotalSelectionPageRoute({
    Key? key,
    required ShippingDiscountModel shippingDiscountModel,
    required dynamic Function(ShippingDiscountModel) callBack,
    List<PageRouteInfo>? children,
  }) : super(
          LineItemTotalSelectionPageRoute.name,
          args: LineItemTotalSelectionPageRouteArgs(
            key: key,
            shippingDiscountModel: shippingDiscountModel,
            callBack: callBack,
          ),
          initialChildren: children,
        );

  static const String name = 'LineItemTotalSelectionPageRoute';

  static const PageInfo<LineItemTotalSelectionPageRouteArgs> page =
      PageInfo<LineItemTotalSelectionPageRouteArgs>(name);
}

class LineItemTotalSelectionPageRouteArgs {
  const LineItemTotalSelectionPageRouteArgs({
    this.key,
    required this.shippingDiscountModel,
    required this.callBack,
  });

  final Key? key;

  final ShippingDiscountModel shippingDiscountModel;

  final dynamic Function(ShippingDiscountModel) callBack;

  @override
  String toString() {
    return 'LineItemTotalSelectionPageRouteArgs{key: $key, shippingDiscountModel: $shippingDiscountModel, callBack: $callBack}';
  }
}

/// generated route for
/// [LoginPage]
class LoginPageRoute extends PageRouteInfo<void> {
  const LoginPageRoute({List<PageRouteInfo>? children})
      : super(
          LoginPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginPageRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [MorePage]
class MorePageRoute extends PageRouteInfo<MorePageRouteArgs> {
  MorePageRoute({
    Key? key,
    required AuthInfoMainDataEntity authInfoMainDataEntity,
    List<PageRouteInfo>? children,
  }) : super(
          MorePageRoute.name,
          args: MorePageRouteArgs(
            key: key,
            authInfoMainDataEntity: authInfoMainDataEntity,
          ),
          initialChildren: children,
        );

  static const String name = 'MorePageRoute';

  static const PageInfo<MorePageRouteArgs> page =
      PageInfo<MorePageRouteArgs>(name);
}

class MorePageRouteArgs {
  const MorePageRouteArgs({
    this.key,
    required this.authInfoMainDataEntity,
  });

  final Key? key;

  final AuthInfoMainDataEntity authInfoMainDataEntity;

  @override
  String toString() {
    return 'MorePageRouteArgs{key: $key, authInfoMainDataEntity: $authInfoMainDataEntity}';
  }
}

/// generated route for
/// [MoreReportsPage]
class MoreReportsPageRoute extends PageRouteInfo<void> {
  const MoreReportsPageRoute({List<PageRouteInfo>? children})
      : super(
          MoreReportsPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'MoreReportsPageRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [NewClientPage]
class NewClientPageRoute extends PageRouteInfo<NewClientPageRouteArgs> {
  NewClientPageRoute({
    Key? key,
    ClientEntity? clientEntity,
    dynamic Function()? refreshClient,
    required dynamic Function() clientRemoved,
    required dynamic Function()? onPopBack,
    List<PageRouteInfo>? children,
  }) : super(
          NewClientPageRoute.name,
          args: NewClientPageRouteArgs(
            key: key,
            clientEntity: clientEntity,
            refreshClient: refreshClient,
            clientRemoved: clientRemoved,
            onPopBack: onPopBack,
          ),
          initialChildren: children,
        );

  static const String name = 'NewClientPageRoute';

  static const PageInfo<NewClientPageRouteArgs> page =
      PageInfo<NewClientPageRouteArgs>(name);
}

class NewClientPageRouteArgs {
  const NewClientPageRouteArgs({
    this.key,
    this.clientEntity,
    this.refreshClient,
    required this.clientRemoved,
    required this.onPopBack,
  });

  final Key? key;

  final ClientEntity? clientEntity;

  final dynamic Function()? refreshClient;

  final dynamic Function() clientRemoved;

  final dynamic Function()? onPopBack;

  @override
  String toString() {
    return 'NewClientPageRouteArgs{key: $key, clientEntity: $clientEntity, refreshClient: $refreshClient, clientRemoved: $clientRemoved, onPopBack: $onPopBack}';
  }
}

/// generated route for
/// [NewExpenses]
class NewExpensesRoute extends PageRouteInfo<NewExpensesRouteArgs> {
  NewExpensesRoute({
    Key? key,
    required EnumExpenseScreenType expenseScreenType,
    dynamic Function()? refreshPage,
    ExpenseEntity? expenseEntity,
    List<PageRouteInfo>? children,
  }) : super(
          NewExpensesRoute.name,
          args: NewExpensesRouteArgs(
            key: key,
            expenseScreenType: expenseScreenType,
            refreshPage: refreshPage,
            expenseEntity: expenseEntity,
          ),
          initialChildren: children,
        );

  static const String name = 'NewExpensesRoute';

  static const PageInfo<NewExpensesRouteArgs> page =
      PageInfo<NewExpensesRouteArgs>(name);
}

class NewExpensesRouteArgs {
  const NewExpensesRouteArgs({
    this.key,
    required this.expenseScreenType,
    this.refreshPage,
    this.expenseEntity,
  });

  final Key? key;

  final EnumExpenseScreenType expenseScreenType;

  final dynamic Function()? refreshPage;

  final ExpenseEntity? expenseEntity;

  @override
  String toString() {
    return 'NewExpensesRouteArgs{key: $key, expenseScreenType: $expenseScreenType, refreshPage: $refreshPage, expenseEntity: $expenseEntity}';
  }
}

/// generated route for
/// [NewItemPage]
class NewItemPageRoute extends PageRouteInfo<NewItemPageRouteArgs> {
  NewItemPageRoute({
    Key? key,
    ItemListEntity? itemListEntity,
    dynamic Function()? refreshPage,
    required bool isFromDuplicate,
    required dynamic Function() popBack,
    List<PageRouteInfo>? children,
  }) : super(
          NewItemPageRoute.name,
          args: NewItemPageRouteArgs(
            key: key,
            itemListEntity: itemListEntity,
            refreshPage: refreshPage,
            isFromDuplicate: isFromDuplicate,
            popBack: popBack,
          ),
          initialChildren: children,
        );

  static const String name = 'NewItemPageRoute';

  static const PageInfo<NewItemPageRouteArgs> page =
      PageInfo<NewItemPageRouteArgs>(name);
}

class NewItemPageRouteArgs {
  const NewItemPageRouteArgs({
    this.key,
    this.itemListEntity,
    this.refreshPage,
    required this.isFromDuplicate,
    required this.popBack,
  });

  final Key? key;

  final ItemListEntity? itemListEntity;

  final dynamic Function()? refreshPage;

  final bool isFromDuplicate;

  final dynamic Function() popBack;

  @override
  String toString() {
    return 'NewItemPageRouteArgs{key: $key, itemListEntity: $itemListEntity, refreshPage: $refreshPage, isFromDuplicate: $isFromDuplicate, popBack: $popBack}';
  }
}

/// generated route for
/// [NotificationPage]
class NotificationPageRoute extends PageRouteInfo<void> {
  const NotificationPageRoute({List<PageRouteInfo>? children})
      : super(
          NotificationPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'NotificationPageRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [OnlinePaymentsPage]
class OnlinePaymentsPageRoute extends PageRouteInfo<void> {
  const OnlinePaymentsPageRoute({List<PageRouteInfo>? children})
      : super(
          OnlinePaymentsPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'OnlinePaymentsPageRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [OrganizationProfilePage]
class OrganizationProfilePageRoute extends PageRouteInfo<void> {
  const OrganizationProfilePageRoute({List<PageRouteInfo>? children})
      : super(
          OrganizationProfilePageRoute.name,
          initialChildren: children,
        );

  static const String name = 'OrganizationProfilePageRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [PaymentListPage]
class PaymentListPageRoute extends PageRouteInfo<PaymentListPageRouteArgs> {
  PaymentListPageRoute({
    Key? key,
    required dynamic Function() refreshPage,
    required List<PaymentEntity> payments,
    required String balanceAmount,
    required String invoiceId,
    required List<EmailtoMystaffEntity> emailList,
    List<PageRouteInfo>? children,
  }) : super(
          PaymentListPageRoute.name,
          args: PaymentListPageRouteArgs(
            key: key,
            refreshPage: refreshPage,
            payments: payments,
            balanceAmount: balanceAmount,
            invoiceId: invoiceId,
            emailList: emailList,
          ),
          initialChildren: children,
        );

  static const String name = 'PaymentListPageRoute';

  static const PageInfo<PaymentListPageRouteArgs> page =
      PageInfo<PaymentListPageRouteArgs>(name);
}

class PaymentListPageRouteArgs {
  const PaymentListPageRouteArgs({
    this.key,
    required this.refreshPage,
    required this.payments,
    required this.balanceAmount,
    required this.invoiceId,
    required this.emailList,
  });

  final Key? key;

  final dynamic Function() refreshPage;

  final List<PaymentEntity> payments;

  final String balanceAmount;

  final String invoiceId;

  final List<EmailtoMystaffEntity> emailList;

  @override
  String toString() {
    return 'PaymentListPageRouteArgs{key: $key, refreshPage: $refreshPage, payments: $payments, balanceAmount: $balanceAmount, invoiceId: $invoiceId, emailList: $emailList}';
  }
}

/// generated route for
/// [PaypalPage]
class PaypalPageRoute extends PageRouteInfo<PaypalPageRouteArgs> {
  PaypalPageRoute({
    Key? key,
    OnlinePaymentsEntity? onlinePaymentsEntity,
    required dynamic Function() refreshList,
    List<PageRouteInfo>? children,
  }) : super(
          PaypalPageRoute.name,
          args: PaypalPageRouteArgs(
            key: key,
            onlinePaymentsEntity: onlinePaymentsEntity,
            refreshList: refreshList,
          ),
          initialChildren: children,
        );

  static const String name = 'PaypalPageRoute';

  static const PageInfo<PaypalPageRouteArgs> page =
      PageInfo<PaypalPageRouteArgs>(name);
}

class PaypalPageRouteArgs {
  const PaypalPageRouteArgs({
    this.key,
    this.onlinePaymentsEntity,
    required this.refreshList,
  });

  final Key? key;

  final OnlinePaymentsEntity? onlinePaymentsEntity;

  final dynamic Function() refreshList;

  @override
  String toString() {
    return 'PaypalPageRouteArgs{key: $key, onlinePaymentsEntity: $onlinePaymentsEntity, refreshList: $refreshList}';
  }
}

/// generated route for
/// [PdfviewerPage]
class PdfviewerPageRoute extends PageRouteInfo<PdfviewerPageRouteArgs> {
  PdfviewerPageRoute({
    Key? key,
    required EnumDocumentType enumPageType,
    required String id,
    required bool isPrint,
    List<PageRouteInfo>? children,
  }) : super(
          PdfviewerPageRoute.name,
          args: PdfviewerPageRouteArgs(
            key: key,
            enumPageType: enumPageType,
            id: id,
            isPrint: isPrint,
          ),
          initialChildren: children,
        );

  static const String name = 'PdfviewerPageRoute';

  static const PageInfo<PdfviewerPageRouteArgs> page =
      PageInfo<PdfviewerPageRouteArgs>(name);
}

class PdfviewerPageRouteArgs {
  const PdfviewerPageRouteArgs({
    this.key,
    required this.enumPageType,
    required this.id,
    required this.isPrint,
  });

  final Key? key;

  final EnumDocumentType enumPageType;

  final String id;

  final bool isPrint;

  @override
  String toString() {
    return 'PdfviewerPageRouteArgs{key: $key, enumPageType: $enumPageType, id: $id, isPrint: $isPrint}';
  }
}

/// generated route for
/// [PlanExpiredPage]
class PlanExpiredPageRoute extends PageRouteInfo<PlanExpiredPageRouteArgs> {
  PlanExpiredPageRoute({
    Key? key,
    required String planName,
    List<PageRouteInfo>? children,
  }) : super(
          PlanExpiredPageRoute.name,
          args: PlanExpiredPageRouteArgs(
            key: key,
            planName: planName,
          ),
          initialChildren: children,
        );

  static const String name = 'PlanExpiredPageRoute';

  static const PageInfo<PlanExpiredPageRouteArgs> page =
      PageInfo<PlanExpiredPageRouteArgs>(name);
}

class PlanExpiredPageRouteArgs {
  const PlanExpiredPageRouteArgs({
    this.key,
    required this.planName,
  });

  final Key? key;

  final String planName;

  @override
  String toString() {
    return 'PlanExpiredPageRouteArgs{key: $key, planName: $planName}';
  }
}

/// generated route for
/// [PreferencesPage]
class PreferencesPageRoute extends PageRouteInfo<void> {
  const PreferencesPageRoute({List<PageRouteInfo>? children})
      : super(
          PreferencesPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'PreferencesPageRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ProjectDetailPage]
class ProjectDetailPageRoute extends PageRouteInfo<ProjectDetailPageRouteArgs> {
  ProjectDetailPageRoute({
    Key? key,
    required ProjectEntity projectEntity,
    required dynamic Function() refreshPage,
    List<PageRouteInfo>? children,
  }) : super(
          ProjectDetailPageRoute.name,
          args: ProjectDetailPageRouteArgs(
            key: key,
            projectEntity: projectEntity,
            refreshPage: refreshPage,
          ),
          initialChildren: children,
        );

  static const String name = 'ProjectDetailPageRoute';

  static const PageInfo<ProjectDetailPageRouteArgs> page =
      PageInfo<ProjectDetailPageRouteArgs>(name);
}

class ProjectDetailPageRouteArgs {
  const ProjectDetailPageRouteArgs({
    this.key,
    required this.projectEntity,
    required this.refreshPage,
  });

  final Key? key;

  final ProjectEntity projectEntity;

  final dynamic Function() refreshPage;

  @override
  String toString() {
    return 'ProjectDetailPageRouteArgs{key: $key, projectEntity: $projectEntity, refreshPage: $refreshPage}';
  }
}

/// generated route for
/// [ProjectListPage]
class ProjectListPageRoute extends PageRouteInfo<ProjectListPageRouteArgs> {
  ProjectListPageRoute({
    Key? key,
    bool isFromMore = true,
    List<PageRouteInfo>? children,
  }) : super(
          ProjectListPageRoute.name,
          args: ProjectListPageRouteArgs(
            key: key,
            isFromMore: isFromMore,
          ),
          initialChildren: children,
        );

  static const String name = 'ProjectListPageRoute';

  static const PageInfo<ProjectListPageRouteArgs> page =
      PageInfo<ProjectListPageRouteArgs>(name);
}

class ProjectListPageRouteArgs {
  const ProjectListPageRouteArgs({
    this.key,
    this.isFromMore = true,
  });

  final Key? key;

  final bool isFromMore;

  @override
  String toString() {
    return 'ProjectListPageRouteArgs{key: $key, isFromMore: $isFromMore}';
  }
}

/// generated route for
/// [ProjectPopup]
class ProjectPopupRoute extends PageRouteInfo<ProjectPopupRouteArgs> {
  ProjectPopupRoute({
    Key? key,
    dynamic Function(ProjectEntity?)? onSelectProject,
    ProjectEntity? selectedProject,
    String? clientId,
    ClientEntity? selectedClient,
    List<PageRouteInfo>? children,
  }) : super(
          ProjectPopupRoute.name,
          args: ProjectPopupRouteArgs(
            key: key,
            onSelectProject: onSelectProject,
            selectedProject: selectedProject,
            clientId: clientId,
            selectedClient: selectedClient,
          ),
          initialChildren: children,
        );

  static const String name = 'ProjectPopupRoute';

  static const PageInfo<ProjectPopupRouteArgs> page =
      PageInfo<ProjectPopupRouteArgs>(name);
}

class ProjectPopupRouteArgs {
  const ProjectPopupRouteArgs({
    this.key,
    this.onSelectProject,
    this.selectedProject,
    this.clientId,
    this.selectedClient,
  });

  final Key? key;

  final dynamic Function(ProjectEntity?)? onSelectProject;

  final ProjectEntity? selectedProject;

  final String? clientId;

  final ClientEntity? selectedClient;

  @override
  String toString() {
    return 'ProjectPopupRouteArgs{key: $key, onSelectProject: $onSelectProject, selectedProject: $selectedProject, clientId: $clientId, selectedClient: $selectedClient}';
  }
}

/// generated route for
/// [ProjectSortPage]
class ProjectSortPageRoute extends PageRouteInfo<ProjectSortPageRouteArgs> {
  ProjectSortPageRoute({
    Key? key,
    required dynamic Function(
      EnumProjectType,
      EnumOrderBy,
      EnumProjectSortBy,
    ) callBack,
    required EnumOrderBy selectedOrderBy,
    required EnumProjectSortBy selectedProjectSortBy,
    required EnumProjectType selectedType,
    List<PageRouteInfo>? children,
  }) : super(
          ProjectSortPageRoute.name,
          args: ProjectSortPageRouteArgs(
            key: key,
            callBack: callBack,
            selectedOrderBy: selectedOrderBy,
            selectedProjectSortBy: selectedProjectSortBy,
            selectedType: selectedType,
          ),
          initialChildren: children,
        );

  static const String name = 'ProjectSortPageRoute';

  static const PageInfo<ProjectSortPageRouteArgs> page =
      PageInfo<ProjectSortPageRouteArgs>(name);
}

class ProjectSortPageRouteArgs {
  const ProjectSortPageRouteArgs({
    this.key,
    required this.callBack,
    required this.selectedOrderBy,
    required this.selectedProjectSortBy,
    required this.selectedType,
  });

  final Key? key;

  final dynamic Function(
    EnumProjectType,
    EnumOrderBy,
    EnumProjectSortBy,
  ) callBack;

  final EnumOrderBy selectedOrderBy;

  final EnumProjectSortBy selectedProjectSortBy;

  final EnumProjectType selectedType;

  @override
  String toString() {
    return 'ProjectSortPageRouteArgs{key: $key, callBack: $callBack, selectedOrderBy: $selectedOrderBy, selectedProjectSortBy: $selectedProjectSortBy, selectedType: $selectedType}';
  }
}

/// generated route for
/// [ReportCollectionsPage]
class ReportCollectionsPageRoute extends PageRouteInfo<void> {
  const ReportCollectionsPageRoute({List<PageRouteInfo>? children})
      : super(
          ReportCollectionsPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'ReportCollectionsPageRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ReportExpensesPage]
class ReportExpensesPageRoute extends PageRouteInfo<void> {
  const ReportExpensesPageRoute({List<PageRouteInfo>? children})
      : super(
          ReportExpensesPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'ReportExpensesPageRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ReportInvoicePage]
class ReportInvoicePageRoute extends PageRouteInfo<void> {
  const ReportInvoicePageRoute({List<PageRouteInfo>? children})
      : super(
          ReportInvoicePageRoute.name,
          initialChildren: children,
        );

  static const String name = 'ReportInvoicePageRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ReportItemSalesPage]
class ReportItemSalesPageRoute extends PageRouteInfo<void> {
  const ReportItemSalesPageRoute({List<PageRouteInfo>? children})
      : super(
          ReportItemSalesPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'ReportItemSalesPageRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ReportOutstandingsPage]
class ReportOutstandingsPageRoute extends PageRouteInfo<void> {
  const ReportOutstandingsPageRoute({List<PageRouteInfo>? children})
      : super(
          ReportOutstandingsPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'ReportOutstandingsPageRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ReportProfitAndLossPage]
class ReportProfitAndLossPageRoute extends PageRouteInfo<void> {
  const ReportProfitAndLossPageRoute({List<PageRouteInfo>? children})
      : super(
          ReportProfitAndLossPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'ReportProfitAndLossPageRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ReportSalesTaxPage]
class ReportSalesTaxPageRoute extends PageRouteInfo<void> {
  const ReportSalesTaxPageRoute({List<PageRouteInfo>? children})
      : super(
          ReportSalesTaxPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'ReportSalesTaxPageRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SendInvoiceEstimatePage]
class SendInvoiceEstimatePageRoute
    extends PageRouteInfo<SendInvoiceEstimatePageRouteArgs> {
  SendInvoiceEstimatePageRoute({
    Key? key,
    required GetDocumentUsecaseReqParams params,
    List<PageRouteInfo>? children,
  }) : super(
          SendInvoiceEstimatePageRoute.name,
          args: SendInvoiceEstimatePageRouteArgs(
            key: key,
            params: params,
          ),
          initialChildren: children,
        );

  static const String name = 'SendInvoiceEstimatePageRoute';

  static const PageInfo<SendInvoiceEstimatePageRouteArgs> page =
      PageInfo<SendInvoiceEstimatePageRouteArgs>(name);
}

class SendInvoiceEstimatePageRouteArgs {
  const SendInvoiceEstimatePageRouteArgs({
    this.key,
    required this.params,
  });

  final Key? key;

  final GetDocumentUsecaseReqParams params;

  @override
  String toString() {
    return 'SendInvoiceEstimatePageRouteArgs{key: $key, params: $params}';
  }
}

/// generated route for
/// [SendtoBccPage]
class SendtoBccPageRoute extends PageRouteInfo<SendtoBccPageRouteArgs> {
  SendtoBccPageRoute({
    Key? key,
    required dynamic Function(List<ContactEntity>) onpressDone,
    required List<ContactEntity> list,
    required List<ContactEntity> selectedList,
    List<PageRouteInfo>? children,
  }) : super(
          SendtoBccPageRoute.name,
          args: SendtoBccPageRouteArgs(
            key: key,
            onpressDone: onpressDone,
            list: list,
            selectedList: selectedList,
          ),
          initialChildren: children,
        );

  static const String name = 'SendtoBccPageRoute';

  static const PageInfo<SendtoBccPageRouteArgs> page =
      PageInfo<SendtoBccPageRouteArgs>(name);
}

class SendtoBccPageRouteArgs {
  const SendtoBccPageRouteArgs({
    this.key,
    required this.onpressDone,
    required this.list,
    required this.selectedList,
  });

  final Key? key;

  final dynamic Function(List<ContactEntity>) onpressDone;

  final List<ContactEntity> list;

  final List<ContactEntity> selectedList;

  @override
  String toString() {
    return 'SendtoBccPageRouteArgs{key: $key, onpressDone: $onpressDone, list: $list, selectedList: $selectedList}';
  }
}

/// generated route for
/// [SettingTemplatePage]
class SettingTemplatePageRoute
    extends PageRouteInfo<SettingTemplatePageRouteArgs> {
  SettingTemplatePageRoute({
    Key? key,
    required EnumSettingTemplateType enumSettingTemplateType,
    List<PageRouteInfo>? children,
  }) : super(
          SettingTemplatePageRoute.name,
          args: SettingTemplatePageRouteArgs(
            key: key,
            enumSettingTemplateType: enumSettingTemplateType,
          ),
          initialChildren: children,
        );

  static const String name = 'SettingTemplatePageRoute';

  static const PageInfo<SettingTemplatePageRouteArgs> page =
      PageInfo<SettingTemplatePageRouteArgs>(name);
}

class SettingTemplatePageRouteArgs {
  const SettingTemplatePageRouteArgs({
    this.key,
    required this.enumSettingTemplateType,
  });

  final Key? key;

  final EnumSettingTemplateType enumSettingTemplateType;

  @override
  String toString() {
    return 'SettingTemplatePageRouteArgs{key: $key, enumSettingTemplateType: $enumSettingTemplateType}';
  }
}

/// generated route for
/// [SettingsPage]
class SettingsPageRoute extends PageRouteInfo<SettingsPageRouteArgs> {
  SettingsPageRoute({
    Key? key,
    required AuthInfoMainDataEntity authInfoMainDataEntity,
    List<PageRouteInfo>? children,
  }) : super(
          SettingsPageRoute.name,
          args: SettingsPageRouteArgs(
            key: key,
            authInfoMainDataEntity: authInfoMainDataEntity,
          ),
          initialChildren: children,
        );

  static const String name = 'SettingsPageRoute';

  static const PageInfo<SettingsPageRouteArgs> page =
      PageInfo<SettingsPageRouteArgs>(name);
}

class SettingsPageRouteArgs {
  const SettingsPageRouteArgs({
    this.key,
    required this.authInfoMainDataEntity,
  });

  final Key? key;

  final AuthInfoMainDataEntity authInfoMainDataEntity;

  @override
  String toString() {
    return 'SettingsPageRouteArgs{key: $key, authInfoMainDataEntity: $authInfoMainDataEntity}';
  }
}

/// generated route for
/// [ShippingAddressPage]
class ShippingAddressPageRoute
    extends PageRouteInfo<ShippingAddressPageRouteArgs> {
  ShippingAddressPageRoute({
    Key? key,
    ClientAddAddress? billingAddress,
    ClientAddAddress? shippingAddress,
    required dynamic Function(ClientAddAddress) callBack,
    List<PageRouteInfo>? children,
  }) : super(
          ShippingAddressPageRoute.name,
          args: ShippingAddressPageRouteArgs(
            key: key,
            billingAddress: billingAddress,
            shippingAddress: shippingAddress,
            callBack: callBack,
          ),
          initialChildren: children,
        );

  static const String name = 'ShippingAddressPageRoute';

  static const PageInfo<ShippingAddressPageRouteArgs> page =
      PageInfo<ShippingAddressPageRouteArgs>(name);
}

class ShippingAddressPageRouteArgs {
  const ShippingAddressPageRouteArgs({
    this.key,
    this.billingAddress,
    this.shippingAddress,
    required this.callBack,
  });

  final Key? key;

  final ClientAddAddress? billingAddress;

  final ClientAddAddress? shippingAddress;

  final dynamic Function(ClientAddAddress) callBack;

  @override
  String toString() {
    return 'ShippingAddressPageRouteArgs{key: $key, billingAddress: $billingAddress, shippingAddress: $shippingAddress, callBack: $callBack}';
  }
}

/// generated route for
/// [SignUpPage]
class SignUpPageRoute extends PageRouteInfo<void> {
  const SignUpPageRoute({List<PageRouteInfo>? children})
      : super(
          SignUpPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignUpPageRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SplashPage]
class SplashPageRoute extends PageRouteInfo<void> {
  const SplashPageRoute({List<PageRouteInfo>? children})
      : super(
          SplashPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashPageRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [StripePage]
class StripePageRoute extends PageRouteInfo<StripePageRouteArgs> {
  StripePageRoute({
    Key? key,
    OnlinePaymentsEntity? onlinePaymentsEntity,
    required dynamic Function() refreshList,
    List<PageRouteInfo>? children,
  }) : super(
          StripePageRoute.name,
          args: StripePageRouteArgs(
            key: key,
            onlinePaymentsEntity: onlinePaymentsEntity,
            refreshList: refreshList,
          ),
          initialChildren: children,
        );

  static const String name = 'StripePageRoute';

  static const PageInfo<StripePageRouteArgs> page =
      PageInfo<StripePageRouteArgs>(name);
}

class StripePageRouteArgs {
  const StripePageRouteArgs({
    this.key,
    this.onlinePaymentsEntity,
    required this.refreshList,
  });

  final Key? key;

  final OnlinePaymentsEntity? onlinePaymentsEntity;

  final dynamic Function() refreshList;

  @override
  String toString() {
    return 'StripePageRouteArgs{key: $key, onlinePaymentsEntity: $onlinePaymentsEntity, refreshList: $refreshList}';
  }
}

/// generated route for
/// [TaxesListPage]
class TaxesListPageRoute extends PageRouteInfo<void> {
  const TaxesListPageRoute({List<PageRouteInfo>? children})
      : super(
          TaxesListPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'TaxesListPageRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [TermsConditionPage]
class TermsConditionPageRoute extends PageRouteInfo<void> {
  const TermsConditionPageRoute({List<PageRouteInfo>? children})
      : super(
          TermsConditionPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'TermsConditionPageRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [UpdateEmailTemplatePage]
class UpdateEmailTemplatePageRoute
    extends PageRouteInfo<UpdateEmailTemplatePageRouteArgs> {
  UpdateEmailTemplatePageRoute({
    Key? key,
    required String title,
    required String message,
    required String subject,
    required EnumEmailTemplate type,
    required void Function()? refreshPage,
    List<PageRouteInfo>? children,
  }) : super(
          UpdateEmailTemplatePageRoute.name,
          args: UpdateEmailTemplatePageRouteArgs(
            key: key,
            title: title,
            message: message,
            subject: subject,
            type: type,
            refreshPage: refreshPage,
          ),
          initialChildren: children,
        );

  static const String name = 'UpdateEmailTemplatePageRoute';

  static const PageInfo<UpdateEmailTemplatePageRouteArgs> page =
      PageInfo<UpdateEmailTemplatePageRouteArgs>(name);
}

class UpdateEmailTemplatePageRouteArgs {
  const UpdateEmailTemplatePageRouteArgs({
    this.key,
    required this.title,
    required this.message,
    required this.subject,
    required this.type,
    required this.refreshPage,
  });

  final Key? key;

  final String title;

  final String message;

  final String subject;

  final EnumEmailTemplate type;

  final void Function()? refreshPage;

  @override
  String toString() {
    return 'UpdateEmailTemplatePageRouteArgs{key: $key, title: $title, message: $message, subject: $subject, type: $type, refreshPage: $refreshPage}';
  }
}

/// generated route for
/// [UpdateUserProfilePage]
class UpdateUserProfilePageRoute
    extends PageRouteInfo<UpdateUserProfilePageRouteArgs> {
  UpdateUserProfilePageRoute({
    Key? key,
    required AuthInfoMainDataEntity? authInfoMainDataEntity,
    List<PageRouteInfo>? children,
  }) : super(
          UpdateUserProfilePageRoute.name,
          args: UpdateUserProfilePageRouteArgs(
            key: key,
            authInfoMainDataEntity: authInfoMainDataEntity,
          ),
          initialChildren: children,
        );

  static const String name = 'UpdateUserProfilePageRoute';

  static const PageInfo<UpdateUserProfilePageRouteArgs> page =
      PageInfo<UpdateUserProfilePageRouteArgs>(name);
}

class UpdateUserProfilePageRouteArgs {
  const UpdateUserProfilePageRouteArgs({
    this.key,
    required this.authInfoMainDataEntity,
  });

  final Key? key;

  final AuthInfoMainDataEntity? authInfoMainDataEntity;

  @override
  String toString() {
    return 'UpdateUserProfilePageRouteArgs{key: $key, authInfoMainDataEntity: $authInfoMainDataEntity}';
  }
}

/// generated route for
/// [UserColumnSettingsPage]
class UserColumnSettingsPageRoute
    extends PageRouteInfo<UserColumnSettingsPageRouteArgs> {
  UserColumnSettingsPageRoute({
    Key? key,
    required dynamic Function(UpdatePreferenceColumnReqParams)
        onupdateColumnSettings,
    required UpdatePreferenceColumnReqParams? updatePreferenceColumnReqParams,
    List<PageRouteInfo>? children,
  }) : super(
          UserColumnSettingsPageRoute.name,
          args: UserColumnSettingsPageRouteArgs(
            key: key,
            onupdateColumnSettings: onupdateColumnSettings,
            updatePreferenceColumnReqParams: updatePreferenceColumnReqParams,
          ),
          initialChildren: children,
        );

  static const String name = 'UserColumnSettingsPageRoute';

  static const PageInfo<UserColumnSettingsPageRouteArgs> page =
      PageInfo<UserColumnSettingsPageRouteArgs>(name);
}

class UserColumnSettingsPageRouteArgs {
  const UserColumnSettingsPageRouteArgs({
    this.key,
    required this.onupdateColumnSettings,
    required this.updatePreferenceColumnReqParams,
  });

  final Key? key;

  final dynamic Function(UpdatePreferenceColumnReqParams)
      onupdateColumnSettings;

  final UpdatePreferenceColumnReqParams? updatePreferenceColumnReqParams;

  @override
  String toString() {
    return 'UserColumnSettingsPageRouteArgs{key: $key, onupdateColumnSettings: $onupdateColumnSettings, updatePreferenceColumnReqParams: $updatePreferenceColumnReqParams}';
  }
}

/// generated route for
/// [UserProfilePage]
class UserProfilePageRoute extends PageRouteInfo<UserProfilePageRouteArgs> {
  UserProfilePageRoute({
    Key? key,
    required AuthInfoMainDataEntity? authInfoMainDataEntity,
    required dynamic Function() refresh,
    required dynamic Function(AuthInfoMainDataEntity?) updateAuthInfo,
    List<PageRouteInfo>? children,
  }) : super(
          UserProfilePageRoute.name,
          args: UserProfilePageRouteArgs(
            key: key,
            authInfoMainDataEntity: authInfoMainDataEntity,
            refresh: refresh,
            updateAuthInfo: updateAuthInfo,
          ),
          initialChildren: children,
        );

  static const String name = 'UserProfilePageRoute';

  static const PageInfo<UserProfilePageRouteArgs> page =
      PageInfo<UserProfilePageRouteArgs>(name);
}

class UserProfilePageRouteArgs {
  const UserProfilePageRouteArgs({
    this.key,
    required this.authInfoMainDataEntity,
    required this.refresh,
    required this.updateAuthInfo,
  });

  final Key? key;

  final AuthInfoMainDataEntity? authInfoMainDataEntity;

  final dynamic Function() refresh;

  final dynamic Function(AuthInfoMainDataEntity?) updateAuthInfo;

  @override
  String toString() {
    return 'UserProfilePageRouteArgs{key: $key, authInfoMainDataEntity: $authInfoMainDataEntity, refresh: $refresh, updateAuthInfo: $updateAuthInfo}';
  }
}

/// generated route for
/// [UsersListPage]
class UsersListPageRoute extends PageRouteInfo<void> {
  const UsersListPageRoute({List<PageRouteInfo>? children})
      : super(
          UsersListPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'UsersListPageRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
