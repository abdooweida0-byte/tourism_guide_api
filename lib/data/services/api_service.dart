import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {

  Future<Map<String,dynamic>> getPlace(String place) async{

    final url = Uri.parse(
      "https://en.wikipedia.org/api/rest_v1/page/summary/$place",
    );

    final response = await http.get(url);

    return jsonDecode(response.body);
  }

}