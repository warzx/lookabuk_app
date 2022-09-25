import 'package:flutter/material.dart';

class BookDetailPage extends StatelessWidget {
  const BookDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book Detail"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: ListView(
        children: [
          Container(
            child: Image.network(
              "https://www.gutenberg.org/cache/epub/1342/pg1342.cover.medium.jpg",
              fit: BoxFit.scaleDown,
              height: 400,
            ),
            color: Colors.black.withAlpha(20),
          ),
          Text(
            "Pride and Prejudice",
          ),
        ],
      ),
    );
  }
}
