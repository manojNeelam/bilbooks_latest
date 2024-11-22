import 'package:html_unescape/html_unescape.dart';

class EscapeHtmlCode {
  var htmlUnescape = HtmlUnescape();
  String convert(String str) {
    return htmlUnescape.convert(str);
  }
}
