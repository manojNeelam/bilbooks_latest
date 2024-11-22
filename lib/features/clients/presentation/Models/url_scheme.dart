enum EnumUrlScheme {
  sms,
  call,
  mail,
}

extension EnumUrlSchemeExtension on EnumUrlScheme {
  String get path {
    switch (this) {
      case EnumUrlScheme.sms:
        return "sms:";
      case EnumUrlScheme.call:
        return "tel:";
      case EnumUrlScheme.mail:
        return "mailto:";
    }
  }
}
