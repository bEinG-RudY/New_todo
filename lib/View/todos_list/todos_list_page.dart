import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_new/utilities/dialog_box.dart';
import 'package:todo_new/View/todos_list/widgets/todo_tile.dart';
import 'package:todo_new/ViewModel/todos_viewmodel.dart';

class ToDoListPage extends StatefulWidget {
  const ToDoListPage({super.key});

  @override
  State<ToDoListPage> createState() => _ToDoListPageState();
}

class _ToDoListPageState extends State<ToDoListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[200],
      appBar: AppBar(
        title: const Center(child: Text("To Do")),
        // elevation: 0,
      ),
      body: Consumer<ToDosViewModel>(
        builder: (BuildContext context, todoProvider, Widget? child) {
          if (todoProvider.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
              itemCount: todoProvider.todos.length,
              itemBuilder: (context, index) {
                return ToDoTile(
                  todoIndex: index,
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return DialogBox();
            },
          );
        },
        child: const Icon(Icons.note_add_outlined),
      ),
    );
  }
}
