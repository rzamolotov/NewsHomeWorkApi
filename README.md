# NewsHomeWorkApi

An app based on SwiftUI 3, targeting iOS 15.

Main features:

1) Fetch news from categories.

<img src= "https://user-images.githubusercontent.com/101548647/202839368-e7a0e865-06bb-4e81-8592-f319a75e5e30.png" width="167" height="361"> <img src= "https://user-images.githubusercontent.com/101548647/202839374-35b8a93e-148f-4b5b-84cc-af34aaad1692.png" width="167" height="361">

2) Add to favorite articles so it can be persisted even when the app restarts.

<img src= "https://user-images.githubusercontent.com/101548647/202839394-e83885d2-eea3-41eb-894f-937fffb57453.png" width="167" height="361"> <img src= "https://user-images.githubusercontent.com/101548647/202839403-66a78086-186e-40d5-981c-97bcb12a2cbc.png" width="167" height="361"> 

3) Share article using UIActivityController.

<img src= "https://user-images.githubusercontent.com/101548647/202839420-7f055058-03ed-4326-8e27-850452ebd747.png" width="167" height="361">

4) Read article inside a Safari Webview.


5) Search news based on the search query you type on the search bar. Recent search history list. Suggestion search list.

<img src= "https://user-images.githubusercontent.com/101548647/202839446-5be8ee04-75ab-45ba-88b9-606982552fde.png" width="167" height="361"><img src= "https://user-images.githubusercontent.com/101548647/202839408-776e781b-cc6b-4604-b24c-c68a7555e45c.png" width="167" height="361">


The SwiftUI 3 APIs used to build the app:
1. Async Await, Structured Concurrency, and Actors.
2. Task Lifecycle View Modifer.
3. AsyncImage.
4. Refreshable and SwipeAction on List.
6. Actor to isolate disk persistence.
7. Crafting Search Experience using Swift Searchable modifier. synchronous local search and async remote search, as well as providing search suggestions.
