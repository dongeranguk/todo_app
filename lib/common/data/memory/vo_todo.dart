import 'todo_status.dart';

class Todo {
  int id;
  String title;
  final DateTime createdAt;
  DateTime? modifiedAt;
  DateTime dueDate;
  TodoStatus status;

  Todo({
    required this.id,
    required this.title,
    required this.dueDate,
    this.status = TodoStatus.incomplete,
  }) : createdAt = DateTime.now();
}
