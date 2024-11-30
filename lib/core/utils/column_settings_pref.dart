import 'package:billbooks_app/features/dashboard/domain/entity/authinfo_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

// SharedPreferences shared_User = await SharedPreferences.getInstance();
// //Map decode_options = jsonDecode(jsonString);
// String user = jsonEncode(User.fromJson(decode_options));
// shared_User.setString('column_settings_preference', user);

// SharedPreferences shared_User = await SharedPreferences.getInstance();
// Map userMap = jsonDecode(shared_User.getString('column_settings_preference'));
// var user = User.fromJson(userMap);

class ColumnSettingsPref {
  final String qty;
  final String rate;
  final bool hideQty;
  final bool hideRate;
  final String itemTitle;

  ColumnSettingsPref(
      {required this.qty,
      required this.rate,
      required this.itemTitle,
      required this.hideQty,
      required this.hideRate});

  factory ColumnSettingsPref.fromJson(Map<String, dynamic> json) {
    return ColumnSettingsPref(
      itemTitle: json['item_title'] ?? "Items",
      qty: json['qty'] ?? "Qty",
      rate: json['rate'] ?? "Rate",
      hideQty: json['hide_qty'] ?? false,
      hideRate: json['hide_rate'] ?? false,
    );
  }

//
  factory ColumnSettingsPref.fromInfo(
      {required String? qty,
      required String? rate,
      required String? itemTitle,
      required bool? hideQty,
      required bool? hideRate}) {
    return ColumnSettingsPref(
      itemTitle: itemTitle ?? "Items",
      qty: qty ?? "Qty",
      rate: rate ?? "Rate",
      hideQty: hideQty ?? false,
      hideRate: hideRate ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "qty": qty,
      "rate": rate,
      "hide_qty": hideQty,
      "hide_rate": hideRate,
      "item_title": itemTitle
    };
  }
}
