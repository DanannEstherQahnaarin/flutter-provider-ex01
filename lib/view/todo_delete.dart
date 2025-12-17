import 'package:flutter/material.dart';
import 'package:flutter_provider_ex01/models/todo.dart';
import 'package:flutter_provider_ex01/provider/todo_provider.dart';
import 'package:provider/provider.dart';

void showDeleteTodoDialog({required Todo todo, required BuildContext context}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      final provider = context.watch<TodoProvider>();

      return AlertDialog(
        title: const Text('알림'),
        content: const Text('삭제하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () {
              provider.deleteToTodoList(todo: todo);
              Navigator.of(context).pop();
            },
            child: const Text('확인'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('취소'),
          ),
        ],
      );
    },
  );
}
