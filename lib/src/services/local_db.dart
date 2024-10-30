import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_list/src/models/todo.dart';

class LocalDb {
  Future<Isar> getDb() async {
    final directory = await getApplicationDocumentsDirectory();

    if (Isar.instanceNames.isEmpty) {
      return await Isar.open(
        [ToDoSchema],
        directory: directory.path,
        inspector: true,
      );
    }

    return Future.value(Isar.getInstance());
  }
}

class TodoService {
  final Isar db;

  TodoService(this.db);

  Future<List<ToDo>> getAll() async {
    List<ToDo> data = [];

    await db.txn(() async {
      data = await db.toDos.where().findAll();
    });

    return data;
  }

  Future<bool> saveToDo(ToDo newToDo) async {
    try {
      await db.writeTxn(() async {
        await db.toDos.put(newToDo);
      });

      return true;
    } catch (error) {
      return false;
    }
  }

  Future<bool> changeToDoState(ToDo todo) async {
    try {
      final ToDo? toDo = await db.toDos.where().idEqualTo(todo.id).findFirst();
      toDo!.completed = !toDo.completed;

      await db.writeTxn(() async {
        await db.toDos.put(toDo);
      });

      return true;
    } catch (error) {
      return false;
    }
  }

  Future<bool> deleteToDo(ToDo todo) async {
    try {
      await db.writeTxn(() async {
        await db.toDos.delete(todo.id);
      });

      return true;
    } catch (error) {
      return false;
    }
  }
}
