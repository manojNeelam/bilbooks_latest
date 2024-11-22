import 'package:billbooks_app/core/theme/app_fonts.dart';
import 'package:flutter/material.dart';

class AlertUtility {
  AlertUtility._privateConstructor();
  static final AlertUtility _instance = AlertUtility._privateConstructor();
  static AlertUtility get instance => _instance;

  showAlertDialog(
      BuildContext context, String alertTitle, String alertMessage) {
    // set up the buttons
    // Widget cancelButton = TextButton(
    //   child: Text("Cancel"),
    //   onPressed: () {
    //     Navigator.pop(context);
    //   },
    // );
    // Widget continueButton = TextButton(
    //   child: Text("Continue"),
    //   onPressed: () {
    //     Navigator.pop(context);
    //   },
    // );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        'Alert Dialog Title',
        style: AppFonts.mediumStyle(size: 16),
      ),
      content: Text(
        'This is the content of the alert dialog.',
        style: AppFonts.regularStyle(),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text('Confirm'),
          onPressed: () {
            // Handle the confirm action
          },
        ),
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
