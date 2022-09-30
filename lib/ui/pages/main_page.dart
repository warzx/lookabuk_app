import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lookabuk_app/bloc/book_list_bloc.dart';
import 'package:lookabuk_app/model/book.dart';
import 'package:lookabuk_app/model/book_list_result.dart';
import 'package:lookabuk_app/ui/components/book_card.dart';
import 'package:lookabuk_app/ui/pages/book_detail_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _scrollController = ScrollController();
  BookListResult? _result;
  List<Book> _booksResult = [];
  FocusNode _textFieldFocusNode = FocusNode();

  @override
  void dispose() {
    _textFieldFocusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        bool atBottom = _scrollController.position.maxScrollExtent != 0 &&
            _scrollController.position.pixels ==
                _scrollController.position.maxScrollExtent;
        if (atBottom) {
          if (_result != null && _result?.nextAPI != null) {
            context
                .read<BookListBloc>()
                .add(LoadMoreBookList(nextUrl: _result?.nextAPI ?? ""));
          }
        }
      }
    });
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback(
        (_) => context.read<BookListBloc>().add(InitalLoadBookList()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          child: TextField(
            focusNode: _textFieldFocusNode,
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(16.0),
                ),
              ),
            ),
            style: const TextStyle(
              fontSize: 16.0,
              color: Colors.black,
            ),
            onChanged: (value) {
              _result = null;
              _booksResult = [];
              String searchUrl =
                  "http://gutendex.com/books/?search=" + Uri.encodeFull(value);
              if (value.isEmpty) {
                context.read<BookListBloc>().add(ClearBookList());
                context.read<BookListBloc>().add(InitalLoadBookList());
              } else {
                context.read<BookListBloc>().add(ClearBookList());
                context
                    .read<BookListBloc>()
                    .add(InitalLoadBookList(initialUrl: searchUrl));
              }
            },
            onEditingComplete: () {
              context.read<BookListBloc>().add(ClearBookList());
              context.read<BookListBloc>().add(InitalLoadBookList());
            },
          ),
          height: 42,
        ),
        actions: const [
          Icon(Icons.search),
          SizedBox(
            width: 16,
          ),
        ],
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: BlocBuilder<BookListBloc, BookListResult>(
        builder: (context, result) {
          _result = result;
          _booksResult.addAll(result.books);
          return Center(
            child: Scrollbar(
              child: _booksResult.isNotEmpty
                  ? ListView.separated(
                      controller: _scrollController,
                      itemCount: _booksResult.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          child: BookCardWidget(_booksResult[index]),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    BookDetailPage(_booksResult[index]),
                              ),
                            );
                          },
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(),
                    )
                  : Container(),
            ),
          );
        },
      ),
    );
  }
}
