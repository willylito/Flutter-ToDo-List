part of 'to_do_bloc.dart';

abstract class ToDoEvent {
  const ToDoEvent();
}

class InitToDos extends ToDoEvent {}

class GetAllToDos extends ToDoEvent {}

class ChangeStateToDo extends ToDoEvent {
  final ToDo todo;

  const ChangeStateToDo({required this.todo});
}

class SaveToDo extends ToDoEvent {
  final ToDo todo;

  const SaveToDo({required this.todo});
}

class DeleteToDo extends ToDoEvent {
  final ToDo todo;

  const DeleteToDo({required this.todo});
}

class AddToDoApi extends ToDoEvent {
  final ConnectivityStatus internetStatus;

  const AddToDoApi(this.internetStatus);
}
