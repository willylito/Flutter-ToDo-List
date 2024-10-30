import 'package:auto_animated_list/auto_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/src/models/todo.dart';
import 'package:todo_list/src/views/widgets/todo_list_item.dart';

class ToDosList extends StatelessWidget {
  final List<ToDo> todos;

  const ToDosList({super.key, required this.todos});

  @override
  Widget build(BuildContext context) {
    return AutoAnimatedList<ToDo>(
      padding: const EdgeInsets.all(20),
      items: todos,
      itemBuilder: (context, note, index, animation) {
        return SizeFadeTransition(
          animation: animation,
          child: ToDoListItem(
            todo: todos[index],
          ),
        );
      },
    );
  }
}
