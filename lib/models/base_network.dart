import 'dart:convert';
import 'package:http/http.dart' as http;

class BaseNetwork{
  static const String baseUrl = "https://sneaker-database-stockx.p.rapidapi.com"; // masukkan endpoint API

  static Future<List<dynamic>> get(String partUrl) async {
    final String fullUrl = "$baseUrl/$partUrl";
    final response = await http.get(Uri.parse(fullUrl),
        headers: {
          'X-RapidAPI-Key': '3c6451b400msh908940c19cd0e13p13bc7bjsn92b6136e6969',
          'X-RapidAPI-Host': 'sneaker-database-stockx.p.rapidapi.com'
        });
    return _processResponse(response);
  }

  // static Future<List<Map<String, dynamic>>> _processResponse(http.Response response) async {
    static Future<List<dynamic>> _processResponse(http.Response response) async {
    final body = response.body;
    if (body.isNotEmpty) {
      var jsonBody = jsonDecode(body);
      return jsonBody;
    } else {
      print("processResponse error");
      return [{"error": true}];
    }
  }

  static void debugPrint(String value) {
    print("[BASE_NETWORK] - $value");
  }

  // getCurrency(){
  //   return http.get("https://v6.exchangerate-api.com/v6/5f61c447f35d5761d07986ea/latest/USD")
  // }
}