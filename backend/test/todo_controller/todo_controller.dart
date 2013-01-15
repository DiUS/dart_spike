library samplenoun;

import 'dart:io';

import 'package:/unittest/unittest.dart';
import 'package:backend/todo_controller.dart';




main() {
  test('matches correct base url ', () =>
      expect(TodoController.isTodoRequest.hasMatch('/todos'),
             isTrue)
  );  
  
  test('matches correct base url wit id', () =>
      expect(TodoController.isTodoRequest.hasMatch('/todos/12'),
             isTrue)
  );  
  
  test('does not match incorrect url ', () =>
      expect(TodoController.isTodoRequest.hasMatch('/notcorrectstuff/3'),
          isFalse)
  );
  
  test('gets id from spefic todo url ', () =>
      expect(TodoController.isASpecficTodoRequest.firstMatch('/todos/3')[1],
          equals('3'))
  );
  
  
}
