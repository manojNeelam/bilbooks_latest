import 'package:auto_route/auto_route.dart';
import 'package:billbooks_app/core/app_constants.dart';
import 'package:billbooks_app/core/theme/app_fonts.dart';
import 'package:billbooks_app/core/theme/app_pallete.dart';
import 'package:billbooks_app/core/widgets/loading_page.dart';
import 'package:billbooks_app/features/integrations/presentation/bloc/online_payments_bloc.dart';
import 'package:billbooks_app/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_section_list/flutter_section_list.dart';

import '../../../core/widgets/online_payment_header_widget.dart';
import '../domain/entity/online_payment_details_entity.dart';
import '../domain/usecase/online_payment_details_usecase.dart';

enum EnumOnlinePayments { paypal, authorizeNet, checkout, braintree, stripe }

extension EnumOnlinePaymentsExtension on EnumOnlinePayments {
  bool isSelected(OnlinePaymentsEntity entity) {
    switch (this) {
      case EnumOnlinePayments.paypal:
        return entity.pgPaypal ?? false;
      case EnumOnlinePayments.authorizeNet:
        return entity.pgAuthorize ?? false;
      case EnumOnlinePayments.checkout:
        return entity.pg2Co ?? false;
      case EnumOnlinePayments.braintree:
        return entity.pgBraintree ?? false;
      case EnumOnlinePayments.stripe:
        return entity.pgStripe ?? false;
    }
  }

  (String, String) get titleandDesc {
    const desc =
        "Enable your customers to pay their invoices using % payments gateway";
    switch (this) {
      case EnumOnlinePayments.paypal:
        const title = "Paypal";
        final payPalDesc = desc.replaceFirst("%", title);
        return (title, payPalDesc);
      case EnumOnlinePayments.authorizeNet:
        const title = "Authorize.Net";
        final authorizeDesc = desc.replaceFirst("%", title);
        return (title, authorizeDesc);
      case EnumOnlinePayments.checkout:
        const title = "2Checkout";
        final checkOutDesc = desc.replaceFirst("%", title);
        return (title, checkOutDesc);
      case EnumOnlinePayments.braintree:
        const title = "Braintree";
        final braintreeDesc = desc.replaceFirst("%", title);
        return (title, braintreeDesc);
      case EnumOnlinePayments.stripe:
        const title = "Stripe";
        final stripeDesc = desc.replaceFirst("%", title);
        return (title, stripeDesc);
    }
  }
}

@RoutePage()
// ignore: must_be_immutable
class OnlinePaymentsPage extends StatefulWidget {
  const OnlinePaymentsPage({super.key});

  @override
  State<OnlinePaymentsPage> createState() => _OnlinePaymentsPageState();
}

class _OnlinePaymentsPageState extends State<OnlinePaymentsPage>
    with SectionAdapterMixin {
  OnlinePaymentsEntity? onlinePaymentsEntity;

  @override
  void initState() {
    _getOnlinePayments();
    super.initState();
  }

  void _getOnlinePayments() {
    context.read<OnlinePaymentsBloc>().add(GetOnlinePaymentDetails(
        onlinePaymentDetailsReqParms: OnlinePaymentDetailsReqParms()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Online Payments"),
        bottom: AppConstants.getAppBarDivider,
      ),
      body: BlocConsumer<OnlinePaymentsBloc, OnlinePaymentsState>(
        listener: (context, state) {
          if (state is OnlinePaymentDeatilsSuccessState) {
            final data = state.onlinePaymentMainResponseEntity.data;
            onlinePaymentsEntity = data?.onlinepayments;
            debugPrint(
                "onlinePaymentDataEntity: ${onlinePaymentsEntity?.pg2CoId}");
          }
        },
        builder: (context, state) {
          if (state is OnlinePaymentDeatilsLoadingState) {
            return const LoadingPage(title: "Loading...");
          }
          return Padding(
            padding: AppConstants.horizotal16,
            child: SectionListView.builder(adapter: this),
          );
        },
      ),
    );
  }

  @override
  Widget getItem(BuildContext context, IndexPath indexPath) {
    final item = EnumOnlinePayments.values[indexPath.item];
    final (String title, String desc) = item.titleandDesc;
    return GestureDetector(
        onTap: () {
          switch (item) {
            case EnumOnlinePayments.paypal:
              AutoRouter.of(context).push(PaypalPageRoute(
                  onlinePaymentsEntity: onlinePaymentsEntity,
                  refreshList: () {
                    _getOnlinePayments();
                  }));
            case EnumOnlinePayments.authorizeNet:
              AutoRouter.of(context).push(AuthorizePageRoute(
                  onlinePaymentsEntity: onlinePaymentsEntity,
                  refreshList: () {
                    _getOnlinePayments();
                  }));
            case EnumOnlinePayments.checkout:
              AutoRouter.of(context).push(CheckoutPageRoute(
                  onlinePaymentsEntity: onlinePaymentsEntity,
                  refreshList: () {
                    _getOnlinePayments();
                  }));
            case EnumOnlinePayments.braintree:
              AutoRouter.of(context).push(BraintreePageRoute(
                  onlinePaymentsEntity: onlinePaymentsEntity,
                  refreshList: () {
                    _getOnlinePayments();
                  }));
            case EnumOnlinePayments.stripe:
              AutoRouter.of(context).push(StripePageRoute(
                  onlinePaymentsEntity: onlinePaymentsEntity,
                  refreshList: () {
                    _getOnlinePayments();
                  }));
          }
        },
        child: OnlinePaymentItemWidget(
            isSelected:
                item.isSelected(onlinePaymentsEntity ?? OnlinePaymentsEntity()),
            title: title,
            desc: desc));
  }

  @override
  int numberOfItems(int section) {
    return EnumOnlinePayments.values.length;
  }

  @override
  bool shouldExistSectionHeader(int section) {
    return true;
  }

  @override
  Widget getSectionHeader(BuildContext context, int section) {
    return const OnlinePaymentHeaderWidget(
      title: "Note",
    );
  }
}

class OnlinePaymentItemWidget extends StatelessWidget {
  const OnlinePaymentItemWidget({
    super.key,
    required this.title,
    required this.desc,
    required this.isSelected,
  });
  final bool isSelected;
  final String title;
  final String desc;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: AppConstants.verticalPadding13,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppFonts.regularStyle(),
                ),
                Text(
                  desc,
                  style: AppFonts.regularStyle(
                      color: AppPallete.k666666, size: 14),
                )
              ],
            ),
          ),
        ),
        if (isSelected)
          const Icon(
            Icons.check_circle_outline_rounded,
            color: AppPallete.blueColor,
          ),
        AppConstants.sizeBoxWidth5,
        const Icon(
          Icons.chevron_right,
          color: AppPallete.borderColor,
        )
      ],
    );
  }
}
