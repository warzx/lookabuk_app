import 'package:flutter/material.dart';
import 'package:lookabuk_app/model/book.dart';
import 'package:lookabuk_app/ui/pages/book_list_result_page.dart';
import 'package:lookabuk_app/ui/pages/webview_page.dart';

class BookDetailPage extends StatelessWidget {
  final Book book;

  const BookDetailPage(this.book, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> authors = [];
    for (var author in book.authors) {
      authors.add(author.name);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(book.title),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Center(
        child: ListView(
          children: [
            Container(
              child: Image.network(
                book.imageUrl ?? "",
                fit: BoxFit.scaleDown,
                height: 400,
              ),
              color: Colors.black.withAlpha(20),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                book.title,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (authors.isNotEmpty) ...[
              const Padding(
                padding: EdgeInsets.only(left: 16.0, top: 16.0),
                child: Text(
                  "Author(s): ",
                  style: TextStyle(fontSize: 16),
                ),
              ),
              for (var author in authors) ...[
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 4.0),
                  child: TextButton(
                    child: Text(author),
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      alignment: Alignment.centerLeft,
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                    onPressed: () {
                      String apiURL = "http://gutendex.com/books/?search=" +
                          Uri.encodeFull(author);
                      String titleHeader = "Search for " + author;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              BookListResultPage(apiURL, titleHeader),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ],
            Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 8.0),
              child: Text(
                "Download count: " + book.downloadCount.toString(),
                style: const TextStyle(fontSize: 16),
              ),
            ),
            if (book.bookshelves.isNotEmpty) ...[
              const Padding(
                padding: EdgeInsets.only(left: 16.0, top: 16.0),
                child: Text(
                  "Bookshelves: ",
                  style: TextStyle(fontSize: 16),
                ),
              ),
              for (var bookshelve in book.bookshelves) ...[
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 4.0),
                  child: Text(
                    bookshelve,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ],
            if (book.subjects.isNotEmpty) ...[
              const Padding(
                padding: EdgeInsets.only(left: 16.0, top: 16.0),
                child: Text(
                  "Subjects: ",
                  style: TextStyle(fontSize: 16),
                ),
              ),
              for (var subject in book.subjects) ...[
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 4.0),
                  child: Text(
                    subject,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ],
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => WebViewPage(book.htmlUrl ?? "")),
          );
        },
        isExtended: true,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        icon: const Icon(Icons.book),
        label: const Text('Read'),
        backgroundColor: Colors.black,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
