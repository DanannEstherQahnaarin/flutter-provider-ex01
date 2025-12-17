import 'package:flutter/material.dart';
import 'package:flutter_provider_ex01/models/todo.dart';
import 'package:flutter_provider_ex01/provider/todo_provider.dart';
import 'package:provider/provider.dart';

/// showDeleteTodoDialog
/// - 특정 Todo 항목 삭제 확인을 위한 AlertDialog(확인/취소 다이얼로그)를 표시합니다.
/// - [todo]: 삭제 대상 Todo 객체
/// - [context]: BuildContext
/// 
/// [동작 상세]
/// 1. 확인(확인 버튼) 선택 시:
///    - TodoProvider의 deleteToTodoList 메서드 호출하여 해당 Todo 삭제 시도
///    - 삭제 후 다이얼로그 닫힘
/// 2. 취소(취소 버튼) 선택 시:
///    - 삭제 동작 없이 단순 다이얼로그 닫힘
void showDeleteTodoDialog({required Todo todo, required BuildContext context}) {
  showDialog(
    context: context,
    builder: (BuildContext dialogContext) {
      // TodoProvider를 context를 통해 접근 (상태 관리 목적)
      final provider = dialogContext.watch<TodoProvider>();

      return AlertDialog(
        // 다이얼로그 상단 타이틀
        title: const Text('알림'),
        // 다이얼로그 본문 텍스트
        content: const Text('삭제하시겠습니까?'),
        actions: [
          // [확인] 버튼: 삭제 수행 및 다이얼로그 종료
          TextButton(
            onPressed: () {
              provider.deleteToTodoList(todo: todo);
              Navigator.of(dialogContext).pop();
            },
            child: const Text('확인'),
          ),
          // [취소] 버튼: 삭제 없이 종료
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
            },
            child: const Text('취소'),
          ),
        ],
      );
    },
  );
}
