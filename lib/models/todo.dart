class Todo {
  int _id = 0;
  String _todoTitle = '';
  String _todoContent = '';
  bool _isComplate = false;
  DateTime _todoWriteDate = DateTime.now();
  DateTime? _todoComplateDate = null;

  String get title => _todoTitle;
  String get content => _todoContent;
  bool get complate => _isComplate;
  DateTime get writeDate => _todoWriteDate;
  DateTime? get complateDate => _todoComplateDate;
}
