import 'dart:io';
import 'package:backend/todo_controller.dart';
import 'package:/logging/logging.dart';



send404(HttpResponse response) {
  response.statusCode = HttpStatus.NOT_FOUND;
//support HTTP 1.0
  response.contentLength = 19;
  response.outputStream.writeString("404: File not found");
  response.outputStream.close();
}

var mimeTypes = {
  'html': 'text/html',
  'css':  'text/css',
  'js':   'application/javascript',
  'dart': 'application/dart'
};

respondWithFile(File file, requestPath, HttpResponse response) {
  var path = new Path(file.fullPathSync());
  var mimeType = mimeTypes[path.extension];
  mimeType = mimeType != null ? mimeType : 'text/plain';
  print("$requestPath --> $path [$mimeType]");
  response.headers.contentType = new ContentType.fromString(mimeType);
  file.openInputStream().pipe(response.outputStream);
}

startServer() {
    Logger root = Logger.root;
    root.level = Level.INFO;
    root.info("here is a logging message");

    print("Starting Dart server 127.0.0.1:8080");


    var server = new HttpServer();
    server.listen('127.0.0.1', 8080);
    server.defaultRequestHandler = (HttpRequest request, HttpResponse response) {
      

      print("Handling Request ${request.path}");
     

      

      var requestPath = request.path == '/' ? '/index.html' : request.path;

      var file = new File("../../web/src/pub/$requestPath");

      if (file.existsSync()) {

        respondWithFile(file, requestPath, response);
      } else if(TodoController.isTodoRequest.hasMatch(request.path)){
        response.headers.set(HttpHeaders.ACCEPT,'application/json');
        new TodoController().handleTodo(request,response);
        response.outputStream.close();
      } else{
        send404(response);
      }
  };
  }

Future<String> readStreamAsString(InputStream stream) {
  var completer = new Completer();
  var sb = new StringBuffer();
  var sis = new StringInputStream(stream);
  sis..onData = () { sb.add(sis.read()); }
    ..onClosed = () { completer.complete(sb.toString()); }
    ..onError = (e) { completer.completeException(e); };
  return completer.future;
}

  
  main() {
      startServer();
  }
