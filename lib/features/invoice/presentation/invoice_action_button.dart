import 'package:flutter/material.dart';

import '../../../core/constants/assets.dart';

enum InvoiceActionButtonType {
  edit,
  send,
  viewpdf,
  more,
  payment,
  reminder,
  thankYou,
  unVoid,
  invoice,
  printpdf,
}

extension InvoiceActionButtonTypeExt on InvoiceActionButtonType {
  String get name {
    switch (this) {
      case InvoiceActionButtonType.edit:
        return "Edit";
      case InvoiceActionButtonType.send:
        return "Send";
      case InvoiceActionButtonType.viewpdf:
        return "View PDF";
      case InvoiceActionButtonType.more:
        return "More";

      case InvoiceActionButtonType.payment:
        return "Payments";

      case InvoiceActionButtonType.reminder:
        return "Reminder";
      case InvoiceActionButtonType.thankYou:
        return "Thank You";
      case InvoiceActionButtonType.unVoid:
        return "Unvoid";
      case InvoiceActionButtonType.invoice:
        return "Invoice";
      case InvoiceActionButtonType.printpdf:
        return "Print PDF";
    }
  }

  String get imageName {
    switch (this) {
      case InvoiceActionButtonType.edit:
        return Assets.assetsImagesEditIc;
      case InvoiceActionButtonType.send:
        return Assets.assetsImagesSendIc;
      case InvoiceActionButtonType.viewpdf:
        return Assets.assetsImagesViewPdfIc;
      case InvoiceActionButtonType.more:
        return Assets.assetsImagesMoreIc;
      case InvoiceActionButtonType.payment:
        return Assets.assetsImagesPaymentIc;
      case InvoiceActionButtonType.reminder:
        return Assets.assetsImagesReminderIc;
      case InvoiceActionButtonType.thankYou:
        return Assets.assetsImagesThankyouIc;
      case InvoiceActionButtonType.unVoid:
        return Assets.assetsImagesIcMore;
      case InvoiceActionButtonType.invoice:
        return Assets.assetsImagesMoreIc;
      case InvoiceActionButtonType.printpdf:
        return Assets.assetsImagesViewPdfIc;
    }
  }
}
