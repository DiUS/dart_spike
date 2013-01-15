library todocontroller;

import 'dart:io';
import 'dart:json'; 
import "package:json_object/json_object.dart";
import 'package:mongo_dart/mongo_dart.dart';
import 'package:todo/todo.dart';

class TodoController {
  
  
  static final isTodoRequest = new RegExp(r'.*todos(/.*)?');

  static final isBaseTodoRequest = new RegExp(r'.*todos$');

  static final isASpecficTodoRequest = new RegExp(r'.*todos/(\d*)$');
  
  static Map todoList = new Map();

  static num nextTodoKey = 1;
  
  
  TodoController(){


    // uncomment the following line to remove all the posts at app startup
    //_posts.remove();
    
  }
  
  handleTodo(HttpRequest request, HttpResponse response){
    
    //var sampleNounId = isTodoRequest.firstMatch(request.path)[1];
    print("handling a todo request");
    print("matches isBaseTodoRequest ${isBaseTodoRequest.hasMatch(request.path)}");
    print("matches isASpecficTodoRequest ${isASpecficTodoRequest.hasMatch(request.path)}");
    
    if(isBaseTodoRequest.hasMatch(request.path)) {
        if(request.method == 'GET') {
          print("the list beiung passed back ${todoList}");
          response.contentLength = JSON.stringify(todoList).length;
          response.outputStream.write(JSON.stringify(todoList).charCodes);
        } else if (request.method == 'POST') {

          setIntoMongo(nextTodoKey,request.queryParameters["payload"]);
          var todo = new Todo.fromJson(JSON.parse(request.queryParameters["payload"]));
          todo.id = nextTodoKey++;
          print("adding $todo to my list");
          todoList[todo.id.toString()] = todo;
          def todoJson = JSON.stringify(todo);
          response.contentLength = todoJson.length;
          response.outputStream.write(todoJson.charCodes);
        }
      } else if(isASpecficTodoRequest.hasMatch(request.path)){
        String matchingTodo = isASpecficTodoRequest.firstMatch(request.path)[1];
        print("is a specfic request for ${matchingTodo}");
        if(request.method == 'GET'){
          String disiredTodo = todoList[matchingTodo];
          print("the requested todo ${disiredTodo} ");
          response.contentLength = JSON.stringify(disiredTodo).length;
          response.outputStream.write(JSON.stringify(disiredTodo).charCodes);
        }
        else if(request.method == 'DELETE'){
          String disiredTodo = todoList.remove(matchingTodo);
        }        
        else if(request.method == 'PUT'){
          String disiredTodo = todoList[matchingTodo] = request.queryParameters["payload"];
        }          
      }
  }

  setIntoMongo(String nextTodoKey, String todoAsJson) {
   
    Db db = new Db("mongodb://127.0.0.1/testdb:27017");
    db.open().then((c){
      print('connection open');//open the connection to mongodb
    DbCollection _posts = db.collection("posts");
    
      print("adding todo: ${todoAsJson}");
      Map todo = JSON.parse(todoAsJson);
      print("parsed json todo ${todo}");
      Map savedBlogPost = new Map();
      savedBlogPost["todo"] = todo["todo"];      //explicitly read and written for purpose of example
      savedBlogPost["id"] = nextTodoKey;  //explicitly read and written for purpose of example
      _posts.insert(savedBlogPost);  //  add the post to mongodb collection
      db.close();
    });


    }
  
  getFromMongo() {
    
    Db db = new Db("mongodb://127.0.0.1/testdb:27017");
    db.open().then((c){
        print("getting stuff from mongo");
        DbCollection _posts = db.collection("posts");
        _posts.find(where.match('todo', '.*')).each((v)=>print(v));
    });


    }
  
}