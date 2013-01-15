import 'dart:html';
import 'json.dart';
import 'package:js/js.dart' as js;
import 'package:todo/todo.dart';

class TodoView {
  Todo todo;

  TodoView(this.todo);

  def renderTodoHtml() {
    return new Element.html(
      '<div id="todo-${this.todo.id}" class="todo">'
      '  <input type="checkbox" ${isChecked()}>'
      '  <h4>${this.todo.todoText}</h4>'
      '  <div class="completed"></div>'
      '</div>'
    );
  }

  def isChecked() {
    return todo.complete != null ? 'checked="checked"' : '';
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
    json.keys.forEach((key) {
      var view = new TodoView(new Todo.fromJson(json[key]));
      query('#todo-list').children.add(view.renderTodoHtml());
    });
  });
}

main() {
  var todoForm = query('#new-todo');
  todoForm.on.submit.add(handleSubmit);

  // load the current list
  loadList();
}