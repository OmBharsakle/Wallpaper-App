import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class ApiServices {
  String baseUrl = "https://pixabay.com/api/?key=38641586-c40f23dcd95b444a55b356a04&order=latest&per_page=200";
  static ApiServices apiServices = ApiServices();
  Future<Map> fetchData() async {
    Response response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      Map json = jsonDecode(response.body);
      return json;
    } else {
      throw "unexpected error occurred";
    }
  }
}
