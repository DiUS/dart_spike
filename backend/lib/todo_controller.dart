library todocontroller;

import 'dart:io';
import 'dart:json'; 
import "package:json_object/json_object.dart";
import 'package:mongo_dart/mongo_dart.dart';


class TodoController {
  
  
  
  static final isTodoRequest = new RegExp(r'.*todos(/.*)?');

  static final isBaseTodoRequest = new RegExp(r'.*todos$');
  
  static Map todoList = new Map();

  static num nextTodoKey = 1;
  
  
  handleTodo(HttpRequest request, HttpResponse response){
    
    //var sampleNounId = isTodoRequest.firstMatch(request.path)[1];
    print("handling a todo request");
    print("matches isBaseTodoRequest ${isBaseTodoRequest.hasMatch(request.path)}");
    
    if(isBaseTodoRequest.hasMatch(request.path)){
      if(request.method == 'GET'){

        response.outputStream.write(JSON.stringify(todoList).charCodes);
        print("the list beiung passed back ${todoList.forEach((todo)=>print(todo))}");
      }else if (request.method == 'POST'){

        print("adding ${request.queryParameters["payload"]} to my list");
        todoList[nextTodoKey++] = request.queryParameters["payload"];
      }
      else{
        print("it is smothing else");
      }
    }
    
    
    Language data = new JsonObject();
    data.type = "hello";
    
    
    
    
    
    response.outputStream.write(JSON.stringify(data).charCodes);
  }
  

 
  
  
}