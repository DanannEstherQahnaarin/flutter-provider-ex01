class Todo {
  int id;
  final String todoTitle;
  final String todoContent;
  final bool isComplate;
  final DateTime todoWriteDate;
  DateTime? todoComplateDate;

  Todo({
    required this.id,
    required this.todoTitle,
    required this.todoContent,
    required this.isComplate,
    required this.todoWriteDate,
    this.todoComplateDate,
  });

  Todo setTodo({
    required int id,
    required String title,
    required String content,
    required bool isComplate,
  }) => Todo(
    id: id,
    todoTitle: title,
    todoContent: content,
    isComplate: isComplate,
    todoWriteDate: DateTime.now(),
  );
}
