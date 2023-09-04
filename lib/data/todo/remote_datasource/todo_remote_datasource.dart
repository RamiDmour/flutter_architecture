import 'package:flutter_architecture/data/todo/model/todo.dart';
import 'package:uuid/uuid.dart';

abstract class TodoRemoteDatasourceBase {
  Future<Todo> createTodo(String name);

  Future<List<Todo>> getTodos();

  Future<bool> deleteTodo(String id);

  Future<void> toggleTodo(String id);
}

class TodoRemoteDatasource extends TodoRemoteDatasourceBase {
  @override
  Future<Todo> createTodo(String name) async {
    await Future.delayed(const Duration(seconds: 1));

    return Todo(
      id: const Uuid().v6(),
      name: name,
      completed: false,
    );
  }

  @override
  Future<bool> deleteTodo(String id) async {
    await Future.delayed(const Duration(seconds: 1));

    return true;
  }

  @override
  Future<List<Todo>> getTodos() async {
    final todos = [
      Todo(id: const Uuid().v6(), name: "Write geekbot", completed: false),
      Todo(id: const Uuid().v6(), name: "Do work", completed: false),
    ];
    await Future.delayed(const Duration(seconds: 1));

    return todos;
  }

  @override
  Future<void> toggleTodo(String id) async {
    await Future.delayed(const Duration(seconds: 1));
  }
}
