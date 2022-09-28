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
    if (object["authors"] is List<Map<String, dynamic>>) {
      List<Map<String, dynamic>> authorsObjects = object["authors"];
      for (Map<String, dynamic> authorObject in authorsObjects) {
        authorsList.add(Author.createAuthor(authorObject));
      }
    }

    String? imageUrl;
    String? htmlUrl;
    if (object["formats"] is Map<String, String>) {
      Map<String, String> formatsObjects = object["formats"];
      if (formatsObjects.containsKey("image/jpeg")) {
        imageUrl = formatsObjects["image/jpeg"];
      }
      if (formatsObjects.containsKey("text/html")) {
        htmlUrl = formatsObjects["text/html"];
      }
    }

    return Book(
        id: object["id"].toString(),
        title: object["title"],
        authors: authorsList,
        subjects: object["subjects"] as List<String>,
        bookshelves: object["bookshelves"] as List<String>,
        copyright: object["copyright"] as bool,
        imageUrl: imageUrl,
        htmlUrl: htmlUrl,
        downloadCount: object["download_count"] as int);
  }
}
