import 'package:auto_route/auto_route.dart';
import 'package:billbooks_app/features/line%20item/presentation/add_new_line_item_page.dart';
import 'package:billbooks_app/features/more/reports/presentation/report_item_sales_page.dart';
import 'package:billbooks_app/features/splash/splash_page.dart';
import 'package:flutter/material.dart';

import '../core/widgets/plan_expired_page.dart';
import '../core/widgets/terms_condition_page.dart';
import '../features/auth/presentation/pages/forgot_password_page.dart';
import '../features/auth/presentation/pages/login_page.dart';
import '../features/auth/presentation/pages/signup_page.dart';
import '../features/categories/domain/entities/category_main_res_entity.dart';
import '../features/categories/presentation/screens/category_list_page.dart';
import '../features/clients/domain/entities/client_list_entity.dart';
import '../features/clients/presentation/Models/client_add_address.dart';
import '../features/clients/presentation/Models/client_person_model.dart';
import '../features/clients/presentation/add_person_page.dart';
import '../features/clients/presentation/billing_address_page.dart';
import '../features/clients/presentation/client_details_page.dart';
import '../features/clients/presentation/client_list_page.dart';
import '../features/clients/presentation/client_sort_page.dart';
import '../features/clients/presentation/layout_builder_demo.dart';
import '../features/clients/presentation/newclient_page.dart';
import '../features/clients/presentation/shipping_address_page.dart';
import '../features/creditnotes/presentation/credit_notes_list_page.dart';
import '../features/dashboard/domain/entity/authinfo_entity.dart';
import '../features/email templates/presentation/email_template_page.dart';
import '../features/email templates/presentation/update_email_template_page.dart';
import '../features/estimate/presentation/estimate_list_page.dart';
import '../features/estimate/presentation/estimate_sort_page.dart';
import '../features/estimate/presentation/widgets/estimate_add_info_details.dart';
import '../features/general.dart';
import '../features/integrations/domain/entity/online_payment_details_entity.dart';
import '../features/integrations/presentation/authorize_page.dart';
import '../features/integrations/presentation/braintree_page.dart';
import '../features/integrations/presentation/checkout_page.dart';
import '../features/integrations/presentation/online_payments_page.dart';
import '../features/integrations/presentation/paypal_page.dart';
import '../features/integrations/presentation/stripe_page.dart';
import '../features/invoice/domain/entities/get_document_entity.dart';
import '../features/invoice/domain/entities/invoice_details_entity.dart';
import '../features/invoice/domain/entities/invoice_list_entity.dart';
import '../features/invoice/domain/usecase/get_document_usecase.dart';
import '../features/invoice/presentation/add_new_invoice_page.dart';
import '../features/invoice/presentation/add_payment_page.dart';
import '../features/invoice/presentation/email_to_page.dart';
import '../features/invoice/presentation/invoice_detail_page.dart';
import '../features/invoice/presentation/invoice_estimate_terms_inout_page.dart';
import '../features/invoice/presentation/invoice_list_page.dart';
import '../features/invoice/presentation/invoice_sort_page.dart';
import '../features/invoice/presentation/line_item_total_selection.dart';
import '../features/invoice/presentation/payment_list_page.dart';
import '../features/invoice/presentation/send_invoice_estimate_page.dart';
import '../features/invoice/presentation/sendto_bcc_page.dart';
import '../features/invoice/presentation/widgets/invoice_add_basic_details_widget.dart';
import '../features/invoice/presentation/widgets/invoice_history_list.dart';
import '../features/item/domain/entities/item_list_entity.dart';
import '../features/item/presentation/item_list.dart';
import '../features/item/presentation/item_sort_page.dart';
import '../features/item/presentation/new_item_page.dart';
import '../features/more/expenses/domain/entities/expenses_list_entity.dart';
import '../features/more/expenses/presentation/widgets/categories.dart';
import '../features/more/expenses/presentation/widgets/expenses_list_page.dart';
import '../features/more/expenses/presentation/widgets/expenses_sort_page.dart';
import '../features/more/expenses/presentation/widgets/new_expenses.dart';
import '../features/more/more_page.dart';
import '../features/more/reports/presentation/repors_profit_loss_page.dart';
import '../features/more/reports/presentation/report_collection_page.dart';
import '../features/more/reports/presentation/report_expenses_page.dart';
import '../features/more/reports/presentation/report_invoice_page.dart';
import '../features/more/reports/presentation/report_sales_tax_page.dart';
import '../features/more/reports/presentation/reports_outstanding_page.dart';
import '../features/more/reports/presentation/reports_page.dart';
import '../features/more/settings/domain/entity/preference_details_entity.dart';
import '../features/more/settings/domain/usecase/update_preference_column_usecase.dart';
import '../features/more/settings/presentation/column_settings_page.dart';
import '../features/more/settings/presentation/organization_profile_page.dart';
import '../features/more/settings/presentation/preferences_page.dart';
import '../features/more/settings/presentation/setting_template_page.dart';
import '../features/more/settings/settings_page.dart';
import '../features/notifications/presentation/notification_page.dart';
import '../features/pdfviewer/presentation/pdfviewer_page.dart';
import '../features/popups/client_popup.dart';
import '../features/popups/items_popup.dart';
import '../features/popups/project_popup.dart';
import '../features/profile/presentation/update_user_profile_page.dart';
import '../features/profile/presentation/user_profile_page.dart';
import '../features/project/domain/entity/project_list_entity.dart';
import '../features/project/presentation/add_project_page.dart';
import '../features/project/presentation/project_detail_page.dart';
import '../features/project/presentation/project_list_page.dart';
import '../features/project/presentation/project_sort_page.dart';
import '../features/taxes/presentation/add_tax_page.dart';
import '../features/taxes/presentation/taxes_list_page.dart';
import '../features/users/presentation/users_list_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        //AutoRoute(page: LayoutBuilderR.page, path: "/", initial: true),

        AutoRoute(page: SplashPageRoute.page, path: "/", initial: true),
        AutoRoute(page: ForgotPasswordPageRoute.page),
        AutoRoute(page: SignUpPageRoute.page),
        AutoRoute(page: SettingTemplatePageRoute.page, fullscreenDialog: true),
        AutoRoute(page: PlanExpiredPageRoute.page, fullscreenDialog: true),
        AutoRoute(page: NotificationPageRoute.page, fullscreenDialog: true),
        AutoRoute(
          page: CreditNotesListPageRoute.page,
        ),
        AutoRoute(
            page: InvoiceEstimateTermsInoutPageRoute.page,
            fullscreenDialog: true),
        AutoRoute(page: GeneralRoute.page),
        AutoRoute(page: LoginPageRoute.page),
        AutoRoute(page: PdfviewerPageRoute.page, fullscreenDialog: true),
        // HomeScreen is generated as HomeRoute because
        // of the replaceInRouteName property
        AutoRoute(page: PaymentListPageRoute.page, fullscreenDialog: true),
        AutoRoute(page: AddPaymentPageRoute.page, fullscreenDialog: true),
        AutoRoute(page: SendtoBccPageRoute.page, fullscreenDialog: true),
        AutoRoute(
            page: SendInvoiceEstimatePageRoute.page, fullscreenDialog: true),
        AutoRoute(page: InvoiceHistoryListRoute.page, fullscreenDialog: true),
        AutoRoute(
            page: LineItemTotalSelectionPageRoute.page, fullscreenDialog: true),
        AutoRoute(page: EstimateAddInfoDetailsRoute.page),
        AutoRoute(page: InvoiceDetailPageRoute.page),
        AutoRoute(
            page: InvoiceAddBasicDetailsWidgetRoute.page,
            fullscreenDialog: true),
        AutoRoute(page: TermsConditionPageRoute.page, fullscreenDialog: true),
        AutoRoute(page: AddNewLineItemPageRoute.page, fullscreenDialog: true),
        AutoRoute(page: ItemsPopupRoute.page, fullscreenDialog: true),
        AutoRoute(page: EmailToPageRoute.page, fullscreenDialog: true),
        AutoRoute(
            page: AddNewInvoiceEstimatePageRoute.page, fullscreenDialog: true),
        AutoRoute(page: ProjectPopupRoute.page, fullscreenDialog: true),
        AutoRoute(page: ClientPopupRoute.page, fullscreenDialog: true),
        AutoRoute(page: CategoryListPageRoute.page, fullscreenDialog: true),
        AutoRoute(page: BillingAddressPageRoute.page),
        AutoRoute(page: ShippingAddressPageRoute.page),
        AutoRoute(
            page: UpdateUserProfilePageRoute.page, fullscreenDialog: true),
        AutoRoute(page: UserProfilePageRoute.page, fullscreenDialog: true),
        AutoRoute(page: NewItemPageRoute.page, fullscreenDialog: true),
        AutoRoute(
            page: UserColumnSettingsPageRoute.page, fullscreenDialog: true),
        AutoRoute(
            page: UpdateEmailTemplatePageRoute.page, fullscreenDialog: true),
        AutoRoute(page: EmailTemplatePageRoute.page, fullscreenDialog: true),
        AutoRoute(page: CheckoutPageRoute.page, fullscreenDialog: true),
        AutoRoute(page: PaypalPageRoute.page, fullscreenDialog: true),
        AutoRoute(page: AuthorizePageRoute.page, fullscreenDialog: true),
        AutoRoute(page: BraintreePageRoute.page, fullscreenDialog: true),
        AutoRoute(page: StripePageRoute.page, fullscreenDialog: true),

        AutoRoute(page: OnlinePaymentsPageRoute.page, fullscreenDialog: true),
        AutoRoute(page: AddTaxPageRoute.page, fullscreenDialog: true),
        AutoRoute(page: TaxesListPageRoute.page, fullscreenDialog: true),
        AutoRoute(page: UsersListPageRoute.page, fullscreenDialog: true),
        AutoRoute(
            page: ReportProfitAndLossPageRoute.page, fullscreenDialog: true),
        AutoRoute(
            page: ReportCollectionsPageRoute.page, fullscreenDialog: true),
        AutoRoute(page: ReportExpensesPageRoute.page, fullscreenDialog: true),
        AutoRoute(page: ReportItemSalesPageRoute.page, fullscreenDialog: true),
        AutoRoute(page: ReportSalesTaxPageRoute.page, fullscreenDialog: true),
        AutoRoute(
            page: ReportOutstandingsPageRoute.page, fullscreenDialog: true),

        AutoRoute(page: ReportInvoicePageRoute.page, fullscreenDialog: true),

        AutoRoute(page: ProjectSortPageRoute.page, fullscreenDialog: true),
        AutoRoute(page: AddProjectPageRoute.page, fullscreenDialog: true),
        AutoRoute(page: ProjectListPageRoute.page),
        AutoRoute(page: MoreReportsPageRoute.page),
        AutoRoute(page: ItemSortPageRoute.page, fullscreenDialog: true),
        AutoRoute(page: ItemListRoute.page),
        AutoRoute(page: EstimateSortPageRoute.page, fullscreenDialog: true),
        AutoRoute(page: InvoiceSortPageRoute.page, fullscreenDialog: true),
        AutoRoute(page: ExpensesListPageRoute.page),
        AutoRoute(page: ExpensesSortPageRoute.page, fullscreenDialog: true),
        AutoRoute(page: NewExpensesRoute.page, fullscreenDialog: true),
        AutoRoute(page: AddPersonPageRoute.page, fullscreenDialog: true),
        AutoRoute(page: ClientSortPageRoute.page, fullscreenDialog: true),
        AutoRoute(page: NewClientPageRoute.page, fullscreenDialog: true),
        AutoRoute(page: ClientListPageRoute.page),
        AutoRoute(page: ClientDetailPageRoute.page),
        AutoRoute(page: SettingsPageRoute.page),
        AutoRoute(page: ProjectDetailPageRoute.page),
        AutoRoute(
            page: OrganizationProfilePageRoute.page, fullscreenDialog: true),
        AutoRoute(page: PreferencesPageRoute.page),
      ];
}
