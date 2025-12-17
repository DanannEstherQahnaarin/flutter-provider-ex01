import 'package:flutter/material.dart';
import 'package:flutter_provider_ex01/models/todo.dart';

class TodoProvider extends ChangeNotifier {
  List<Todo> todoList = [];

  void incrementId() {}

  bool addToTodoList({required Todo todo}) {
    try {
      todoList.add(todo);
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  bool modifyToTodoList({required Todo todo}) {
    try {
      if (todoList.isNotEmpty) {
        notifyListeners();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  bool deleteToTodoList({required Todo todo}) {
    try {
      if (todoList.isNotEmpty) {
        notifyListeners();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
