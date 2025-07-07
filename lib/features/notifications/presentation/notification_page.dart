import 'package:auto_route/auto_route.dart';
import 'package:billbooks_app/core/app_constants.dart';
import 'package:billbooks_app/core/theme/app_fonts.dart';
import 'package:billbooks_app/core/theme/app_pallete.dart';
import 'package:billbooks_app/core/utils/show_toast.dart';
import 'package:billbooks_app/features/notifications/bloc/notification_bloc.dart';
import 'package:billbooks_app/features/notifications/data/model/notifcation_model.dart';
import 'package:billbooks_app/features/notifications/domain/entities/notifcation_entity.dart';
import 'package:billbooks_app/features/notifications/domain/usecase/notification_list_usercase.dart';
import 'package:billbooks_app/features/notifications/presentation/widgets/notification_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:toastification/toastification.dart';

@RoutePage()
class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List<ActivitylogEntity> activities = [];
  bool isLoading = false;

  @override
  void initState() {
    _loadActivities();
    super.initState();
  }

  _loadActivities() {
    context.read<NotificationBloc>().add(
        GetNotificationsEvent(params: NotificationListUsercaseReqParams()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recent Activities"),
        bottom: AppConstants.getAppBarDivider,
      ),
      body: BlocConsumer<NotificationBloc, NotificationState>(
        listener: (context, state) {
          if (state is NotificationListLoading) {
            isLoading = true;
          }
          if (state is NotificationListSuccessState) {
            isLoading = false;
            activities =
                state.notificationMainResponseEntity.data?.activitylog ?? [];
          }
          if (state is NotificationListErrorState) {
            isLoading = false;
            showToastification(
                context, state.errorMessage, ToastificationType.error);
          }
        },
        builder: (context, state) {
          if (state is NotificationListSuccessState) {
            if (activities.isEmpty) {
              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.notifications_off_rounded,
                      color: AppPallete.borderColor,
                      size: 30,
                    ),
                    AppConstants.sizeBoxHeight10,
                    Text(
                      "No Records",
                      style: AppFonts.regularStyle(),
                    ),
                  ],
                ),
              );
            }
          }
          return Skeletonizer(
            enabled: isLoading,
            child: Center(
                child: ListView.builder(
                    itemCount: isLoading ? 10 : activities.length,
                    itemBuilder: (buildContext, index) {
                      var activitylogEntity = isLoading
                          ? ActivitylogModel(
                              operationType: "create",
                              transactionType: "transaction_type",
                              parameters: "parameters",
                              estimateId: "123",
                              createdName: "Name",
                            )
                          : activities[index];
                      return NotificationItem(
                          activitylogEntity: activitylogEntity);
                    })),
          );
        },
      ),
    );
  }
}
