import 'package:flutter_architecture/data/todo/model/todo.dart';

abstract class TodoState {}

class TodoReadyState extends TodoState {
  final List<Todo> todos;

  TodoReadyState(this.todos);
}

class TodoLoadingState extends TodoState {}
