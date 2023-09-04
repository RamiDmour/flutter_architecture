import 'package:flutter_architecture/core/function/fast_hash.dart';
import 'package:isar/isar.dart';

part 'todo_entity.g.dart';

@Collection(accessor: "todo")
class TodoEntity {
  @Index(type: IndexType.value)
  String? id;

  String? name;

  bool? completed;

  Id get isarId => fastHash(id!);
}
