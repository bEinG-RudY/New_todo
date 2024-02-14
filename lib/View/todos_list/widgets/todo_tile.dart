import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_new/Model/todo.dart';
import 'package:todo_new/ViewModel/todos_viewmodel.dart';

class ToDoTile extends StatelessWidget {
  const ToDoTile({
    super.key,
    required this.todoIndex,
  });

  final int todoIndex;

  @override
  Widget build(BuildContext context) {
    final todoProvider = Provider.of<ToDosViewModel>(context, listen: false);
    final ToDo displayedTodo = todoProvider.todos[todoIndex];
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 25),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.deepPurple,
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          leading: Checkbox(
            value: displayedTodo.isDone,
            onChanged: (value) {
              todoProvider.changeDoneStatus(displayedTodo);
            },
            activeColor: Colors.deepPurple[200],
          ),
          title: Text(
            displayedTodo.todoName,
            style: TextStyle(
                color: Colors.white,
                decoration: displayedTodo.isDone
                    ? TextDecoration.lineThrough
                    : TextDecoration.none),
          ),
          subtitle: Text(displayedTodo.todoDate),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              todoProvider.deleteTodo(displayedTodo);
            },
          ),
        ),
      ),
    );
  }
}
