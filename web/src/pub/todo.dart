import 'dart:html';
import 'json.dart';
import 'package:js/js.dart' as js;

void handleSubmit(Event e) {
  e.preventDefault();
  var input = query("#new-todo input");
  var todoText = input.value;
  if (!todoText.isEmpty) {
    var data = JSON.stringify({'todo': todoText});
    var request = new HttpRequest();

    request.on.readyStateChange.add((Event e) {
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
          input.value = "";
        } else {
          alert = new Element.tag("div");
          alert.attributes['class'] = 'alert alert-error';
          var button = new Element.tag("button")
            ..attributes['type'] = 'button'
            ..attributes['class'] = 'close'
            ..attributes['data-dismiss'] = 'alert'
            ..text = "&times;";
          alert.children.add(button);
          alert.text = "Failed to save Todo!";
        }
        alerts.children.add(alert);
      }
    });

    request.open("POST", "/todos?payload=$data");
    request.send(data);
  }
}

main() {
  var todoForm = query('#new-todo');
  todoForm.on.submit.add(handleSubmit);
}