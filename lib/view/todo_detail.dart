import 'package:flutter/material.dart';
import 'package:flutter_provider_ex01/models/todo.dart';
import 'package:flutter_provider_ex01/provider/todo_provider.dart';
import 'package:provider/provider.dart';

/// showUpdateTodoBottomSheet
/// - 특정 Todo 항목의 내용을 수정할 수 있는 Modal Bottom Sheet를 표시합니다.
/// - [todo]: 수정 대상 Todo 객체
/// - [context]: BuildContext
/// 
/// [기능 상세]
/// 1. 제목, 내용은 텍스트 입력 폼으로 초기값 세팅(기존값)
/// 2. 'Complate' 체크박스: 완료 여부 수정
///    - 체크/해제 시 완료일(selectedDate) 관리
/// 3. 완료 체크 시 '완료일' 필드와 날짜/시간 선택 버튼 노출
///    - 버튼 클릭 시 DatePicker 및 TimePicker 연동으로 날짜/시간 설정
/// 4. 하단에 [취소], [수정] 버튼 배치
///    - [취소]: BottomSheet 닫기(수정 미적용)
///    - [수정]: 제목/내용/상태 정보를 반영하여 수정 Provider 호출, BottomSheet 닫기
/// 5. 작성일 영역은 단순 텍스트로 표시(수정 불가)
void showUpdateTodoBottomSheet({required Todo todo, required BuildContext context}) {
  final formKey = GlobalKey<FormState>();

  // 텍스트 입력 컨트롤러에 기존 Todo 데이터 할당
  final TextEditingController txtTitleController = TextEditingController(text: todo.todoTitle);
  final TextEditingController txtContentController = TextEditingController(
    text: todo.todoContent,
  );
  // StatefulBuilder 외부에서 상태 변수 선언 (상태 유지 목적)
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
                // 제목 입력 폼
                TextFormField(
                  controller: txtTitleController,
                  decoration: const InputDecoration(labelText: 'Todo Title'),
                ),
                const SizedBox(height: 15),
                // 내용 입력 폼
                TextFormField(
                  controller: txtContentController,
                  decoration: const InputDecoration(labelText: 'Todo Content'),
                ),
                const SizedBox(height: 15),
                // 완료 체크박스
                Row(
                  children: [
                    const Text('Complate :'),
                    Checkbox(
                      value: isComplate,
                      onChanged: (value) {
                        setState(() {
                          isComplate = value ?? false;
                          // 완료 체크 해제 시 완료일 초기화, 체크 시 현재 시간 할당(없을 때)
                          if (!isComplate) {
                            selectedDate = null;
                          } else {
                            selectedDate = DateTime.now();
                          }
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // 작성일 표시 영역(수정 불가)
                Row(
                  children: [
                    const Text('작성일: '),
                    Text(
                      '${todo.todoWriteDate.year}-${todo.todoWriteDate.month.toString().padLeft(2, '0')}-${todo.todoWriteDate.day.toString().padLeft(2, '0')} '
                      '${todo.todoWriteDate.hour.toString().padLeft(2, '0')}:${todo.todoWriteDate.minute.toString().padLeft(2, '0')}',
                    ),
                  ],
                ),
                // 완료 상태면 완료일 선택 및 표시 UI 추가
                if (isComplate) ...[
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Text('완료일: '),
                      ElevatedButton.icon(
                        onPressed: () async {
                          // (1) 완료날짜 선택(DatePicker)
                          final DateTime? pickedDate = await showDatePicker(
                            context: bottomSheetContext,
                            initialDate: selectedDate ?? DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                            locale: const Locale('ko', 'KR'),
                          );
                          if (pickedDate != null) {
                            // (2) 완료시간 선택(TimePicker)
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
                // 하단 버튼 영역
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // 취소 버튼: BottomSheet 닫기
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(bottomSheetContext);
                      },
                      child: const Text('취소'),
                    ),
                    const SizedBox(width: 15),
                    // 수정 버튼: 입력값 토대로 Todo 수정, BottomSheet 닫기
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
