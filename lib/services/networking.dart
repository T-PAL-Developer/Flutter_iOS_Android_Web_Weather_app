import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  NetworkHelper(this.url);
  final String url;
  int statusCode;

  Future getData() async {
    http.Response response = await http.get(url);
    statusCode = response.statusCode;
    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      throw (response.statusCode);
    }
  }
}
