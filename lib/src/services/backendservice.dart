import 'dart:convert';
import 'package:http/http.dart' as http;

class BackendService {
  static Future<Map<String, dynamic>> get(String url,
      {Map<String, String>? params}) async {
    final uri = Uri.parse(url);
    final response = await http.get(uri.replace(queryParameters: params));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Error al enviar los datos");
    }
  }
}
