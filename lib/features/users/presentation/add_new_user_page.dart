import 'package:auto_route/auto_route.dart';
import 'package:billbooks_app/features/users/presentation/checkbox_widget.dart';
import 'package:flutter/material.dart';

import '../../../core/app_constants.dart';
import '../../../core/theme/app_fonts.dart';
import '../../../core/theme/app_pallete.dart';
import '../../../core/widgets/input_dropdown_view.dart';
import '../../../core/widgets/new_inputview_widget.dart';

@RoutePage()
class AddNewUserPage extends StatefulWidget {
  const AddNewUserPage({super.key});

  @override
  State<AddNewUserPage> createState() => _AddNewUserPageState();
}

class _AddNewUserPageState extends State<AddNewUserPage> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController reTypeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("New User"),
          bottom: AppConstants.getAppBarDivider,
          leading: IconButton(
              onPressed: () {
                //widget.startObserveBlocBack();
                AutoRouter.of(context).maybePop();
              },
              icon: const Icon(
                Icons.close,
                color: AppPallete.blueColor,
              )),
          actions: [
            TextButton(
                onPressed: () {
                  //addEstimate();
                },
                child: Text(
                  "Save",
                  style: AppFonts.regularStyle(color: AppPallete.blueColor),
                ))
          ],
        ),
        body: Column(
          children: [
            AppConstants.sizeBoxHeight10,
            NewInputViewWidget(
              isRequired: true,
              title: 'Full Name',
              hintText: 'Full Name',
              controller: fullNameController,
              textCapitalization: TextCapitalization.words,
            ),
            NewInputViewWidget(
              isRequired: true,
              title: 'Email Address',
              hintText: 'Email Address',
              controller: emailController,
              textCapitalization: TextCapitalization.words,
            ),
            InputDropdownView(
              title: 'Position',
              dropDownImageName: Icons.chevron_right,
              isRequired: false,
              defaultText: 'Tap to select',
              value: "",
              onPress: () {},
            ),
            NewInputViewWidget(
              isRequired: true,
              title: 'Possword',
              hintText: 'Possword',
              controller: passwordController,
              textCapitalization: TextCapitalization.words,
            ),
            NewInputViewWidget(
              isRequired: true,
              title: 'Retype',
              hintText: '',
              controller: reTypeController,
              textCapitalization: TextCapitalization.words,
            ),
            // SizedBox(
            //   height: 300,
            //   child: ListView.builder(
            //       itemCount: 3,
            //       itemBuilder: (context, index) {
            //         return CheckboxWidget();
            //       }),
            // )
          ],
        ));
  }
}
