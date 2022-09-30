import 'package:bloc/bloc.dart';
import 'package:lookabuk_app/model/book_list_result.dart';
import 'package:lookabuk_app/service/book_list_api_service.dart';

abstract class BookListEvent {}

class ClearBookList extends BookListEvent {}

class InitalLoadBookList extends BookListEvent {
  String? initialUrl;
  InitalLoadBookList({this.initialUrl});
}

class LoadMoreBookList extends BookListEvent {
  String nextUrl;
  LoadMoreBookList({required this.nextUrl});
}

class BookListBloc extends Bloc<BookListEvent, BookListResult> {
  BookListBloc(BookListResult initialState) : super(initialState) {
    on<ClearBookList>(
        (event, emit) => emit(BookListResult(count: 0, books: [])));
    on<InitalLoadBookList>((event, emit) async => emit(
        await BookListAPIService.getBookListFromAPI(
            event.initialUrl ?? "http://gutendex.com/books/")));
    on<LoadMoreBookList>((event, emit) async =>
        emit(await BookListAPIService.getBookListFromAPI(event.nextUrl)));
  }
}
