import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lookabuk_app/bloc/book_list_bloc.dart';
import 'package:lookabuk_app/model/book_list_result.dart';
import 'package:lookabuk_app/ui/pages/main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (_) => BookListBloc(BookListResult(count: 0, books: [])),
        child: MainPage(),
      ),
    );
  }
}
