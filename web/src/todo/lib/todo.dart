library todo;

class Todo {
  num id;
  String todoText;
  Date complete;

  Todo(this.todoText);

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
}
