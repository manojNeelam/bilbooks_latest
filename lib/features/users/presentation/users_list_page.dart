import 'package:auto_route/auto_route.dart';
import 'package:billbooks_app/core/app_constants.dart';
import 'package:billbooks_app/core/theme/app_fonts.dart';
import 'package:billbooks_app/core/theme/app_pallete.dart';
import 'package:billbooks_app/core/widgets/cap_status_widget.dart';
import 'package:billbooks_app/core/widgets/item_separator.dart';
import 'package:billbooks_app/core/widgets/list_empty_page.dart';
import 'package:billbooks_app/features/users/domain/entities/user_list_entity.dart';
import 'package:billbooks_app/features/users/domain/usecases/user_list_usecase.dart';
import 'package:billbooks_app/features/users/presentation/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_section_list/flutter_section_list.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../core/widgets/title_subtitle_header_widget.dart';

@RoutePage()
// ignore: must_be_immutable
class UsersListPage extends StatefulWidget {
  const UsersListPage({super.key});

  @override
  State<UsersListPage> createState() => _UsersListPageState();
}

class _UsersListPageState extends State<UsersListPage>
    with SectionAdapterMixin {
  List<UserEntity> users = [];
  bool isLoading = false;

  @override
  void initState() {
    _getUserList();
    super.initState();
  }

  void _getUserList() {
    context
        .read<UserBloc>()
        .add(GetUserList(userListRequestParams: UserListRequestParams()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Users"),
      ),
      body: BlocConsumer<UserBloc, UserState>(
        listener: (context, state) {
          if (state is UserListLoadingState) {
            isLoading = true;
          }

          if (state is UserListErrorState) {
            isLoading = false;
          }
        },
        builder: (context, state) {
          if (state is UserListSuccessState) {
            isLoading = false;
            final usersList = state.usersMainResEntity.data?.users ?? [];
            users = usersList;
            if (usersList.isEmpty) {
              return showEmptyView();
            }
          }
          return Skeletonizer(
              enabled: isLoading,
              child: SectionListView.builder(adapter: this));
        },
      ),
    );
  }

  @override
  bool shouldExistSectionHeader(int section) {
    return true;
  }

  @override
  Widget getSectionHeader(BuildContext context, int section) {
    return const TitleSubtitleHeaderWidget(
      leadingTitle: "User",
      trailingTitle: "Role",
    );
  }

  @override
  Widget getItem(BuildContext context, IndexPath indexPath) {
    final item = isLoading
        ? UserEntity(
            name: "User Name", email: "User@gmail.com", isPrimary: true)
        : users[indexPath.item];
    return Container(
      color: AppPallete.white,
      child: Column(
        children: [
          Padding(
            padding: AppConstants.horizontalVerticalPadding,
            child: Row(
              children: [
                Container(
                    width: 35,
                    height: 35,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppPallete.lightBlueColor),
                    child: const Icon(
                      Icons.person,
                      color: AppPallete.blueColor,
                    )),
                AppConstants.sizeBoxWidth10,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            item.name ?? "",
                            style: AppFonts.regularStyle(),
                          ),
                          if (item.isPrimary ?? false)
                            AppConstants.sizeBoxWidth5,
                          if (item.isPrimary ?? false)
                            const CapsuleStatusWidget(
                                title: "Primary",
                                backgroundColor: AppPallete.kF2F2F2,
                                textColor: AppPallete.greenColor),
                        ],
                      ),
                      Text(
                        item.email ?? "",
                        style: AppFonts.regularStyle(
                            size: 14, color: AppPallete.k666666),
                      )
                    ],
                  ),
                ),
                Text(
                  item.position ?? "",
                  textAlign: TextAlign.end,
                  style: AppFonts.regularStyle(size: 14),
                ),
              ],
            ),
          ),
          const ItemSeparator(),
        ],
      ),
    );
  }

  @override
  int numberOfItems(int section) {
    return isLoading ? 10 : users.length;
  }

  Widget showEmptyView() {
    return ListEmptyPage(
      buttonTitle: "Create new user",
      noDataText: "Billing without users could be hard.",
      iconName: Icons.shopping_bag_outlined,
      noDataSubtitle:
          "Add your popular products and services so you can use them while creating invoices and estimates in seconds. It's easy, we'll sho you how.",
      callBack: () {
        //AutoRouter.of(context).push(const NewClientPageRoute());
      },
    );
  }
}
