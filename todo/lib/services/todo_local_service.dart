import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/models/todo.dart';

class TodoLocalService {
  TodoLocalService._();
  static final TodoLocalService instance = TodoLocalService._();

  static const String _keyTodos = 'todos';
  late final SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<List<Todo>> fetchTodos() async {
    final localDataList = _prefs.getStringList(_keyTodos) ?? <String>[];
    return localDataList
        .map((jsonStr) => Todo.fromJson(json.decode(jsonStr)))
        .toList();
  }

  Future<void> _saveAll(List<Todo> todos) async {
    final jsonList = todos.map((item) => json.encode(item.toJson())).toList();
    await _prefs.setStringList(_keyTodos, jsonList);
  }

  Future<void> addTodo(Todo todo) async {
    final all = await fetchTodos();
    all.add(todo);
    await _saveAll(all);
  }

  Future<void> updateTodo(String id, {String? title, bool? done}) async {
    final all = await fetchTodos();
    final index = all.indexWhere((item) => item.id == id);
    if (index == -1) return;
    final existingTodo = all[index];
    final updated = existingTodo.copyWith(title: title, done: done);
    all[index] = updated;
    await _saveAll(all);
  }

  Future<void> removeTodo(String id) async {
    final all = await fetchTodos();
    all.removeWhere((item) => item.id == id);
    await _saveAll(all);
  }
}
