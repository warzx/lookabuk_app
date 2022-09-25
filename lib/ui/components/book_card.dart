import 'package:flutter/material.dart';

class BookCardWidget extends StatelessWidget {
  const BookCardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: 16,
        ),
        Image.network(
          "https://www.gutenberg.org/cache/epub/1342/pg1342.cover.medium.jpg",
          fit: BoxFit.contain,
          height: 80,
          width: 80,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text("Book1"),
            SizedBox(
              height: 16,
            ),
            Text("By Samsul"),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }
}