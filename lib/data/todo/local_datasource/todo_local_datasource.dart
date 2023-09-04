import 'package:flutter_architecture/core/function/fast_hash.dart';
import 'package:flutter_architecture/data/todo/local_datasource/entity/todo_entity.dart';
import 'package:flutter_architecture/data/todo/mapper/todo_mapper.dart';
import 'package:flutter_architecture/data/todo/model/todo.dart';
import 'package:isar/isar.dart';

abstract class TodoLocalDatasourceBase {
  Future<TodoEntity?> getTodo(String id);

  Future<List<TodoEntity>> getTodos();

  Future<void> saveTodo(Todo todo);

  Future<void> removeTodo(String id);

  Future<void> toggleTodo(String id);
}

class TodoLocalDatasource extends TodoLocalDatasourceBase {
  final Isar isar;
  TodoLocalDatasource({required this.isar});

  @override
  Future<TodoEntity?> getTodo(String id) => isar.todo.get(fastHash(id));

  @override
  Future<void> removeTodo(String id) async {
    await isar.writeTxn(() async {
      await isar.todo.delete(fastHash(id));
    });
  }

  @override
  Future<void> saveTodo(Todo todo) async {
    await isar.writeTxn(() async {
      await isar.todo.put(TodoMapper.modelToEntity(todo));
    });
  }

  @override
  Future<List<TodoEntity>> getTodos() {
    return isar.txn(() => isar.todo.where().findAll());
  }

  @override
  Future<void> toggleTodo(String id) async {
    final todo = await getTodo(id);
    await isar.writeTxn(() async {
      if (todo != null) {
        todo.completed = !todo.completed!;
        await isar.todo.put(todo);
      }
    });
  }
}
