import 'dart:convert';
import 'package:http/http.dart' as http;

class Author {
  String name;

  Author({this.name});

  factory Author.createAuthor(Map<String, dynamic> object) {
    return Author(
      name: object["name"],
    );
  }
}
