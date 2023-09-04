import 'package:flutter_architecture/data/todo/local_datasource/todo_local_datasource.dart';
import 'package:flutter_architecture/data/todo/mapper/todo_mapper.dart';
import 'package:flutter_architecture/data/todo/model/todo.dart';
import 'package:flutter_architecture/data/todo/remote_datasource/todo_remote_datasource.dart';

abstract class TodoRepositoryBase {
  Future<Todo> createTodo(String name);

  Future<List<Todo>> getTodos();

  Future<bool> deleteTodo(String id);

  Future<void> toggleTodo(String id);
}

class TodoRepository extends TodoRepositoryBase {
  final TodoRemoteDatasourceBase todoRemoteDatasource;
  final TodoLocalDatasourceBase todoLocalDatasource;
  TodoRepository({
    required this.todoLocalDatasource,
    required this.todoRemoteDatasource,
  });

  @override
  Future<Todo> createTodo(String name) async {
    final todo = await todoRemoteDatasource.createTodo(name);

    todoLocalDatasource.saveTodo(todo);

    return todo;
  }

  @override
  Future<bool> deleteTodo(String id) async {
    final result = await todoRemoteDatasource.deleteTodo(id);

    if (result) {
      await todoLocalDatasource.removeTodo(id);
    }

    return result;
  }

  @override
  Future<List<Todo>> getTodos() async {
    final cachedTodos = await todoLocalDatasource.getTodos();
    if (cachedTodos.isEmpty) {
      final todos = await todoRemoteDatasource.getTodos();
      for (var todo in todos) {
        await todoLocalDatasource.saveTodo(todo);
      }
      return todos;
    }

    return cachedTodos.map((todo) => TodoMapper.entityToModel(todo)).toList();
  }

  @override
  Future<void> toggleTodo(String id) async {
    await todoRemoteDatasource.toggleTodo(id);
    await todoLocalDatasource.toggleTodo(id);
  }
}
