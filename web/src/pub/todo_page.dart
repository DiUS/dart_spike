import 'dart:html';
import 'json.dart';
import 'package:js/js.dart' as js;
import 'package:todo/todo.dart';

class TodoView {
  Todo todo;

  TodoView(this.todo);

  def renderTodoHtml() {
    var el = new Element.html(
      '<div id="todo-${this.todo.id}" class="row todo ${completedClass()}" data-id="${this.todo.id}">'
      '  <input class="todo-check" type="checkbox" ${checked()}>'
      '  <div class="todoText">${this.todo.todoText}</div>'
      '  <div class="completedDate">${completed()}</div>'
      '</div>'
    );

    el.on.click.add(handleClick);

    return el;
  }

  def isChecked() {
    return todo.complete != null;
  }

  def checked() {
    return isChecked() ? 'checked="checked"' : '';
  }

  def completed() {
    return todo.complete == null ? '' : todo.complete.toString();
  }

  def completedClass() {
    return todo.complete == null ? '' : 'completed';
  }

  def handleClick(Event e) {
    if (isChecked()) {
      todo.complete = null;
    } else {
      todo.complete = new Date.now();
    }
    var data = JSON.stringify(todo);
    var request = new HttpRequest();
    request.open("PUT", "/todos/${todo.id}?payload=$data");
    request.send(data);
    updateView();
  }

  def updateView() {
    def todoElement = query("#todo-${this.todo.id}");
    todoElement.classes.toggle('completed');
    todoElement.query(".completedDate").text = completed();
  }

  static def fromElement(Element element) {
    def todo = new Todo(element.query(".todoText").text);
    todo.id = element.dataAttributes['id'];
    def complete = element.query(".completedDate").text;
    if (!complete.isEmpty) {
      todo.complete = new Date.fromString(complete);
    }
    return todo;
  }
}

void handleSubmit(Event e) {
  e.preventDefault();
  var input = query("#new-todo input");
  var todo = new Todo(input.value);
  if (todo.isValid()) {
    var data = JSON.stringify(todo);
    var request = new HttpRequest();

    request.on.readyStateChange.add((_) {
      if (request.readyState == HttpRequest.DONE) {
        var alerts = query("#alerts");
        var alert;
        if (request.status == 200) {
          alert = new Element.html(
            '<div class="alert alert-success">'
            '  <button type="button" class="close" data-dismiss="alert">&times;</button>'
            '  Todo created OK.'
            '</div>'
          );
          alerts.children.add(alert);
          input.value = "";
          var json = JSON.parse(request.responseText);
          var view = new TodoView(new Todo.fromJson(json));
          var todoElement = view.renderTodoHtml();
          query('#todo-list').children.add(todoElement);
        } else {
          alert = new Element.tag("div");
          alert.attributes['class'] = 'alert alert-error';
          alert.text = "Failed to save Todo!";
          var button = new Element.tag("button")
            ..attributes['type'] = 'button'
            ..attributes['class'] = 'close'
            ..attributes['data-dismiss'] = 'alert';
          alerts.children.add(alert);
          alert.children.add(button);
          button.children.add(new Element.html("<span>&times;</span>"));
        }
      }
    });

    request.open("POST", "/todos?payload=$data");
    request.send(data);
  }
}

void loadList() {
  def request = new HttpRequest.get('/todos', (request) {
    def json = JSON.parse(request.responseText);
    json.forEach((todoJson) {
      var view = new TodoView(new Todo.fromJson(todoJson));
      query('#todo-list').children.add(view.renderTodoHtml());
    });
  });
}

void handleClearCompleted(Event e) {
  for (var child in query('#todo-list').children) {
    var todo = TodoView.fromElement(child);
    if (todo.complete != null) {
      var data = JSON.stringify(todo);
      var request = new HttpRequest();
      request.open("DELETE", "/todos/${todo.id}");
      child.remove();
    }
  }
}

main() {
  var todoForm = query('#new-todo');
  todoForm.on.submit.add(handleSubmit);

  var deleteButton = query('#delete-button');
  deleteButton.on.click.add(handleClearCompleted);

  // load the current list
  loadList();
}