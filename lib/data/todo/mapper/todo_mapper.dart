import 'package:flutter_architecture/data/todo/local_datasource/entity/todo_entity.dart';
import 'package:flutter_architecture/data/todo/model/todo.dart';

class TodoMapper {
  static TodoEntity modelToEntity(Todo todo) {
    return TodoEntity()
      ..id = todo.id
      ..completed = todo.completed
      ..name = todo.name;
  }

  static Todo entityToModel(TodoEntity todo) {
    return Todo(
      id: todo.id!,
      name: todo.name!,
      completed: todo.completed!,
    );
  }
}
