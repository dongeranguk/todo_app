import '../vo_todo.dart';

sealed class TodoEvent {}

class TodoAddEvent extends TodoEvent {}

class TodoStatusUpdateEvent extends TodoEvent {
  final Todo updatedTodo;

  TodoStatusUpdateEvent(this.updatedTodo);
}

class TodoContentUpdateEvent extends TodoEvent {
  final Todo updatedTodo;

  TodoContentUpdateEvent(this.updatedTodo);
}

class TodoRemoveEvent extends TodoEvent {
  final Todo removedTodo;

  TodoRemoveEvent(this.removedTodo);
}
