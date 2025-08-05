import 'package:flutter/material.dart';
import 'package:todo/services/todo_local_service.dart';
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
  List<Todo> _todos = [];

  @override
  void initState() {
    super.initState();
    _loadTodos();
  }

  Future<void> _loadTodos() async {
    final todos = await TodoLocalService.instance.fetchTodos();
    setState(() {
      _todos = todos;
    });
  }

  Future<void> _addTodo() async {
    final title = _controller.text.trim();
    if (title.isEmpty) return;

    final newTodo = Todo(title: title);
    await TodoLocalService.instance.addTodo(newTodo);

    setState(() => _todos.add(Todo(title: title)));
    _controller.clear();
    // FocusScope.of(context).unfocus();
  }

  Future<void> _toggleDone(String id, bool? value) async {
    final index = _todos.indexWhere((t) => t.id == id);
    if (index == -1) return;
    await TodoLocalService.instance.updateTodo(id, done: value ?? false);
    setState(() => _todos[index].done = value ?? false);
  }

  Future<void> _removeTodo(String id) async {
    await TodoLocalService.instance.removeTodo(id);
    setState(() => _todos.removeWhere((t) => t.id == id));
  }

  Future<void> _editTodo(String id, String newTitle) async {
    final index = _todos.indexWhere((item) => item.id == id);
    if (index == -1) return;
    await TodoLocalService.instance.updateTodo(id, title: newTitle);
    setState(() {
      _todos[index].title = newTitle;
    });
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
