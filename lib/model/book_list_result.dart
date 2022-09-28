import 'package:lookabuk_app/model/book.dart';

class BookListResult {
  int count; //total books overall (not in 1 API call)
  String? nextAPI;
  String? prevAPI;
  List<Book> books;

  BookListResult(
      {required this.count, this.nextAPI, this.prevAPI, required this.books});
}
