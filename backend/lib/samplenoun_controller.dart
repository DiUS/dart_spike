library samplenoun;

import 'dart:io';

class SamplenounController {
  
  
  static final isSampleNoun = new RegExp(r'.*samplenoun/(.*)');
  
  handleSampleNoun(HttpRequest request, HttpResponse response){
    
    var sampleNounId = isSampleNoun.firstMatch(request.path)[1];
    
    //jsonString 
    
    response.outputStream.write('{name: sampleNoun}'.charCodes);
  }
  
  
}
