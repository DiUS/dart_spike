library todo;

class Todo {
  String id;
  String todoText;
  Date complete;

  Todo(this.todoText);
  
  
  Todo.fromBson(Map bsonMap) : todoText = bsonMap['todoText'], complete = bsonMap['complete'] {
    id =  bsonMap['_id'].value.toString();
    print("this is waht the bson map looks like ${bsonMap}");
    if (complete == 'null') {
      complete = null;
    } else {
      complete = new Date.fromString(complete);
    }
  }
  
  Todo.fromJson(Map jsonMap) : id = jsonMap['id'], todoText = jsonMap['todoText'], complete = jsonMap['complete'] {
    if (complete == 'null') {
      complete = null;
    } else {
      complete = new Date.fromString(complete);
    }
  }


  def isValid() {
    return !todoText.isEmpty;
  }

  def toJson() {
    return {
      'id': id,
      'todoText': todoText,
      'complete': complete.toString()
    };
  }

  def toString() {
    return toJson().toString();
  }
}
