# Open-Todo API
This repo was forked from [Bloc/open-todo](https://github.com/Bloc/open-todo) as part of an assignment for the [Bloc](http://bloc.io) full stack web development program.
## What it does
Open-Todo is an app for making lists of to-do items.  The API allows users, lists, and to-dos to be made from the command line.
## How to do that
### Use cURL
Data must be formatted as JSON, don't forget to escape the quotes.

Note: Open-Todo API is not in production, any requests would be done locally.

(**Warning**: this can be rather tedious.)
#### Users
To make a user
 ```
curl -X POST -H "Content-type:application/json" -d "{\"username\": \"yourusername\",
\"password\": \"yourpass\"}" http://localhost:3000/api/users
```
If successful, the response will show your user id, username, and access token.
**You will need this token to be authenticated in other requests, please keep it in a safe place.**
You will also need your user id should you wish to delete your account.

To delete a user
```
curl -X DELETE -H 'Authorization:Token token="yourreallylongtokenreceivedonsignup"'
http://localhost:3000/api/users/id
```
#### Lists
To make a list
```
curl -X POST -H 'Authorization:Token token="yourreallylongtokenreceivedonsignup"'
-H "Content-type:application/json" -d "{\"name\": \"listname\", \"permissions\": \"permission\"}" http://localhost:3000/api/lists
```
Permissions options:
 "open" - These lists can be viewed and modified by any user.
 "visible" - These lists can be viewed by any user but only modified by owner.
 "private" -  These lists can only be viewed and modified by owner.

The id will be needed if you choose to update or destroy a list as well as make or delete an item on that list.  This can also be found in the list index.

To update a list
```
curl -X PATCH -H 'Authorization:Token token="yourreallylongtokenreceivedonsignup"'
-H "Content-type:application/json" -d "{\"name\": \"listname\", \"permissions\": 
\"permission\"}" http://localhost:3000/api/lists/id
```

To delete a list
```
curl -X DELETE -H 'Authorization:Token token="yourreallylongtokenreceivedonsignup"'
http://localhost:3000/api/lists/id
```

To view the list index
 To view your lists:
```
curl -H 'Authorization:Token token="yourreallylongtokenreceivedonsignup"'
http://localhost:3000/api/lists
```
To view other open and visible lists:
```
curl http://localhost:3000/api/lists
```

To view a list
```
curl -H 'Authorization:Token token="yourreallylongtokenreceivedonsignup"'
http://localhost:3000/api/lists/id
```
#### Items
To make an item for a list
```
curl -X POST -H 'Authorization:Token token="yourreallylongtokenreceivedonsignup"'
-H "Content-type:application/json" -d "{\"description\": \"item\"}"
http://localhost:3000/api/lists/list_id/items
```

To mark an item as completed
```
curl -X DELETE -H 'Authorization:Token token="yourreallylongtokenreceivedonsignup"'
http://localhost:3000/api/list_id/items/item_id
```