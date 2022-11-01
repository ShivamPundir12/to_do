import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/todo.dart';

final todoListProvider =
    StateNotifierProvider<TodoList, List<Todo>>((ref) => TodoList());

class TodoList extends StateNotifier<List<Todo>> {
  // TodoList({String? text}) : super([Todo(text: text)]);

  TodoList([List<Todo>? initialState]) : super(initialState ?? []);

  void add({required String text}) {
    state = [...state, Todo(text: text, id: uuid.v4())];
  }

  void editTodo({String? id, String? description}) {
    state = [
      for (final todo in state)
        if (todo.id == id) Todo(id: id, text: description) else todo
    ];
  }

  void removeTodo({required String id}) {
    state = state.where((todo) => todo.id != id).toList();
  }
}
