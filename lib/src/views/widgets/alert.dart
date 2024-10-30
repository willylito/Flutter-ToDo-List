import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_list/src/blocs/ToDo/to_do_bloc.dart';
import 'package:todo_list/src/models/todo.dart';

class Alert extends StatelessWidget {
  final ToDo todo;
  const Alert({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Delete ToDo ?",
        style: GoogleFonts.poppins(fontSize: 20.0),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset('assets/animations/delete.json'),
          Text(
            "This note will be permanently deleted.",
            style: GoogleFonts.poppins(fontSize: 18.0),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            context.read<ToDoBloc>().add(DeleteToDo(todo: todo));

            Navigator.pop(context);
          },
          child: Text("Proceed", style: GoogleFonts.poppins(fontSize: 12.0)),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("Cancel", style: GoogleFonts.poppins(fontSize: 12.0)),
        ),
      ],
    );
  }
}
