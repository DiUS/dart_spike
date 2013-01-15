library todo;

class Todo {
  num id;
  String todoText;
  Date complete;

  Todo(this.todoText);
  Todo.fromJson(Map jsonMap) : id = jsonMap['id'], todoText = jsonMap['todoText'], complete = jsonMap['complete'] ;

  def isValid() {
    return !todoText.isEmpty;
  }

  def toJson() {
    return {
      'id': id,
      'todoText': todoText,
      'complete': complete
    };
  }

  def toString() {
    return toJson().toString();
  }
}
