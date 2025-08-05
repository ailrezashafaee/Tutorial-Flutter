import 'package:flutter/material.dart';
import 'package:todo/services/todo_local_service.dart';
import 'package:todo/widgets/todo_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await TodoLocalService.instance.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const TodoApp(),
    );
  }
}
