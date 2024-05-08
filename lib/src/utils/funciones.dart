import 'package:appepunemiscan/src/widget/extends_files.dart';
import 'package:url_launcher/url_launcher.dart';

String convertToUtf8(String input) {
  List<int> list = input.codeUnits;
  return utf8.decode(list);
}

String truncateText(String text, int maxLength) {
  if (text.length <= maxLength) {
    return text;
  }
  return text.substring(0, maxLength) + '...';
}

void launchURL(String url) async {
  await launch('${urlMedia}/media/${url}');
}

bool validarNumero(String valor) {
  return RegExp(r'^[0-9]+$').hasMatch(valor);
}
