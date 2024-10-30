import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_list/src/blocs/ToDo/to_do_bloc.dart';
import 'package:todo_list/src/models/todo.dart';
import 'package:todo_list/src/views/widgets/alert.dart';

class ToDoListItem extends StatefulWidget {
  final ToDo todo;

  const ToDoListItem({super.key, required this.todo});

  @override
  State<ToDoListItem> createState() => _ToDoListItemState();
}

class _ToDoListItemState extends State<ToDoListItem> {
  void changeToDoState() {
    context.read<ToDoBloc>().add(ChangeStateToDo(todo: widget.todo));
  }

  void deleteToDo() {
    showDialog(
      context: context,
      builder: (context) {
        return Alert(todo: widget.todo);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MaterialButton(
          onPressed: () => changeToDoState(),
          onLongPress: () => deleteToDo(),
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 0.0,
          child: Container(
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                color: Colors.grey.shade300,
                width: 2.0,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.todo.title,
                        style: GoogleFonts.poppins(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 1,
                      ),
                      Text(
                        widget.todo.description,
                        style: GoogleFonts.poppins(fontSize: 16.0),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Offstage(
                  offstage: !widget.todo.completed,
                  child: const Icon(
                    Icons.check_rounded,
                    size: 35.0,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
