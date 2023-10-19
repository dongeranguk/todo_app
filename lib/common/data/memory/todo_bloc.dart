import 'package:fast_app_base/common/data/memory/bloc/bloc_status.dart';
import 'package:fast_app_base/common/data/memory/bloc/todo_event.dart';
import 'package:fast_app_base/common/data/memory/bloc/todo_bloc_state.dart';
import 'package:fast_app_base/common/data/memory/todo_status.dart';
import 'package:fast_app_base/screen/dialog/d_confirm.dart';
import 'package:fast_app_base/screen/main/write/d_write_todo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'vo_todo.dart';

class TodoBloc extends Bloc<TodoEvent, TodoBlocState> {
  TodoBloc() : super(const TodoBlocState(BlocStatus.initial, <Todo>[])) {
    on<TodoAddEvent>(_addTodo);
    on<TodoStatusUpdateEvent>(_changeTodoStatus);
    on<TodoContentUpdateEvent>(_editTodo);
    on<TodoRemoveEvent>(_removeTodo);
  }

    void _addTodo(TodoAddEvent event, Emitter<TodoBlocState> emit) async {
      final copiedOldTodoList = List.of(state.todoList);

      final result = await WriteTodoDialog().show();
      if (result != null) {
        copiedOldTodoList.add(Todo(
          id: DateTime.now().millisecondsSinceEpoch,
          title: result.text,
          dueDate: result.dateTime,
          createdAt: DateTime.now(),
          status: TodoStatus.incomplete,
        ));
        emitNewList(copiedOldTodoList, emit);
      }
    }

  void _changeTodoStatus(TodoStatusUpdateEvent event, Emitter<TodoBlocState> emit) async {
    final todo = event.updatedTodo;
    final copiedOldTodoList = List.of(state.todoList);
    final todoIndex = copiedOldTodoList.indexWhere((element) => element.id == todo.id);

    TodoStatus status = todo.status;
    switch (todo.status) {
      case TodoStatus.incomplete:
        status = TodoStatus.ongoing;
      case TodoStatus.ongoing:
        status = TodoStatus.complete;
      case TodoStatus.complete:
        final result = await ConfirmDialog('정말로 처음 상태로 변경하시겠어요?').show();
        result?.runIfSuccess((data) {
          status = TodoStatus.incomplete;
        });
    }

    copiedOldTodoList[todoIndex] = todo.copyWith(status: status);
    emitNewList(copiedOldTodoList, emit);
  }

  void _editTodo(TodoContentUpdateEvent event, Emitter<TodoBlocState> emit) async {
    final todo = event.updatedTodo;
    final result = await WriteTodoDialog(todoForEdit: todo).show();
    if (result != null) {
      final copiedOldTodoList = List<Todo>.from(state.todoList);
      copiedOldTodoList[copiedOldTodoList.indexOf(todo)] = todo.copyWith(
        title: result.text,
        dueDate: result.dateTime,
        modifiedAt: DateTime.now(),
      );
      emitNewList(copiedOldTodoList, emit);
    }
  }

  void _removeTodo(TodoRemoveEvent event, Emitter<TodoBlocState> emit) {
    final todo = event.removedTodo;
    final copiedOldTodoList = List<Todo>.from(state.todoList);
    copiedOldTodoList.removeWhere((element) => element.id == todo.id);
    emitNewList(copiedOldTodoList, emit);
  }

  void emitNewList(List<Todo> copiedOldTodoList, Emitter<TodoBlocState> emit) {
    emit(state.copyWith(todoList: copiedOldTodoList));
  }
}
