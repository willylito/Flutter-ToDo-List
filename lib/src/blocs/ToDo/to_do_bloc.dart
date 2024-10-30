import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/src/blocs/InternetChek/internet_check_cubit.dart';
import 'package:todo_list/src/controllers/todo_controller.dart';
import 'package:todo_list/src/models/todo.dart';

part 'to_do_event.dart';
part 'to_do_state.dart';

class ToDoBloc extends Bloc<ToDoEvent, ToDoState> {
  final TodoController todoController;
  ToDoBloc(this.todoController) : super(const ToDoState()) {
    on<InitToDos>(initToDo);
    on<AddToDoApi>(addToDoApi);
    on<GetAllToDos>(getAllToDos);
    on<ChangeStateToDo>(changeStateToDo);
    on<SaveToDo>(saveToDo);
    on<DeleteToDo>(deleteToDo);
  }

  void initToDo(event, emit) => emit(
      state.copyWith(loading: false, add: false, addFromApi: true, error: ''));

  void addToDoApi(event, emit) async {
    try {
      emit(state.copyWith(loading: true));

      if (event.internetStatus == ConnectivityStatus.connected) {
        if (!state.addFromApi) {
          final resp = await todoController.addToDoApi();

          if (!resp) {
            emit(state.copyWith(
              addFromApi: true,
              error: 'Could not add ToDo from Api',
            ));
          }
        }
      }
      emit(state.copyWith(
        addFromApi: true,
      ));
    } catch (error) {
      emit(state.copyWith(
        addFromApi: true,
        error: 'An error occurred from API',
      ));
    }
  }

  void getAllToDos(event, emit) async {
    emit(state.copyWith(loading: true));

    final resp = await todoController.getAllToDos();

    emit(state.copyWith(loading: false, listToDos: resp));
  }

  void changeStateToDo(event, emit) async {
    try {
      emit(state.copyWith(loading: true));

      ToDo todo = event.todo;
      todo.completed = !todo.completed;

      state.listToDos.removeWhere((element) => element.id == todo.id);
      state.listToDos.insert(state.listToDos.length, todo);

      await todoController.changeToDoState(event.todo);

      state.listToDos.sort((a, b) => a.id.compareTo(b.id));

      emit(state.copyWith(loading: false));
    } catch (error) {
      emit(state.copyWith(loading: false, error: 'An error occurred'));
    }
  }

  void saveToDo(event, emit) async {
    try {
      emit(state.copyWith(loading: true));

      final resp = await todoController.saveToDo(event.todo);

      emit(state.copyWith(loading: false, add: resp));
    } catch (error) {
      emit(state.copyWith(loading: false, error: 'An error occurred'));
    }
  }

  void deleteToDo(event, emit) async {
    try {
      emit(state.copyWith(loading: true));

      state.listToDos.removeWhere((element) => element.id == event.todo.id);

      await todoController.deleteToDo(event.todo);

      state.listToDos.sort((a, b) => a.id.compareTo(b.id));

      emit(state.copyWith(loading: false));
    } catch (error) {
      emit(state.copyWith(loading: false, error: 'An error occurred'));
    }
  }
}
