import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lookabuk_app/model/author.dart';

class Book {
  String id;
  String title;
  List<Author> authors;
  List<String> subjects;
  List<String> bookshelves;
  bool copyright;
  String? imageUrl;
  String? htmlUrl;
  int downloadCount;

  Book(
      {required this.id,
      required this.title,
      required this.authors,
      required this.subjects,
      required this.bookshelves,
      required this.copyright,
      this.imageUrl,
      this.htmlUrl,
      required this.downloadCount},
     );
}
