import 'package:isar/isar.dart';

part 'todo.g.dart';

@collection
class ToDo {
  Id id;
  String title;
  String description;
  bool completed;

  ToDo({
    this.id = Isar.autoIncrement,
    this.title = '',
    this.description = '',
    this.completed = false,
  });

  ToDo copyWith({
    Id? id,
    String? title,
    String? description,
    bool? completed,
  }) {
    return ToDo(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      completed: completed ?? this.completed,
    );
  }

  factory ToDo.fromMap(Map<String, dynamic> map) {
    return ToDo(
      id: Isar.autoIncrement,
      title: map['title'] ?? "",
      description: map['description'] ??
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry",
      completed: map['completed'] ?? false,
    );
  }
}
