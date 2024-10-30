import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_list/src/blocs/InternetChek/internet_check_cubit.dart';
import 'package:todo_list/src/blocs/ToDo/to_do_bloc.dart';
import 'package:todo_list/src/views/create_todo.dart';
import 'package:todo_list/src/views/widgets/empty_view.dart';
import 'package:todo_list/src/views/widgets/loading.dart';
import 'package:todo_list/src/views/widgets/snack_bar.dart';
import 'package:todo_list/src/views/widgets/todo_list.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late InternetCheckCubit internetCheckCubit;
  late bool show = true;
  @override
  void initState() {
    internetCheckCubit = context.read<InternetCheckCubit>();
    internetCheckCubit.checkConnectivity();
    internetCheckCubit.trackConnectivityChange();
    context.read<ToDoBloc>().add(AddToDoApi(internetCheckCubit.state.status));

    Timer(const Duration(seconds: 5), () {
      context.read<ToDoBloc>().add(GetAllToDos());
      setState(() => show = false);
    });
    super.initState();
  }

  @override
  void dispose() {
    internetCheckCubit.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: BlocBuilder<InternetCheckCubit, InternetCheck>(
            buildWhen: (previous, current) => previous != current,
            builder: (context, state) {
              return state.status == ConnectivityStatus.disconnected
                  ? AppBar(
                      centerTitle: true,
                      backgroundColor: Colors.red,
                      title: Text(
                        "You don't have an internet connection",
                        style: GoogleFonts.poppins(
                          fontSize: 16.0,
                          color: Colors.white,
                        ),
                      ),
                    )
                  : const SizedBox();
            },
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Title
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "ToDo List",
                style: GoogleFonts.poppins(fontSize: 24.0),
              ),
            ),

            // List
            Expanded(
              child: BlocBuilder<ToDoBloc, ToDoState>(
                buildWhen: (previous, current) => previous != current,
                builder: (context, state) {
                  if (state.error != "") {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      context.read<ToDoBloc>().add(InitToDos());

                      ScaffoldMessenger.of(context).showSnackBar(
                        snackBar(state.error, true),
                      );
                    });
                  }
                  return state.loading || show
                      ? const Loading()
                      : state.listToDos.isEmpty
                          ? const EmptyView()
                          : AnimatedSwitcher(
                              duration: const Duration(milliseconds: 300),
                              child: ToDosList(todos: state.listToDos),
                            );
                },
              ),
            ),
          ],
        ),
        // Add ToDo Button
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const CreateTodoView()));
          },
          backgroundColor: Colors.white,
          child: const Icon(
            Icons.add,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
