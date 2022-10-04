import 'dart:convert';

import 'package:http/http.dart' as http;

class NetworkHelper {
  final String url;
  const NetworkHelper(this.url);

  Future<dynamic> getData() async {
    http.Response response;
    response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return;
    }
  }
}
