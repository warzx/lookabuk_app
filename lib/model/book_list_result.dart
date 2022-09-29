import 'package:lookabuk_app/model/book.dart';

class BookListResult {
  int count; //total books overall (not in 1 API call)
  String? nextAPI;
  String? prevAPI;
  List<Book> books;

  BookListResult(
      {required this.count, this.nextAPI, this.prevAPI, required this.books});

  factory BookListResult.result(Map<String, dynamic> object) {
    List<Book> bookList = [];

    if (object["results"] is List<dynamic>) {
      bookList = (object["results"] as List)
          .map((book) => Book.createBook(book))
          .toList();
    }

    return BookListResult(
        count: object["count"],
        nextAPI: object["next"],
        prevAPI: object["previous"],
        books: bookList);
  }
}
