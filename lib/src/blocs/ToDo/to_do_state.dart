part of 'to_do_bloc.dart';

class ToDoState {
  final bool loading;
  final String error;
  final bool add;
  final bool addFromApi;
  final List<ToDo> listToDos;

  const ToDoState({
    this.loading = false,
    this.error = '',
    this.add = false,
    this.addFromApi = false,
    this.listToDos = const [],
  });

  ToDoState copyWith({
    bool? loading,
    String? error,
    bool? add,
    bool? addFromApi,
    List<ToDo>? listToDos,
  }) =>
      ToDoState(
        loading: loading ?? this.loading,
        error: error ?? this.error,
        add: add ?? this.add,
        addFromApi: addFromApi ?? this.addFromApi,
        listToDos: listToDos ?? this.listToDos,
      );
}
