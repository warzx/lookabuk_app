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
    if (object["results"] is List<Map<String, dynamic>>) {
      List<Map<String, dynamic>> booksObjects = object["results"];
      for (Map<String, dynamic> bookObject in booksObjects) {
        bookList.add(Book.createBook(bookObject));
      }
    }

    return BookListResult(
        count: object["count"],
        nextAPI: object["next"],
        prevAPI: object["previous"],
        books: bookList);
  }
}
