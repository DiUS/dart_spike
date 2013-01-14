library samplenoun;

import 'dart:io';
import 'package:/unittest/unittest.dart';


class SamplenounController {
  

  
  
  static final isSampleNoun = new RegExp(r'.*samplenoun////(.*)');
  
  handleSampleNoun(HttpRequest request, HttpResponse response){
    
    
    response.outputStream.write('{name: sampleNoun}'.charCodes);
  }
  
  
}


main() {
  test('matches correct url ', () =>
      expect(SamplenounController.isSampleNoun.hasMatch('//samplenoun//3'),
          isTrue)
  );  
  
  
}
