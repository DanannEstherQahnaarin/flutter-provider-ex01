import 'package:flutter/material.dart';
import 'package:flutter_provider_ex01/provider/todo_provider.dart';
import 'package:flutter_provider_ex01/view/todo_add.dart';
import 'package:flutter_provider_ex01/view/todo_delete.dart';
import 'package:flutter_provider_ex01/view/todo_detail.dart';
import 'package:provider/provider.dart';

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
              subtitle: Text('작성일:${todo.todoWriteDate}'),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddTodoBottomSheet(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
