import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class ApiSearch {
  static final ApiSearch apiSearch = ApiSearch();

  Future<Map> fetchSearchData(String query) async {
    final String url = "https://pixabay.com/api/?key=38641586-c40f23dcd95b444a55b356a04&q=$query&per_page=200&order=trending&orientation=vertical&min_width=1080&min_height=2400";
    Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      Map json = jsonDecode(response.body);
      return json;
    } else {
      throw "Unexpected error occurred";
    }
  }
}
