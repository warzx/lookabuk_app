
# lookabuk_app

A book library app to search the books and to show book details.

## App Flow

For the app flow, please check out the diagram below: <br/>
<br/>![lookabuk_app_flow](https://user-images.githubusercontent.com/69043715/193239369-b9ac2369-6d3f-4fec-8c01-45b9dbf3a6bf.png)

In the main page, we show book list and search bar for user to search their favorite books. <br/>
<br/><img width="150" alt="image" src="https://user-images.githubusercontent.com/69043715/193237054-0cbb3803-a9d3-481b-97c8-7fc9a42f84e3.png"><br/>
The book list is maintained by Book List Bloc to update and call the API, for more detail about Bloc, please check out [here](https://pub.dev/packages/flutter_bloc).
Then, when user click one of the book list, the app will be navigated to book detail page.<br/><br/>
<img width="150" alt="image" src="https://user-images.githubusercontent.com/69043715/193238071-bb4d9cf4-6274-4619-9f32-4dc82df446fe.png"><br/>
In this page, it won't be handled by any bloc since the page is stateless and only set initial state (showing and passing the book details). 
This page will show the image of the book, the author(s), download count, bookshelves, and subjects. This page has 2 navigations, first navigation is to book list result page from clicking the author name, showing book list by the author name / associated with the author. The second navigation is the read button, navigating to the webview, showing html version of the book.

When the user lands in book list result page, it will be shown like this: <br/> <br/>
<img width="150" alt="image" src="https://user-images.githubusercontent.com/69043715/193240848-9b8e32e3-84a4-4918-97e8-da94e9a0d303.png"> <br/>
The Book List Result page is managed by a different bloc called book search list bloc, it will handle the book search result list, in this case it will search the author name and show results based on the author name.

When the user lands in webview page, it will be shown like this: <br/> <br/>
<img width="150" alt="image" src="https://user-images.githubusercontent.com/69043715/193241204-d449a3e1-fa80-4c2b-a6c2-117b0aec2d2a.png"><br/>
the page is simple and only show html from the input, in this case the input would be the book html.

## Code Structure

The code structure in this project divided into these groups:
- bloc: bloc(s) for the pages
- model: model(s) needed to provide data / construct widgets
- ui: the ui(s) created for pages and cards
- component: component(s) needed for the page(s)
- pages: page for the app
- service: service for calling the API

## Bloc

In this app, the state management is handled by Bloc, for more information about Bloc, you can click [here](https://pub.dev/packages/flutter_bloc).
For the Bloc, we are using `flutter_bloc` package library to simplify the implementation. <br/><br/> There are 2 pages that use bloc for this app, the first bloc is the book list bloc for the main page (`book_list_bloc.dart`). <br/><br/> The input for this bloc is the event for the bloc called `BookListEvent`. The events are `ClearBookList`, `InitalLoadBookList`, and `LoadMoreBookList`.<br/><br/> `ClearBookList` is the event to clear book list in the main page. It will return empty book list in `BookListResult`. `ClearBookList` is used when user uses the search feature, it will clear the searches or previous book list to set the page to new search results.<br/><br/> `InitalLoadBookList` as the name suggests, is the event to initial load the book list. It is called when main page finished layouting and also when the users searches some keywords. The parameter `initialUrl` is used when user searches so that the API call will be the API call for searching (`?search=..`). <br/><br/> `LoadMoreBookList` is the event to load more book list, it is called when user reached the bottom of the list view and `LoadMoreBookList` will call the next api (if there are more result) from the parameter `nextUrl`.<br/><br/> For the Book List Result page, the bloc is Book Search List Bloc (`book_search_list_bloc.dart`). <br/><br/> The input for this bloc is the event for the bloc called `BookSearchListEvent`. The events are similar with the book list bloc, which are `ClearBookSearchList`, `InitalLoadBookSearchList`, and `LoadMoreBookSearchList`.<br/><br/> `ClearBookSearchList` is the event to clear book list in the main page. It will return empty book list in `BookListResult`. `ClearBookSearchList` is used when user pressed back, it will clear the searches or previous book list to set the page to new search results.<br/><br/> `InitalLoadBookSearchList` as the name suggests, is the event to initial load the book list. It is called when the page finished layouting and also when the users searches some keywords. The parameter `initialUrl` is used to add author name to the url so that it will return book list based on the author name. <br/><br/> `LoadMoreBookSearchList` is the event to load more book list, it is called when user reached the bottom of the list view and `LoadMoreBookSearchList` will call the next api (if there are more result) from the parameter `nextUrl`.

## Model

The models used in this app are:
- `Book`: to set / store book properties such as title, authors, subjects, total downloads, imageUrl, and htmlUrl.
- `Author`: to set / store author property (name).
- `BookListResult`: to store book list result from API call such as prevAPI, nextAPI (for pagination), count (for how many book), and books.

## UI

The UI used in this app are:
- `BookCardWidget`: widget for the book card in book list page, it uses `book` in the parameters to show the image, title and author(s) correctly.
- `BookDetailPage`: the book detail page, it uses `book` in the parameters to show the book details such as the image, title, authors, download count, bookshelves, and subjects.
- `BookListResultPage`: the book list result page, it was created to show the book list result based on the `apiURL` that passed to this page, but now is used to shows the book list based on the author. It also needed `titleHeader` to show the title in the `AppBar`.
- `MainPage`: the main page, it is created to show the book list and the search bar in `AppBar`.
- `WebViewPage`: the webview page, it is created to show html contents in the page, it needed `url` for the html url.

## Service

The service used in this app is only one, `BookListAPIService`, the service is only has one function, which is `getBookListFromAPI` and it needed `apiURL` to call the API and return `BookListResult`. For this service, we use [http package](https://pub.dev/packages/http) to make implementation for API calling easy.

## Summary
The app is made to scale by using functional terms for some of the pages (ex. `BookListResultPage`, `WebViewPage`) to make sure the reusability of the widget / page. However, the app could do some improvement, for example to add some transitions when calling API, like calling shimmer view by using Bloc (ex. `ShowLoading` event bloc) so that user can notice that the app is calling the API.
