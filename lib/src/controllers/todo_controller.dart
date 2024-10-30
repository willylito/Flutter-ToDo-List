import 'dart:math';

import 'package:todo_list/src/models/todo.dart';
import 'package:todo_list/src/services/consume_api.dart';
import 'package:todo_list/src/services/local_db.dart';

class TodoController {
  final TodoService todoService;
  final ApiService apiService;

  TodoController(this.todoService, this.apiService);

  Future<List<ToDo>> getAllToDos() async {
    final list = await todoService.getAll();
    list.sort((a, b) => a.id.compareTo(b.id));
    return list;
  }

  Future<bool> saveToDo(ToDo todo) async {
    final result = await todoService.saveToDo(todo);
    return result;
  }

  Future<bool> changeToDoState(ToDo todo) async {
    final result = await todoService.changeToDoState(todo);
    return result;
  }

  Future<bool> deleteToDo(ToDo todo) async {
    final result = await todoService.deleteToDo(todo);
    return result;
  }

  Future<bool> addToDoApi() async {
    final resp = await apiService.getToDoById(id: getRandomNumber());

    ToDo todo = ToDo.fromMap(resp.data);

    if (todo.title.isNotEmpty) {
      return await todoService.saveToDo(todo);
    }

    return false;
  }

  int getRandomNumber() {
    Random random = Random();
    return random.nextInt(100) + 1;
  }
}
