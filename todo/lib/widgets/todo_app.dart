import 'package:flutter/material.dart';
import '../models/todo.dart';
import 'todo_input.dart';
import 'todo_list.dart';

class TodoApp extends StatefulWidget {
  const TodoApp({super.key});

  @override
  _TodoAppState createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  final TextEditingController _controller = TextEditingController();
  final List<Todo> _todos = [];

  void _addTodo() {
    final title = _controller.text.trim();
    if (title.isEmpty) return;
    setState(() => _todos.add(Todo(title: title)));
    _controller.clear();
    FocusScope.of(context).unfocus();
  }

  void _toggleDone(String id, bool? value) {
    final index = _todos.indexWhere((t) => t.id == id);
    if (index == -1) return;
    setState(() => _todos[index].done = value ?? false);
  }

  void _removeTodo(String id) {
    setState(() => _todos.removeWhere((t) => t.id == id));
  }

  void _editTodo(String id, String newTitle) {
    final index = _todos.indexWhere((t) => t.id == id);
    if (index == -1) return;
    setState(() => _todos[index].title = newTitle);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        appBar: AppBar(title: const Text('My To-Do List'), centerTitle: true),
        body: Column(
          children: [
            TodoInput(controller: _controller, onAdd: _addTodo),
            Expanded(
              child: TodoList(
                todos: _todos,
                onToggle: _toggleDone,
                onRemove: _removeTodo,
                onEdit: _editTodo,
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _addTodo,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
