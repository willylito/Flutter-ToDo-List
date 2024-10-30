import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/src/app.dart';
import 'package:todo_list/src/blocs/InternetChek/internet_check_cubit.dart';
import 'package:todo_list/src/blocs/ToDo/to_do_bloc.dart';
import 'package:todo_list/src/controllers/todo_controller.dart';

import 'di.dart';

class BlocProviders extends StatelessWidget {
  const BlocProviders({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => InternetCheckCubit()),
        BlocProvider(create: (context) => ToDoBloc(instance<TodoController>())),
      ],
      child: const App(),
    );
  }
}
