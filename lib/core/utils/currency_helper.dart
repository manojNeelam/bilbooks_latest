import 'package:billbooks_app/features/clients/presentation/Models/client_currencies.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:collection/collection.dart';
import 'package:html_unescape/html_unescape.dart';

class CurrencyHelper {
  static final CurrencyHelper _instance = CurrencyHelper._internal();
  factory CurrencyHelper() => _instance;

  CurrencyHelper._internal();

  List<CurrencyModel> _currencies = [];
  final HtmlUnescape _unescape = HtmlUnescape();

  /// Load currencies from JSON once
  Future<void> loadCurrencies() async {
    final String response =
        await rootBundle.loadString('assets/files/currencies.json');
    _currencies = currencyMainDataModelFromJson(response).data?.currency ?? [];
  }

  /// Get the decoded symbol by currency code
  String? getSymbolById(String currencyCode) {
    if (currencyCode == "EUR") {
      return "€";
    }
    final currency =
        _currencies.firstWhereOrNull((c) => c.code == currencyCode);
    if (currency?.symbol != null) {
      return _unescape.convert(currency!.symbol!);
    }
    return null;
  }
}
