import 'package:auto_route/auto_route.dart';
import 'package:billbooks_app/core/app_constants.dart';
import 'package:billbooks_app/core/constants/revenuecat_config.dart';
import 'package:billbooks_app/core/theme/app_fonts.dart';
import 'package:billbooks_app/core/theme/app_pallete.dart';
import 'package:billbooks_app/core/utils/show_toast.dart';
import 'package:billbooks_app/core/widgets/loading_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:toastification/toastification.dart';
import 'package:url_launcher/url_launcher.dart';

import 'bloc/revenuecat_cubit.dart';
import 'bloc/revenuecat_state.dart';
import 'bloc/subscription_bloc.dart';
import '../domain/entity/revenuecat_entity.dart';
import '../domain/entity/subscription_entity.dart';
import '../domain/usecase/subscription_usecase.dart';

enum SubscriptionBillingCycle { monthly, yearly }

@RoutePage()
class SubscriptionPage extends StatefulWidget {
  const SubscriptionPage({super.key});

  @override
  State<SubscriptionPage> createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  SubscriptionBillingCycle selectedCycle = SubscriptionBillingCycle.monthly;

  @override
  void initState() {
    _getSubscription();
    _initializeRevenueCat();
    super.initState();
  }

  void _getSubscription() {
    context
        .read<SubscriptionBloc>()
        .add(GetSubscriptionEvent(params: SubscriptionReqParams()));
  }

  void _initializeRevenueCat() {
    context.read<RevenueCatCubit>().initialize();
  }

  Future<void> _refreshPage() async {
    _getSubscription();
    await context.read<RevenueCatCubit>().refresh();
  }

  Future<void> _handlePlanPurchase(
    SubscriptionPlanEntity plan,
    RevenueCatState revenueCatState,
  ) async {
    if (plan.isActive ?? false) {
      return;
    }

    if (!revenueCatState.isSupportedPlatform || !revenueCatState.isConfigured) {
      await _openWebBilling();
      return;
    }

    await context.read<RevenueCatCubit>().purchasePlan(
          planName: plan.name ?? '',
          cycle: selectedCycle == SubscriptionBillingCycle.yearly
              ? RevenueCatBillingCycle.yearly
              : RevenueCatBillingCycle.monthly,
        );
  }

  Future<void> _openWebBilling() async {
    final uri = Uri.parse(RevenueCatConfig.webBillingUrl);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      if (!mounted) {
        return;
      }
      showToastification(
        context,
        'Unable to open the subscription page.',
        ToastificationType.error,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final revenueCatState = context.watch<RevenueCatCubit>().state;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Subscriptions'),
        bottom: AppConstants.getAppBarDivider,
      ),
      body: BlocListener<RevenueCatCubit, RevenueCatState>(
        listener: (context, state) {
          if (state.successMessage != null &&
              state.successMessage!.isNotEmpty) {
            showToastification(
              context,
              state.successMessage!,
              ToastificationType.success,
            );
            context.read<RevenueCatCubit>().clearFeedback();
            _getSubscription();
          }

          if (state.errorMessage != null && state.errorMessage!.isNotEmpty) {
            showToastification(
              context,
              state.errorMessage!,
              ToastificationType.error,
            );
            context.read<RevenueCatCubit>().clearFeedback();
          }
        },
        child: BlocBuilder<SubscriptionBloc, SubscriptionState>(
          builder: (context, state) {
            if (state is SubscriptionLoadingState) {
              return const LoadingPage(title: 'Loading subscription...');
            }
            if (state is SubscriptionErrorState) {
              return _SubscriptionErrorView(
                message: state.errorMessage,
                onRetry: _getSubscription,
              );
            }
            if (state is! SubscriptionSuccessState) {
              return const SizedBox.shrink();
            }

            final data = state.subscriptionEntity.data;
            final currentSubscription = data?.subscription;
            final cardDetails = data?.carddetails;
            final transactions = data?.transactions ?? [];
            final plans = selectedCycle == SubscriptionBillingCycle.monthly
                ? data?.plans?.monthly ?? []
                : data?.plans?.yearly ?? [];

            return RefreshIndicator(
              onRefresh: _refreshPage,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _CurrentSubscriptionCard(
                    subscription: currentSubscription,
                    cardDetails: cardDetails,
                  ),
                  const SizedBox(height: 24),
                  _BillingCycleToggle(
                    selectedCycle: selectedCycle,
                    yearlyDiscountLabel: _buildDiscountLabel(
                        data?.plans?.monthly, data?.plans?.yearly),
                    onChanged: (cycle) {
                      setState(() {
                        selectedCycle = cycle;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  _PlansSection(
                    plans: plans,
                    cycle: selectedCycle,
                    currency: _resolveCurrency(transactions),
                    revenueCatState: revenueCatState,
                    onPlanTap: (plan) => _handlePlanPurchase(
                      plan,
                      revenueCatState,
                    ),
                    onRestoreTap: revenueCatState.isSupportedPlatform &&
                            revenueCatState.isConfigured
                        ? () =>
                            context.read<RevenueCatCubit>().restorePurchases()
                        : _openWebBilling,
                  ),
                  const SizedBox(height: 28),
                  _TransactionSection(
                    transactions: transactions,
                    currency: _resolveCurrency(transactions),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  String? _buildDiscountLabel(
    List<SubscriptionPlanEntity>? monthly,
    List<SubscriptionPlanEntity>? yearly,
  ) {
    if ((monthly ?? []).isEmpty || (yearly ?? []).isEmpty) {
      return null;
    }
    final monthPrice = double.tryParse(monthly!.first.price ?? '0');
    final yearPrice = double.tryParse(yearly!.first.price ?? '0');
    if (monthPrice == null || yearPrice == null || monthPrice <= 0) {
      return null;
    }
    final yearlyFromMonthly = monthPrice * 12;
    if (yearlyFromMonthly <= 0 ||
        yearPrice <= 0 ||
        yearPrice >= yearlyFromMonthly) {
      return null;
    }
    final percent =
        (((yearlyFromMonthly - yearPrice) / yearlyFromMonthly) * 100).round();
    if (percent <= 0) {
      return null;
    }
    return 'save $percent% on yearly';
  }

  String _resolveCurrency(List<SubscriptionTransactionEntity> transactions) {
    return transactions.isNotEmpty
        ? (transactions.first.currency ?? 'USD')
        : 'USD';
  }
}

class _CurrentSubscriptionCard extends StatelessWidget {
  final CurrentSubscriptionEntity? subscription;
  final SubscriptionCardDetailsEntity? cardDetails;

  const _CurrentSubscriptionCard({
    required this.subscription,
    required this.cardDetails,
  });

  @override
  Widget build(BuildContext context) {
    final days = int.tryParse(subscription?.days ?? '0') ?? 0;
    final isExpired = subscription?.isExpired ?? false;
    final paymentSuffix = (cardDetails?.number ?? '').trim();
    final paymentMethod =
        paymentSuffix.isEmpty ? 'Not added' : '**** **** **** $paymentSuffix';

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppPallete.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppPallete.itemDividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Current Subscription',
            style: AppFonts.mediumStyle(size: 22, color: AppPallete.textColor),
          ),
          const SizedBox(height: 28),
          LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth >= 900;
              if (isWide) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _SubscriptionDetailsColumn(
                        rows: [
                          _SubscriptionDetailRow(
                            label: 'Plan',
                            value: subscription?.name ?? '-',
                          ),
                          _SubscriptionDetailRow(
                            label: 'Start date',
                            value: subscription?.startdate ?? '-',
                          ),
                          _SubscriptionDetailRow(
                            label: 'End date',
                            value: subscription?.enddate ?? '-',
                          ),
                          _SubscriptionDetailRow(
                            label: 'Status',
                            value: subscription?.status ?? '-',
                            isStatus: true,
                            isPositive: !isExpired,
                            trailing: !isExpired && days > 0
                                ? '($days days left)'
                                : null,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 32),
                    Expanded(
                      child: _SubscriptionDetailsColumn(
                        rows: [
                          _SubscriptionDetailRow(
                            label: 'Billing cycle',
                            value: subscription?.frequency ?? '-',
                          ),
                          _SubscriptionDetailRow(
                            label: 'Billing amount',
                            value: '\$${subscription?.amount ?? '0.00'}',
                          ),
                          _SubscriptionDetailRow(
                            label: 'Payment method',
                            value: paymentMethod,
                            trailingWidget: TextButton(
                              onPressed: null,
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.only(top: 8),
                                minimumSize: Size.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: Text(
                                'Update',
                                style: AppFonts.regularStyle(
                                  size: 15,
                                  color: AppPallete.blueColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }
              return Column(
                children: [
                  _SubscriptionDetailsColumn(
                    rows: [
                      _SubscriptionDetailRow(
                        label: 'Plan',
                        value: subscription?.name ?? '-',
                      ),
                      _SubscriptionDetailRow(
                        label: 'Billing cycle',
                        value: subscription?.frequency ?? '-',
                      ),
                      _SubscriptionDetailRow(
                        label: 'Start date',
                        value: subscription?.startdate ?? '-',
                      ),
                      _SubscriptionDetailRow(
                        label: 'End date',
                        value: subscription?.enddate ?? '-',
                      ),
                      _SubscriptionDetailRow(
                        label: 'Billing amount',
                        value: '\$${subscription?.amount ?? '0.00'}',
                      ),
                      _SubscriptionDetailRow(
                        label: 'Payment method',
                        value: paymentMethod,
                      ),
                      _SubscriptionDetailRow(
                        label: 'Status',
                        value: subscription?.status ?? '-',
                        isStatus: true,
                        isPositive: !isExpired,
                        trailing:
                            !isExpired && days > 0 ? '($days days left)' : null,
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 16),
          Text(
            'Cancel Account',
            style: AppFonts.regularStyle(
              size: 15,
              color: AppPallete.borderColor,
            ),
          )
        ],
      ),
    );
  }
}

class _SubscriptionDetailRow {
  final String label;
  final String value;
  final bool isStatus;
  final bool isPositive;
  final String? trailing;
  final Widget? trailingWidget;

  const _SubscriptionDetailRow({
    required this.label,
    required this.value,
    this.isStatus = false,
    this.isPositive = false,
    this.trailing,
    this.trailingWidget,
  });
}

class _SubscriptionDetailsColumn extends StatelessWidget {
  final List<_SubscriptionDetailRow> rows;

  const _SubscriptionDetailsColumn({required this.rows});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: rows.map((row) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 24),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 140,
                child: Text(
                  '${row.label}:',
                  style: AppFonts.mediumStyle(
                      size: 16, color: AppPallete.textColor),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: row.value,
                            style: row.isStatus
                                ? AppFonts.mediumStyle(
                                    size: 16,
                                    color: row.isPositive
                                        ? AppPallete.greenColor
                                        : AppPallete.red,
                                  )
                                : AppFonts.regularStyle(
                                    size: 16,
                                    color: row.label == 'Plan'
                                        ? AppPallete.blueColor
                                        : AppPallete.textColor,
                                  ),
                          ),
                          if (row.trailing != null)
                            TextSpan(
                              text: ' ${row.trailing!}',
                              style: AppFonts.regularStyle(
                                size: 16,
                                color: AppPallete.k666666,
                              ),
                            ),
                        ],
                      ),
                    ),
                    if (row.trailingWidget != null) row.trailingWidget!,
                  ],
                ),
              )
            ],
          ),
        );
      }).toList(),
    );
  }
}

class _BillingCycleToggle extends StatelessWidget {
  final SubscriptionBillingCycle selectedCycle;
  final String? yearlyDiscountLabel;
  final ValueChanged<SubscriptionBillingCycle> onChanged;

  const _BillingCycleToggle({
    required this.selectedCycle,
    required this.yearlyDiscountLabel,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 320,
          height: 58,
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: const Color(0xFFE8EBF5),
            borderRadius: BorderRadius.circular(999),
          ),
          child: Row(
            children: [
              Expanded(
                child: _BillingCycleItem(
                  title: 'Monthly',
                  isSelected: selectedCycle == SubscriptionBillingCycle.monthly,
                  onTap: () => onChanged(SubscriptionBillingCycle.monthly),
                ),
              ),
              Expanded(
                child: _BillingCycleItem(
                  title: 'Yearly',
                  isSelected: selectedCycle == SubscriptionBillingCycle.yearly,
                  onTap: () => onChanged(SubscriptionBillingCycle.yearly),
                ),
              ),
            ],
          ),
        ),
        if (yearlyDiscountLabel != null) ...[
          const SizedBox(height: 12),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: yearlyDiscountLabel!.split(' ').take(3).join(' '),
                  style: AppFonts.mediumStyle(
                    size: 16,
                    color: AppPallete.greenColor,
                  ),
                ),
                TextSpan(
                  text: ' yearly',
                  style: AppFonts.mediumStyle(
                    size: 16,
                    color: AppPallete.textColor,
                  ),
                ),
              ],
            ),
          )
        ],
      ],
    );
  }
}

class _BillingCycleItem extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const _BillingCycleItem({
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(999),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? AppPallete.white : AppPallete.clear,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Text(
          title,
          style: AppFonts.mediumStyle(size: 18, color: AppPallete.textColor),
        ),
      ),
    );
  }
}

class _PlansSection extends StatelessWidget {
  final List<SubscriptionPlanEntity> plans;
  final SubscriptionBillingCycle cycle;
  final String currency;
  final RevenueCatState revenueCatState;
  final ValueChanged<SubscriptionPlanEntity> onPlanTap;
  final Future<void> Function() onRestoreTap;

  const _PlansSection({
    required this.plans,
    required this.cycle,
    required this.currency,
    required this.revenueCatState,
    required this.onPlanTap,
    required this.onRestoreTap,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final itemWidth = width >= 1200
            ? (width - 32) / 3
            : width >= 800
                ? (width - 16) / 2
                : width;

        return Column(
          children: [
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: plans
                  .map((plan) => SizedBox(
                        width: itemWidth,
                        child: _PlanCard(
                          plan: plan,
                          cycle: cycle,
                          onTap: () => onPlanTap(plan),
                          isBusy: revenueCatState.isPurchaseInProgress,
                        ),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 18),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: revenueCatState.isPurchaseInProgress
                    ? null
                    : () => onRestoreTap(),
                child: Text(
                  revenueCatState.isSupportedPlatform &&
                          revenueCatState.isConfigured
                      ? 'Restore purchases'
                      : 'Manage billing on web',
                  style: AppFonts.regularStyle(
                    size: 15,
                    color: AppPallete.blueColor,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 18),
            Text(
              revenueCatState.isSupportedPlatform &&
                      revenueCatState.isConfigured
                  ? '* Prices are in $currency. Purchases use RevenueCat on this device.'
                  : '* Prices are in $currency. Billing will open in the web subscription portal on this device.',
              style: AppFonts.regularStyle(
                size: 15,
                color: AppPallete.k666666,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _PlanCard extends StatelessWidget {
  final SubscriptionPlanEntity plan;
  final SubscriptionBillingCycle cycle;
  final VoidCallback? onTap;
  final bool isBusy;

  const _PlanCard({
    required this.plan,
    required this.cycle,
    required this.onTap,
    required this.isBusy,
  });

  @override
  Widget build(BuildContext context) {
    final isActive = plan.isActive ?? false;
    final buttonText = isActive
        ? 'Currently Active'
        : (plan.buybtnText?.isNotEmpty == true
            ? plan.buybtnText!
            : 'Available');
    final canTap = !isActive && !isBusy;

    return Container(
      height: 350,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isActive ? AppPallete.blueColor : const Color(0xFFF3F5FB),
        borderRadius: BorderRadius.circular(26),
        border: Border.all(
          color: isActive ? AppPallete.blueColor : AppPallete.itemDividerColor,
        ),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          if (isActive)
            Positioned(
              top: -36,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: AppPallete.blueColor,
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(color: AppPallete.white, width: 3),
                  ),
                  child: Text(
                    'Current plan',
                    style: AppFonts.regularStyle(
                        size: 16, color: AppPallete.white),
                  ),
                ),
              ),
            ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                plan.name ?? '-',
                style: AppFonts.mediumStyle(
                  size: 22,
                  color: isActive ? AppPallete.white : AppPallete.textColor,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '${plan.maxUsers ?? '-'} users\nper organisation',
                style: AppFonts.boldStyle(
                  size: 20,
                  color: isActive ? AppPallete.white : AppPallete.textColor,
                ),
              ),
              const Spacer(),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '\$',
                      style: AppFonts.regularStyle(
                        size: 30,
                        color: isActive
                            ? AppPallete.white.withValues(alpha: 0.85)
                            : AppPallete.k666666,
                      ),
                    ),
                    TextSpan(
                      text: plan.price ?? '0.00',
                      style: AppFonts.boldStyle(
                        size: 62,
                        color: isActive ? AppPallete.white : AppPallete.black,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Center(
                child: InkWell(
                  onTap: canTap ? onTap : null,
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 22,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: isActive ? AppPallete.white : AppPallete.clear,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: isActive
                            ? AppPallete.white
                            : AppPallete.blueColor.withValues(alpha: 0.4),
                      ),
                    ),
                    child: Text(
                      isBusy && !isActive ? 'Processing...' : buttonText,
                      style: AppFonts.regularStyle(
                        size: 16,
                        color: isActive
                            ? AppPallete.blueColor
                            : AppPallete.blueColor50,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 4),
            ],
          ),
        ],
      ),
    );
  }
}

class _TransactionSection extends StatelessWidget {
  final List<SubscriptionTransactionEntity> transactions;
  final String currency;

  const _TransactionSection({
    required this.transactions,
    required this.currency,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Transaction History',
          style: AppFonts.mediumStyle(size: 28, color: AppPallete.textColor),
        ),
        const SizedBox(height: 18),
        LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth < 800) {
              return Column(
                children: transactions
                    .map((tx) =>
                        _TransactionCard(transaction: tx, currency: currency))
                    .toList(),
              );
            }
            return _TransactionTable(
              transactions: transactions,
              currency: currency,
            );
          },
        )
      ],
    );
  }
}

class _TransactionTable extends StatelessWidget {
  final List<SubscriptionTransactionEntity> transactions;
  final String currency;

  const _TransactionTable({
    required this.transactions,
    required this.currency,
  });

  @override
  Widget build(BuildContext context) {
    final headerStyle =
        AppFonts.mediumStyle(size: 17, color: AppPallete.textColor);
    return Container(
      decoration: BoxDecoration(
        color: AppPallete.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppPallete.itemDividerColor),
      ),
      child: Table(
        columnWidths: const {
          0: FlexColumnWidth(1.6),
          1: FlexColumnWidth(5.5),
          2: FlexColumnWidth(1.8),
          3: FlexColumnWidth(1.5),
        },
        children: [
          TableRow(
            decoration: const BoxDecoration(color: AppPallete.white),
            children: [
              _TableCell(text: 'DATE', style: headerStyle, isHeader: true),
              _TableCell(text: 'DETAILS', style: headerStyle, isHeader: true),
              _TableCell(text: 'STATUS', style: headerStyle, isHeader: true),
              _TableCell(
                  text: 'AMOUNT',
                  style: headerStyle,
                  isHeader: true,
                  alignEnd: true),
            ],
          ),
          ...transactions.map(
            (transaction) => TableRow(
              decoration: const BoxDecoration(color: AppPallete.white),
              children: [
                _TableCell(text: _formatDate(transaction.date)),
                _TableCell(text: _detailText(transaction)),
                _TableCell(text: transaction.operationType ?? '-'),
                _TableCell(
                  text: _currencyText(transaction.amount, currency),
                  alignEnd: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TransactionCard extends StatelessWidget {
  final SubscriptionTransactionEntity transaction;
  final String currency;

  const _TransactionCard({
    required this.transaction,
    required this.currency,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppPallete.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppPallete.itemDividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _formatDate(transaction.date),
            style: AppFonts.mediumStyle(size: 18, color: AppPallete.textColor),
          ),
          const SizedBox(height: 10),
          Text(
            _detailText(transaction),
            style: AppFonts.regularStyle(size: 16, color: AppPallete.k666666),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                transaction.operationType ?? '-',
                style:
                    AppFonts.mediumStyle(size: 16, color: AppPallete.textColor),
              ),
              Text(
                _currencyText(transaction.amount, currency),
                style:
                    AppFonts.mediumStyle(size: 18, color: AppPallete.textColor),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _TableCell extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final bool isHeader;
  final bool alignEnd;

  const _TableCell({
    required this.text,
    this.style,
    this.isHeader = false,
    this.alignEnd = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppPallete.itemDividerColor),
        ),
      ),
      child: Text(
        text,
        textAlign: alignEnd ? TextAlign.right : TextAlign.left,
        style: style ??
            AppFonts.mediumStyle(
              size: isHeader ? 17 : 16,
              color: isHeader ? AppPallete.textColor : AppPallete.k666666,
            ),
      ),
    );
  }
}

class _SubscriptionErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _SubscriptionErrorView({
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppFonts.regularStyle(size: 16, color: AppPallete.k666666),
            ),
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: onRetry,
              child: const Text('Retry'),
            )
          ],
        ),
      ),
    );
  }
}

String _formatDate(String? rawDate) {
  if (rawDate == null || rawDate.isEmpty) {
    return '-';
  }
  try {
    final parsedDate = DateTime.parse(rawDate);
    return DateFormat('dd MMM yyyy').format(parsedDate);
  } catch (_) {
    return rawDate;
  }
}

String _formatPeriod(String? start, String? end) {
  if ((start ?? '').isEmpty || (end ?? '').isEmpty) {
    return '';
  }
  try {
    final startDate = DateFormat('yyyy-MM-dd').parse(start!);
    final endDate = DateFormat('yyyy-MM-dd').parse(end!);
    final formattedStart = DateFormat('dd MMM yyyy').format(startDate);
    final formattedEnd = DateFormat('dd MMM yyyy').format(endDate);
    return '($formattedStart to $formattedEnd)';
  } catch (_) {
    return '(${start ?? ''} to ${end ?? ''})';
  }
}

String _detailText(SubscriptionTransactionEntity transaction) {
  final planName = transaction.planName ?? '-';
  final period =
      _formatPeriod(transaction.planStartdate, transaction.planEnddate);
  return '$planName subscription ${period.isEmpty ? '' : period}'.trim();
}

String _currencyText(String? amount, String currency) {
  return '\$${amount ?? '0.00'}';
}
