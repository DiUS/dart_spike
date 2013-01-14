import 'dart:io';
import 'samplenoun_controller.dart';
//import 'package:/logging/logging.dart';

  
  send404(HttpResponse response) {
    response.statusCode = HttpStatus.NOT_FOUND;
    //support HTTP 1.0
    response.contentLength = 19;
    response.outputStream.writeString("404: File not found");
    response.outputStream.close();
  }
 


  
  startServer() {
//    Logger root = Logger.root;
//    root.level = Level.INFO;
//    root.info("here is a logging message");


    var server = new HttpServer();
    server.listen('127.0.0.1', 8080);
    server.defaultRequestHandler = (HttpRequest request, HttpResponse response) {
      var path = request.path == '/' ? '/index.html' : request.path;
      StringBuffer sb = new StringBuffer('Hello, caoilte your path is ');
      sb.add(path);
      print(sb);

      response.headers.set(HttpHeaders.ACCEPT,'application/json');
      if(SamplenounController.isSampleNoun.hasMatch(path)){
        new SamplenounController().handleSampleNoun(request,response);
      } else{
        response.outputStream.write('{a: 5s}'.charCodes);
      }
      response.outputStream.close();
  };
  }
  
  main() {
      startServer();
  }
  


