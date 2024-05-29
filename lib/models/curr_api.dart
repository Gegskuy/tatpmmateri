import 'dart:convert';
import 'package:http/http.dart' as http;

class CurrApi{

  static Future<Map<String, dynamic>> get(String partUrl) async {
    final String fullUrl = "https://v6.exchangerate-api.com/v6/5f61c447f35d5761d07986ea/latest/USD";
    final response = await http.get(Uri.parse(fullUrl));
    return _processResponse(response);
  }

  static Future<Map<String, dynamic>> _processResponse(http.Response response) async {
    final body = response.body;
    if (body.isNotEmpty) {
      final jsonBody = json.decode(body);
      return jsonBody;
    } else {
      print("processResponse error");
      return {"error": true};
    }
  }

  static void debugPrint(String value) {
    print("[BASE_NETWORK] - $value");
  }
}