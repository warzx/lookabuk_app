
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

## Model

## UI

## Service

## Summary
