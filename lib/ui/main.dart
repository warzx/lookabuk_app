import 'package:flutter/material.dart';
import 'package:lookabuk_app/ui/components/book_card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(builder: (BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Lookabuk"),
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
          ),
          body: Center(
            child: ListView.separated(
              itemCount: 50,
              itemBuilder: (BuildContext context, int index) {
                return BookCardWidget();
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
            ),
          ),
        );
      }),
    );
  }
}
