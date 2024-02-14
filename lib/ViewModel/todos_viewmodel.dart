import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_new/Data/todo_dao.dart';
import 'package:todo_new/Model/todo.dart';

class ToDosViewModel extends ChangeNotifier {
  final TodoDao _todoDao = TodoDao();

  late List<ToDo> _todos;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  List<ToDo> get todos => _todos;

  String? todoName;
  final todoDateCont = TextEditingController();

  Future loadTodos() async {
    _isLoading = true;
    notifyListeners();

    _todos = await _todoDao.getAllInSortedOrder();
    _isLoading = false;
    notifyListeners();
  }

  Future changeDoneStatus(ToDo todo) async {
    todo.isDone = !todo.isDone;
    await _todoDao.update(todo);
    _todos = await _todoDao.getAllInSortedOrder();

    print(todo.isDone);
    notifyListeners();
  }

  setTodoName(String? value) {
    todoName = value;
    notifyListeners();
  }

  setTodoDate(DateTime? date) {
    todoDateCont.text = DateFormat.yMMMEd().format(date!);
  }

  Future addTodo() async {
    final todo = ToDo(todoName: todoName!, todoDate: todoDateCont.text);
    await _todoDao.insert(todo);
    await loadTodos();
    todoDateCont.clear();
    notifyListeners();
  }

  Future deleteTodo(ToDo todo) async {
    await _todoDao.delete(todo);
    await loadTodos();
    notifyListeners();
  }
}
