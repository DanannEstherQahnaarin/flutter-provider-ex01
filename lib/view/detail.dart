import 'package:flutter/material.dart';
import 'package:flutter_provider_ex01/models/todo.dart';

void showTodoDetail({required Todo todo, required BuildContext context}) {
  final formKey = GlobalKey<FormState>();
  final TextEditingController txtTitleController = TextEditingController(text: todo.todoTitle);
  final TextEditingController txtContentController = TextEditingController(
    text: todo.todoContent,
  );

  showBottomSheet(
    context: context,
    builder: (context) => Padding(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: txtTitleController,
              decoration: const InputDecoration(labelText: 'Todo Title'),
            ),
            const Divider(),
            TextFormField(
              controller: txtContentController,
              decoration: const InputDecoration(labelText: 'Todo Content'),
            ),
            const Divider(),
            Checkbox(value: todo.isComplate, onChanged: (value) {}),
            // todo.todoWriteDate 정보를 표시 (읽기 전용)
            Row(
              children: [
                const Text('작성일: '),
                Text(
                  '${todo.todoWriteDate.year}-${todo.todoWriteDate.month.toString().padLeft(2, '0')}-${todo.todoWriteDate.day.toString().padLeft(2, '0')} '
                  '${todo.todoWriteDate.hour.toString().padLeft(2, '0')}:${todo.todoWriteDate.minute.toString().padLeft(2, '0')}',
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
