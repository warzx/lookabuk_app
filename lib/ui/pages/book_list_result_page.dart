import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lookabuk_app/bloc/book_list_bloc.dart';
import 'package:lookabuk_app/model/book.dart';
import 'package:lookabuk_app/model/book_list_result.dart';
import 'package:lookabuk_app/ui/components/book_card.dart';
import 'package:lookabuk_app/ui/pages/book_detail_page.dart';

class BookListResultPage extends StatefulWidget {
  String apiURL;
  String titleHeader;

  BookListResultPage(this.apiURL, this.titleHeader, {Key? key})
      : super(key: key);

  @override
  State<BookListResultPage> createState() => _BookListResultPageState();
}

class _BookListResultPageState extends State<BookListResultPage> {
  final _scrollController = ScrollController();
  BookListResult? _result;
  List<Book> _booksResult = [];

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        bool atBottom = _scrollController.position.maxScrollExtent != 0 &&
            _scrollController.position.pixels ==
                _scrollController.position.maxScrollExtent;
        if (atBottom) {
          if (_result != null) {
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
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
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
