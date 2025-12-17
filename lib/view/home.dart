import 'package:flutter/material.dart';
import 'package:flutter_provider_ex01/provider/todo_provider.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
                  Icon(todo.isComplate ? Icons.check : Icons.check_box_sharp),
                  Text(todo.todoTitle),
                ],
              ),
              subtitle: Text('작성일:${todo.todoWriteDate}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () => AlertDialog(
                      content: const Text('삭제하시겠습니까?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('취소'),
                        ),
                        TextButton(
                          onPressed: () {
                            provider.deleteToTodoList(todo: todo);
                          },
                          child: const Text('삭제'),
                        ),
                      ],
                    ),
                    icon: const Icon(Icons.delete),
                  ),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.open_in_new)),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {}),
    );
  }
}
