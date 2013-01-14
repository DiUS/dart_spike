import 'dart:io';
import '../lib/samplenoun_controller.dart';
import 'package:/logging/logging.dart';

  
  send404(HttpResponse response) {
    response.statusCode = HttpStatus.NOT_FOUND;
    //support HTTP 1.0
    response.contentLength = 19;
    response.outputStream.writeString("404: File not found");
    response.outputStream.close();
  }
 


  
  startServer() {
    Logger root = Logger.root;
    root.level = Level.INFO;
    root.info("here is a logging message");

    print("Starting Dart server 127.0.0.1:8080");

    var server = new HttpServer();
    server.listen('127.0.0.1', 8080);
    server.defaultRequestHandler = (HttpRequest request, HttpResponse response) {
      var path = request.path == '/' ? '/index.html' : request.path;

      var file = new File("../../web/src/pub/$path");
      if (file.existsSync()) {
        print("$path --> ${file.fullPathSync()}");
        file.openInputStream().pipe(response.outputStream);
      } else {
      response.headers.set(HttpHeaders.ACCEPT,'application/json');
      if(SamplenounController.isSampleNoun.hasMatch(path)){
        new SamplenounController().handleSampleNoun(request,response);
      } else{
        response.outputStream.write('{a: 5s}'.charCodes);
      }
      response.outputStream.close();
      }

  };
  }
  
  main() {
//      Logger root = Logger.root;
//      root.level = Level.INFO;

      startServer();
  }
  


