import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/todo_item.dart';

/// 할 일 목록 상태
class TodoListState {
  final List<TodoItem> todos;

  TodoListState({required this.todos});

  TodoListState copyWith({List<TodoItem>? todos}) {
    return TodoListState(todos: todos ?? this.todos);
  }

  /// 완료되지 않은 할 일만 필터링
  List<TodoItem> get activeTodos =>
      todos.where((todo) => !todo.isCompleted).toList();

  /// 완료된 할 일만 필터링
  List<TodoItem> get completedTodos =>
      todos.where((todo) => todo.isCompleted).toList();

  /// 할 일이 비어있는지 확인
  bool get isEmpty => todos.isEmpty;
}

/// 할 일 상태 관리자
class TodoNotifier extends StateNotifier<TodoListState> {
  TodoNotifier() : super(TodoListState(todos: []));

  /// 할 일 추가
  void addTodo(String title, {String? description}) {
    final newTodo = TodoItem(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      description: description,
      createdAt: DateTime.now(),
    );
    state = TodoListState(todos: [newTodo, ...state.todos]);
  }

  /// 할 일 완료 토글
  void toggleTodo(String id) {
    state = TodoListState(
      todos: state.todos.map((todo) {
        if (todo.id == id) {
          return todo.copyWith(
            isCompleted: !todo.isCompleted,
            completedAt: todo.isCompleted ? null : DateTime.now(),
          );
        }
        return todo;
      }).toList(),
    );
  }

  /// 할 일 삭제
  void deleteTodo(String id) {
    state = TodoListState(
      todos: state.todos.where((todo) => todo.id != id).toList(),
    );
  }

  /// 할 일 수정
  void updateTodo(String id, String title, {String? description}) {
    state = TodoListState(
      todos: state.todos.map((todo) {
        if (todo.id == id) {
          return todo.copyWith(title: title, description: description);
        }
        return todo;
      }).toList(),
    );
  }
}

/// 할 일 Provider
final todoProvider =
    StateNotifierProvider<TodoNotifier, TodoListState>((ref) {
  return TodoNotifier();
});

