import 'package:flutter/material.dart';
import 'package:lookabuk_app/model/book.dart';

class BookCardWidget extends StatelessWidget {
  final Book book;

  const BookCardWidget(this.book, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: 16,
        ),
        Image.network(
          book.imageUrl ?? "",
          fit: BoxFit.contain,
          height: 160,
          width: 80,
        ),
        const SizedBox(
          width: 16,
        ),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(book.title),
              const SizedBox(
                height: 16,
              ),
              Text(book.authors.isNotEmpty ? book.authors[0].name : ""),
            ],
          ),
        ),
        const SizedBox(
          width: 16,
        ),
      ],
    );
  }
}
