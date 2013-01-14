library samplenoun;

import 'dart:io';

import 'package:/unittest/unittest.dart';
import 'package:backend/samplenoun_controller.dart';




main() {
  test('matches correct get url with id ', () =>
      expect(SamplenounController.isSampleNoun.firstMatch('/samplenoun/3')[1],
             equals('3'))
  );  
  
  test('does not match incorrect url ', () =>
      expect(SamplenounController.isSampleNoun.hasMatch('/notcorrectstuff/3'),
          isFalse)
  );
  
  
}
