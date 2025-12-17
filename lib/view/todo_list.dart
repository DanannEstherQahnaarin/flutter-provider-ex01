import 'package:flutter/material.dart';
import 'package:flutter_provider_ex01/provider/todo_provider.dart';
import 'package:flutter_provider_ex01/view/todo_add.dart';
import 'package:flutter_provider_ex01/view/todo_delete.dart';
import 'package:flutter_provider_ex01/view/todo_detail.dart';
import 'package:provider/provider.dart';

/// TodoList 기능 상세
/// 
/// 1. 할 일(Todo) 목록을 리스트 형태로 표시
///   - 각 항목에 완료/미완료 체크박스 아이콘과 제목 표시
///   - 작성일 텍스트(날짜/시간) 표시
/// 2. 각 항목 우측에 [삭제], [수정] 아이콘 버튼 제공
///   - [삭제] 클릭 시 삭제 확인 다이얼로그 호출 (showDeleteTodoDialog)
///   - [수정] 클릭 시 수정용 모달 BottomSheet 호출 (showUpdateTodoBottomSheet)
/// 3. 하단 플로팅액션버튼(FAB) 제공
///   - 클릭 시 신규 Todo 추가용 바텀시트 표시 (showAddTodoBottomSheet)
/// 4. Provider와 연동하여 상태 변화 시 자동 갱신
///   - context.watch<TodoProvider>()로 todoList, listLength 감지

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TodoProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Todo List')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView.builder(
          itemCount: provider.listLength,
          itemBuilder: (context, index) {
            final todo = provider.todoList[index];

            return ListTile(
              // (1) 체크박스(완료 여부) + 제목 표시
              title: Row(
                children: [
                  Icon(
                    todo.isComplate
                        ? Icons.check_box_outlined
                        : Icons.check_box_outline_blank_sharp,
                  ),
                  Text(todo.todoTitle),
                ],
              ),
              // (2) 작성일 정보
              subtitle: Text('작성일:${todo.todoWriteDate}'),
              // (3) 삭제/수정 버튼
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () => showDeleteTodoDialog(todo: todo, context: context),
                    icon: const Icon(Icons.delete),
                  ),
                  IconButton(
                    onPressed: () => showUpdateTodoBottomSheet(todo: todo, context: context),
                    icon: const Icon(Icons.open_in_new),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      // (4) 새로운 Todo 추가용 FAB
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddTodoBottomSheet(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
