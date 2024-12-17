import 'package:auto_route/auto_route.dart';
import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:billbooks_app/core/constants/assets.dart';
import 'package:billbooks_app/core/theme/app_pallete.dart';
import 'package:billbooks_app/features/clients/presentation/client_list_page.dart';
import 'package:billbooks_app/features/dashboard/domain/entity/authinfo_entity.dart';
import 'package:billbooks_app/features/estimate/presentation/bloc/estimate_bloc.dart';
import 'package:billbooks_app/features/invoice/presentation/invoice_list_page.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'dashboard/presentation/dashboard_page.dart';
import 'estimate/presentation/estimate_list_page.dart';
import 'general/bloc/general_bloc.dart';
import 'more/more_page.dart';

@RoutePage()
class General extends StatefulWidget {
  final AuthInfoMainDataEntity authInfoMainDataEntity;
  const General({super.key, required this.authInfoMainDataEntity});

  @override
  State<General> createState() => _GeneralState();
}

class _GeneralState extends State<General> {
  void Function()? refreshClientList;
  void Function()? refreshInvoiecList;
  void Function()? refreshEstimateList;
  late AuthInfoMainDataEntity authInfoMainDataEntity;
  String estimateTitle = "Estimate";

  @override
  void initState() {
    authInfoMainDataEntity = widget.authInfoMainDataEntity;
    estimateTitle =
        authInfoMainDataEntity.sessionData?.organization?.estimateHeading ??
            "Estimate";

    loadData();
    super.initState();
  }

  final PageController controller = PageController();

  /// initializing controller for PageView

  int visit = 0;
  List<Widget> pages = [];

  List<BottomNavigationBarItem> items = [];
  loadData() {
    items = [
      const BottomNavigationBarItem(
        icon: Icon(Icons.dashboard_outlined),
        label: "Home",
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.people_outline),
        label: "Clients",
      ),
      const BottomNavigationBarItem(
          icon: Icon(Icons.note_add_outlined), label: 'Invoices'),
      BottomNavigationBarItem(
          icon: Icon(Icons.note_outlined), label: estimateTitle),
      const BottomNavigationBarItem(
          icon: Icon(Icons.more_horiz_outlined), label: 'More'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    pages = [
      DashboardPage(
        authInfoMainDataEntity: authInfoMainDataEntity,
        refreshOtherTabs: () {
          if (refreshClientList != null) {
            refreshClientList?.call();
          }

          if (refreshInvoiecList != null) {
            refreshInvoiecList?.call();
          }

          if (refreshEstimateList != null) {
            refreshEstimateList?.call();
          }
        },
      ),
      ClientListPage(
        builder: (context, method) {
          refreshClientList = method;
        },
      ),
      InvoiceListPage(
        builder: (context, forceRefreshInvoiceList) {
          refreshInvoiecList = forceRefreshInvoiceList;
        },
      ),
      EstimateListPage(
        builder: (context, forceRefreshEstimateList) {
          refreshEstimateList = forceRefreshEstimateList;
        },
      ),
      MorePage(
        authInfoMainDataEntity: authInfoMainDataEntity,
      ),
    ];

    return Scaffold(
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: controller,
          children: pages,
          onPageChanged: (index) {
            setState(() {
              visit = index;
            });
          },
        ),
        bottomNavigationBar: BlocBuilder<GeneralBloc, GeneralState>(
          builder: (context, state) {
            if (state is EstimateHeadingState) {
              estimateTitle = state.estimateHeading;
              items[3] = BottomNavigationBarItem(
                  icon: Icon(Icons.note_outlined), label: estimateTitle);
            }
            return BottomNavigationBar(
                //9490144443
                onTap: (index) {
                  controller.jumpToPage(index);
                  setState(() {
                    visit = index;
                  });
                },
                type: BottomNavigationBarType.fixed,
                selectedIconTheme: IconThemeData(opacity: 1.0, size: 30),
                unselectedIconTheme: IconThemeData(opacity: 1.0, size: 30),
                selectedItemColor: AppPallete.blueColor,
                unselectedItemColor: Colors.grey,
                currentIndex: visit,
                items: items);
          },
        ));
  }
}

/*
bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: BottomBarDefault(
          items: items,
          backgroundColor: Colors.white,
          color: AppPallete.borderColor,
          colorSelected: AppPallete.blueColor,
          indexSelected: visit,
          onTap: (int index) {
            controller.jumpToPage(index);
            setState(() {
              visit = index;
            });
          },
        ),
      ),
*/
