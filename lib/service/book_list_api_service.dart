import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lookabuk_app/model/book_list_result.dart';

class BookListAPIService {
  static Future<BookListResult> getBookListFromAPI(String apiURL) async {
    Uri url = Uri.parse(apiURL);
    var apiResult = await http.get(url);
    var jsonObject = json.decode(apiResult.body) as Map<String, dynamic>;

    return BookListResult.result(jsonObject);
  }
}
