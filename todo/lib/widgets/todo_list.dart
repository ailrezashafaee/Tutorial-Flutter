import 'package:flutter/material.dart';
import '../models/todo.dart';
import 'todo_item.dart';

class TodoList extends StatelessWidget {
  final List<Todo> todos;
  final void Function(String, bool?) onToggle;
  final void Function(String) onRemove;
  final void Function(String, String) onEdit;

  const TodoList({
    super.key,
    required this.todos,
    required this.onToggle,
    required this.onRemove,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) {
        final todo = todos[index];
        return TodoItem(
          key: ValueKey(todo.id),
          todo: todo,
          onToggle: onToggle,
          onRemove: onRemove,
          onEdit: onEdit,
        );
      },
    );
  }
}
