import 'dart:io';

  
  send404(HttpResponse response) {
    response.statusCode = HttpStatus.NOT_FOUND;
    //support HTTP 1.0
    response.contentLength = 19;
    response.outputStream.writeString("404: File not found");
    response.outputStream.close();
  }
  
  startServer() {

    var server = new HttpServer();
    server.listen('127.0.0.1', 8080);
    server.defaultRequestHandler = (HttpRequest request, HttpResponse response) {
      var path = request.path == '/' ? '/index.html' : request.path;
      response.headers.set(HttpHeaders.ACCEPT,'application/json');
      response.outputStream.write('{a: 5s}'.charCodes);
      response.outputStream.close();
  };
  }
  
  main() {
      startServer();
  }
  


