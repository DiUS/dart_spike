library samplenoun;

import 'dart:io';

import 'package:/unittest/unittest.dart';
import 'package:backend/todo_controller.dart';




main() {
  test('matches correct get url with id ', () =>
      expect(TodoController.isTodoRequest.hasMatch('/todo'),
             isTrue)
  );  
  
  test('does not match incorrect url ', () =>
      expect(TodoController.isTodoRequest.hasMatch('/notcorrectstuff/3'),
          isFalse)
  );
  
  
}
