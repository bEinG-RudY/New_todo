import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_new/View/todos_list/todos_list_page.dart';
import 'package:todo_new/ViewModel/todos_viewmodel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => ToDosViewModel()..loadTodos(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.deepPurple),
        home: const ToDoListPage(),
      ),
    );
  }
}
