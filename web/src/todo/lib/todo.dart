library todo;

class Todo {
  num id;
  String todoText;
  Date complete;

  Todo(this.todoText);
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
