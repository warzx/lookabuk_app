import 'package:bloc/bloc.dart';
import 'package:lookabuk_app/model/book_list_result.dart';
import 'package:lookabuk_app/service/book_list_api_service.dart';

abstract class BookSearchListEvent {}

class ClearBookSearchList extends BookSearchListEvent {}

class InitalLoadBookSearchList extends BookSearchListEvent {
  String initialUrl;
  InitalLoadBookSearchList({required this.initialUrl});
}

class LoadMoreBookSearchList extends BookSearchListEvent {
  String nextUrl;
  LoadMoreBookSearchList({required this.nextUrl});
}

class BookSearchListBloc extends Bloc<BookSearchListEvent, BookListResult> {
  BookSearchListBloc(BookListResult initialState) : super(initialState) {
    on<ClearBookSearchList>(
        (event, emit) => emit(BookListResult(count: 0, books: [])));
    on<InitalLoadBookSearchList>((event, emit) async =>
        emit(await BookListAPIService.getBookListFromAPI(event.initialUrl)));
    on<LoadMoreBookSearchList>((event, emit) async =>
        emit(await BookListAPIService.getBookListFromAPI(event.nextUrl)));
  }
}
