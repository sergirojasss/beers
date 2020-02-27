# beers

Developing this app for a recruitment exercise and also trying to refresh myself after 1 year without coding.
Let's go!!

### What does this app should do?
The app mission is to give a list of beers (getting it from a REST API).
The user can type in a meal, and the app will show him the best beers to eat with that meal.
The app have to be no-connection friendly. It must work if user lose connection.

Known weak points.

- No Connection. If no Internet connection the very first time, showing an empty list without warning the user
 - Design, I'd like to spend more time on designing the UI. Not only for makeing the app more handsome, but for all the structure on back of it. Centralizing fonts and colours and creating custom in-app themes
 - Navigation. This app is a recruitment exercise, I felt like showing more skills the way I made the "detail" view than doing a classic navigation controller and going to detail. (so, at the end, this one maybe it's not a weak point :])
 - Memory friendly. Right now, not checking if memory space. In case the beer list was very very large, the device memory could be compromised makeing app crash. 
 - RxSwift. I'd like to use this project to learn how to program with Rx libraries, not done yet. But It's something I'd like to learn in a close future
