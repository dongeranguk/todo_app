import 'package:freezed_annotation/freezed_annotation.dart';

import 'todo_status.dart';

part 'vo_todo.freezed.dart';

@freezed
class Todo with _$Todo {
  const factory Todo({
    required int id,
    required String title,
    required DateTime dueDate,
    required DateTime createdAt,
    DateTime? modifiedAt,
    required TodoStatus status,
  }) = _Todo;
}
