import 'package:flutter/material.dart';
import 'package:flutter_provider_ex01/models/todo.dart';

/// TodoProvider는 할 일(todo) 데이터를 제공 및 관리하고,
/// 상태 변경 시 리스너(위젯 등)에게 알리는 ChangeNotifier 클래스입니다.
class TodoProvider extends ChangeNotifier {
  /// 전체 할 일 목록을 저장하는 리스트입니다.
  List<Todo> todoList = [];

  int get listLength => todoList.length;

  /// (기능 구현 예정) todo의 id를 증가시키는 메서드입니다.
  void incrementId() {}

  /// 새로운 할 일(todo)을 [todoList]에 추가합니다.
  /// 추가 성공 시 true, 실패 시 false를 반환합니다.
  /// 추가 후 리스너에게 변경 사항을 알립니다.
  bool addToTodoList({required String title, required String content}) {
    try {
      int todoId = 0;
      if (todoList.length > 0) {
        todoId = todoList.map((t) => t.id).reduce((a, b) => a > b ? a : b) + 1;
      } else {
        todoId = 1;
      }

      final Todo todo = Todo(
        id: todoId,
        todoTitle: title,
        todoContent: content,
        isComplate: false,
        todoWriteDate: DateTime.now(),
      );

      todoList.add(todo);
      notifyListeners(); // 변경 알림
      return true;
    } catch (e) {
      return false;
    }
  }

  /// 기존 할 일(todo)을 [todoList]에서 찾아 수정합니다.
  /// 수정 성공 시 true, 실패 시 false를 반환합니다.
  /// 수정 후 리스너에게 변경 사항을 알립니다.
  bool modifyToTodoList({required Todo todo}) {
    bool result = false;
    try {
      // 동일한 id를 갖는 항목의 인덱스를 찾습니다.
      final int index = todoList.indexWhere((t) => t.id == todo.id);

      // 해당 항목이 존재할 경우 리스트 값을 수정합니다.
      if (index != -1) {
        todoList[index] = todo;
        notifyListeners(); // 변경 알림
        result = true;
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    return result;
  }

  /// 할 일(todo)을 [todoList]에서 삭제합니다.
  /// 삭제 성공 시 true, 실패 시 false를 반환합니다.
  /// 삭제 후 리스너에게 변경 사항을 알립니다.
  bool deleteToTodoList({required Todo todo}) {
    bool result = false;
    try {
      // id가 일치하는 모든 항목을 삭제합니다.
      todoList.removeWhere((item) => item.id == todo.id);
      notifyListeners(); // 변경 알림
      result = true;
    } catch (e) {
      debugPrint(e.toString());
    }
    return result;
  }
}
