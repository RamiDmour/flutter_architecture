import 'package:flutter_architecture/data/todo/repository/todo_repository.dart';
import 'package:flutter_architecture/presentation/todo/bloc/state/todo_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoCubit extends Cubit<TodoState> {
  final TodoRepositoryBase todoRepository;
  TodoCubit({required this.todoRepository}) : super(TodoLoadingState()) {
    fetchTodos();
  }

  void fetchTodos() async {
    emit(TodoLoadingState());

    final todos = await todoRepository.getTodos();

    emit(TodoReadyState(todos));
  }

  void addTodo(String name) async {
    emit(TodoLoadingState());

    await todoRepository.createTodo(name);
    final todos = await todoRepository.getTodos();

    emit(TodoReadyState(todos));
  }

  void removeTodo(String id) async {
    emit(TodoLoadingState());

    await todoRepository.deleteTodo(id);
    final todos = await todoRepository.getTodos();

    emit(TodoReadyState(todos));
  }

  void toggleTodo(String id) async {
    emit(TodoLoadingState());

    await todoRepository.toggleTodo(id);
    final todos = await todoRepository.getTodos();

    emit(TodoReadyState(todos));
  }
}
