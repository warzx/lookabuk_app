import 'package:bloc/bloc.dart';
import 'package:lookabuk_app/model/book_list_result.dart';
import 'package:lookabuk_app/service/book_list_api_service.dart';

abstract class BookListEvent {}

class InitalLoadBookList extends BookListEvent {}

class LoadMoreBookList extends BookListEvent {
  String nextUrl;
  LoadMoreBookList({required this.nextUrl});
}

class BookListBloc extends Bloc<BookListEvent, BookListResult> {
  BookListBloc(BookListResult initialState) : super(initialState) {
    on<InitalLoadBookList>((event, emit) async => emit(
        await BookListAPIService.getBookListFromAPI(
            "http://gutendex.com/books/")));
    on<LoadMoreBookList>((event, emit) async =>
        emit(await BookListAPIService.getBookListFromAPI(event.nextUrl)));
  }
}
