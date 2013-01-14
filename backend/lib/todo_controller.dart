library todocontroller;

import 'dart:io';
import 'dart:json'; 
import "package:json_object/json_object.dart";
import 'package:mongo_dart/mongo_dart.dart';


class TodoController {
  
  
  
  static final isTodoRequest = new RegExp(r'.*todo(/.*)?');

  static final isCreateTodoRequest = new RegExp(r'.*todo$');
  
  static List todoList = new List();
  
  handleTodo(HttpRequest request, HttpResponse response){
    
    var sampleNounId = isTodoRequest.firstMatch(request.path)[1];
    print(request.path);
    print("matches isCreateTodoRequest ${isCreateTodoRequest.hasMatch(request.path)}");
    
    if(isCreateTodoRequest.hasMatch(request.path)){
    if(request.method == 'GET'){
      todoList.forEach((todo)=>print(todo));
    }else if (request.method == 'POST'){
      print("it is post");
    }
    else{
      print("it is smothing else");
    }
    }
    
    
    //jsonString 
    
//    Db db = new Db("mongodb://127.0.0.1/mongo_dart-blog");
//    
//      DbCollection coll = db.collection('collection-for-save');
//      coll.remove();
//      List toInsert = [
//                       {"name":"a", "value": 10},
//                       {"name":"b", "value": 20},
//                       {"name":"c", "value": 30},
//                       {"name":"d", "value": 40}
//                       ];
//      coll.insertAll(toInsert);
//      coll.findOne({"name":"c"}).then((v1){
//        print("Record c: $v1");
//        v1["value"] = 31;
//        coll.save(v1);
//        return coll.findOne({"name":"c"});
//      }).then((v2){
//        print("Record c after update: $v2");
//        db.close();
//      });
//    };
    
//    db.open();
//    coll.insertAll([{'login':'jdoe', 'name':'John Doe',
//      'email':'hello@doe.com'},
//      {'login':'lsmith', 'name':'Lucy Smith',
//      'email':'hello2@smith.com'}]);
//    
//    
//    coll.find().each((user)=>print(user));
//    
//    db.close();
//    
    
    Language data = new JsonObject();
    data.type = "hello";
    
    
    
    
    
    response.outputStream.write(JSON.stringify(data).charCodes);
  }
  
 
  
  
}