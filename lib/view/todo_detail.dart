import 'package:flutter/material.dart';
import 'package:flutter_provider_ex01/models/todo.dart';
import 'package:flutter_provider_ex01/provider/todo_provider.dart';
import 'package:provider/provider.dart';

void showUpdateTodoBottomSheet({required Todo todo, required BuildContext context}) {
  final formKey = GlobalKey<FormState>();
  final TextEditingController txtTitleController = TextEditingController(text: todo.todoTitle);
  final TextEditingController txtContentController = TextEditingController(
    text: todo.todoContent,
  );
  // StatefulBuilder 외부에서 상태 변수 선언 (상태 유지)
  bool isComplate = todo.isComplate;
  DateTime? selectedDate = todo.todoComplateDate;

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (bottomSheetContext) {
      final provider = bottomSheetContext.read<TodoProvider>();
      return StatefulBuilder(
        builder: (builderContext, setState) => Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: txtTitleController,
                  decoration: const InputDecoration(labelText: 'Todo Title'),
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: txtContentController,
                  decoration: const InputDecoration(labelText: 'Todo Content'),
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    const Text('Complate :'),
                    Checkbox(
                      value: isComplate,
                      onChanged: (value) {
                        setState(() {
                          isComplate = value ?? false;
                          // 완료 체크 해제 시 완료일도 초기화
                          if (!isComplate) {
                            selectedDate = null;
                          } else {
                            // 완료 체크 시 완료일이 없으면 현재 시간으로 설정
                            selectedDate = DateTime.now();
                          }
                        });
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 10),
                // 작성일 표시
                Row(
                  children: [
                    const Text('작성일: '),
                    Text(
                      '${todo.todoWriteDate.year}-${todo.todoWriteDate.month.toString().padLeft(2, '0')}-${todo.todoWriteDate.day.toString().padLeft(2, '0')} '
                      '${todo.todoWriteDate.hour.toString().padLeft(2, '0')}:${todo.todoWriteDate.minute.toString().padLeft(2, '0')}',
                    ),
                  ],
                ),
                // 완료일 표시 및 선택 (isComplate가 true일 때만 표시)
                if (isComplate) ...[
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Text('완료일: '),
                      ElevatedButton.icon(
                        onPressed: () async {
                          // DatePicker 표시 (bottomSheetContext 사용)
                          final DateTime? pickedDate = await showDatePicker(
                            context: bottomSheetContext,
                            initialDate: selectedDate ?? DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                            locale: const Locale('ko', 'KR'),
                          );

                          if (pickedDate != null) {
                            // TimePicker 표시 (bottomSheetContext 사용)
                            final TimeOfDay? pickedTime = await showTimePicker(
                              context: bottomSheetContext,
                              initialTime: selectedDate != null
                                  ? TimeOfDay.fromDateTime(selectedDate!)
                                  : TimeOfDay.now(),
                            );

                            if (pickedTime != null) {
                              setState(() {
                                selectedDate = DateTime(
                                  pickedDate.year,
                                  pickedDate.month,
                                  pickedDate.day,
                                  pickedTime.hour,
                                  pickedTime.minute,
                                );
                              });
                            }
                          }
                        },
                        icon: const Icon(Icons.calendar_today),
                        label: const Text('날짜/시간 선택'),
                      ),
                    ],
                  ),
                ],
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(bottomSheetContext);
                      },
                      child: const Text('취소'),
                    ),
                    const SizedBox(width: 15),
                    ElevatedButton(
                      onPressed: () {
                        final Todo updateTodo = Todo(
                          id: todo.id,
                          todoTitle: txtTitleController.text,
                          todoContent: txtContentController.text,
                          isComplate: isComplate,
                          todoWriteDate: todo.todoWriteDate,
                          todoComplateDate: isComplate ? selectedDate : null,
                        );

                        provider.modifyToTodoList(todo: updateTodo);
                        Navigator.pop(bottomSheetContext);
                      },
                      child: const Text('수정'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
