import 'package:billbooks_app/core/theme/app_fonts.dart';
import 'package:billbooks_app/core/widgets/loading_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/app_constants.dart';
import '../../../../core/theme/app_pallete.dart';
import '../../../../core/widgets/item_separator.dart';
import '../../domain/entity/account_receivables_entity.dart';
import '../../domain/usecase/account_receivables_usecase.dart';
import '../bloc/accountrecivable_bloc.dart';

class AccountsReceivables extends StatefulWidget {
  const AccountsReceivables({
    super.key,
  });

  @override
  State<AccountsReceivables> createState() => _AccountsReceivablesState();
}

class _AccountsReceivablesState extends State<AccountsReceivables> {
  List<AccountsReceivableEntity> accountReceivable = [];

  @override
  void initState() {
    _callApi();
    super.initState();
  }

  void _callApi() {
    context.read<AccountrecivableBloc>().add(GetAccountReceivablesEvent(
        params: AccountReceivablesUsecaseReqParams()));
  }

  @override
  Widget build(BuildContext context) {
    // List<String> ReceivableList = [
    //   "Asia Art archive",
    //   "Zf-India",
    //   "Krypt Inc.",
    //   "Garware",
    //   "Nullcon"
    // ];
    int maxCount() {
      debugPrint("accountReceivable");
      debugPrint(accountReceivable.length.toString());
      return accountReceivable.length > 4 ? 4 : accountReceivable.length;
    }

    double getSeeMoreHeight() {
      return (accountReceivable.length > 4) ? 100 : 0;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          boxShadow: AppConstants.dashBoardItemSadow,
          borderRadius: BorderRadius.circular(5),
          color: AppPallete.white),
      child: BlocConsumer<AccountrecivableBloc, AccountrecivableState>(
        listener: (context, state) {
          if (state is AccountReceivablesSuccessState) {
            accountReceivable =
                state.accountsReceivablesMainResEntity.data?.data ?? [];
          }
        },
        builder: (context, state) {
          if (state is AccountReceivablesLoadingState) {
            return const SizedBox(
                height: 100,
                child: LoadingPage(title: "Loading Account receivables..."));
          }
          if (state is AccountReceivablesSuccessState) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Accounts Receivables".toUpperCase(),
                  style: AppFonts.regularStyle(),
                ),
                AppConstants.sizeBoxHeight10,
                SizedBox(
                  height: maxCount() > 0 ? (40.0 * maxCount()) : 30,
                  child: (maxCount() > 0)
                      ? Flexible(
                          child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: maxCount(),
                              itemBuilder: (context, index) {
                                AccountsReceivableEntity item =
                                    accountReceivable[index];
                                return SizedBox(
                                  height: 45,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              item.name ?? "",
                                              style: AppFonts.regularStyle(),
                                            ),
                                            Text(
                                              item.amount ?? "",
                                              style: AppFonts.mediumStyle(
                                                  color: AppPallete.red,
                                                  size: 16),
                                            )
                                          ],
                                        ),
                                      ),
                                      if (maxCount() > (index + 1))
                                        const ItemSeparator()
                                    ],
                                  ),
                                );
                              }),
                        )
                      : Text(
                          "No overdue invoices to display",
                          style:
                              AppFonts.regularStyle(color: AppPallete.k666666),
                        ),
                ),
                if (accountReceivable.length > 4)
                  GestureDetector(
                    child: Text(
                      "See more",
                      style: AppFonts.regularStyle(color: AppPallete.blueColor)
                          .copyWith(decoration: TextDecoration.underline),
                    ),
                  ),
              ],
            );
          }
          return const SizedBox(
            height: 100,
          );
        },
      ),
    );
  }
}
