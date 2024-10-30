import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_list/src/blocs/ToDo/to_do_bloc.dart';
import 'package:todo_list/src/models/todo.dart';
import 'package:todo_list/src/views/widgets/header.dart';
import 'package:todo_list/src/views/widgets/snack_bar.dart';
import 'package:todo_list/src/views/widgets/text_field.dart';

class CreateTodoView extends StatefulWidget {
  const CreateTodoView({super.key});

  @override
  State<CreateTodoView> createState() => _CreateTodoViewState();
}

class _CreateTodoViewState extends State<CreateTodoView> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final strEmpty = "";
  late String titleError = strEmpty;
  late String descriptionError = strEmpty;

  void validator() {
    if (titleController.text.trim().isEmpty) {
      titleError = "Title can't be empty";
    }

    if (descriptionController.text.trim().isEmpty) {
      descriptionError = "Description can't be empty";
    }

    setState(() {});
  }

  void hideValidator() {
    if (titleError.isNotEmpty || descriptionError.isNotEmpty) {
      if (!mounted) {
        Timer(
          const Duration(seconds: 3),
          () => setState(() {
            titleError = strEmpty;
            descriptionError = strEmpty;
          }),
        );
      }
    }
  }

  void hideKeyboard() => FocusScope.of(context).unfocus();

  void save() {
    validator();

    if (titleController.text.trim().isNotEmpty &&
        descriptionController.text.trim().isNotEmpty) {
      hideKeyboard();

      ToDo todo = ToDo();
      todo.title = titleController.text.trim();
      todo.description = descriptionController.text.trim();
      context.read<ToDoBloc>().add(SaveToDo(todo: todo));
    }

    hideValidator();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ToDoBloc, ToDoState>(
      builder: (context, state) {
        if (state.add) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.read<ToDoBloc>()
              ..add(InitToDos())
              ..add(GetAllToDos());

            ScaffoldMessenger.of(context).showSnackBar(
              snackBar('ToDo added successfully', false),
            );

            Navigator.pop(context);
          });
        }

        if (state.error != strEmpty) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.read<ToDoBloc>().add(InitToDos());

            ScaffoldMessenger.of(context).showSnackBar(
              snackBar(state.error, true),
            );
          });
        }

        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const HeaderWidget(
                    title: 'New ToDo',
                  ),
                  const SizedBox(height: 20.0),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            TextFieldWidget(
                              label: 'Title',
                              hintText: 'ToDo title',
                              controller: titleController,
                              error: titleError,
                              isDescription: false,
                            ),
                            const SizedBox(height: 30.0),
                            TextFieldWidget(
                              label: 'Description',
                              hintText: 'Write something',
                              controller: descriptionController,
                              error: descriptionError,
                              isDescription: true,
                            ),
                            const SizedBox(height: 40.0),
                            FloatingActionButton.extended(
                              onPressed: () => save(),
                              label: Text(
                                "Add",
                                style: GoogleFonts.poppins(
                                  fontSize: 16.0,
                                  color: Colors.white,
                                ),
                              ),
                              backgroundColor: Colors.blue,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
