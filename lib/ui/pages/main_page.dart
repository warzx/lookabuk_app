import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lookabuk_app/bloc/book_list_bloc.dart';
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

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        bool atBottom = _scrollController.position.maxScrollExtent != 0 &&
            _scrollController.position.pixels ==
                _scrollController.position.maxScrollExtent;
        if (atBottom) {}
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context.read<BookListBloc>().add(InitalLoadBookList());
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          child: const TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(16.0),
                ),
              ),
            ),
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.black,
            ),
          ),
          height: 42,
        ),
        actions: [
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
          return Center(
            child: Scrollbar(
              child: ListView.separated(
                controller: _scrollController,
                itemCount: result.books.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    child: BookCardWidget(result.books[index]),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const BookDetailPage(),
                        ),
                      );
                    },
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
              ),
            ),
          );
        },
      ),
    );
  }
}
