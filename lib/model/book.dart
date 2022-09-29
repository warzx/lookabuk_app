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
      required this.downloadCount});

  factory Book.createBook(Map<String, dynamic> object) {
    List<Author> authorsList = [];
    if (object["authors"] is List<dynamic>) {
      authorsList = (object["authors"] as List)
          .map((author) => Author.createAuthor(author))
          .toList();
    }

    List<String> subjects = [];
    if (object["subjects"] is List<dynamic>) {
      subjects = (object["subjects"] as List)
          .map((subject) => subject as String)
          .toList();
    }

    List<String> bookshelves = [];
    if (object["bookshelves"] is List<dynamic>) {
      bookshelves = (object["bookshelves"] as List)
          .map((bookshelve) => bookshelve as String)
          .toList();
    }

    String? imageUrl;
    String? htmlUrl;
    if (object["formats"] is Map) {
      Map<String, dynamic> formatsObjects =
          object["formats"] as Map<String, dynamic>;
      if (formatsObjects.containsKey("image/jpeg")) {
        imageUrl = formatsObjects["image/jpeg"] as String;
      }
      if (formatsObjects.containsKey("text/html")) {
        htmlUrl = formatsObjects["text/html"] as String;
      }
    }

    return Book(
        id: object["id"].toString(),
        title: object["title"],
        authors: authorsList,
        subjects: subjects,
        bookshelves: bookshelves,
        copyright: object["copyright"] as bool,
        imageUrl: imageUrl,
        htmlUrl: htmlUrl,
        downloadCount: object["download_count"] as int);
  }
}
