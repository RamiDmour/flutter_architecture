import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture/core/di/get_it.dart';
import 'package:flutter_architecture/presentation/todo/bloc/state/todo_state.dart';
import 'package:flutter_architecture/presentation/todo/bloc/todo_cubit.dart';
import 'package:flutter_architecture/presentation/todo/widget/todo_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TodoCubit(todoRepository: getIt.get()),
      child: const TodoView(),
    );
  }
}

class TodoView extends StatelessWidget {
  const TodoView({super.key});

  @override
  Widget build(BuildContext context) {
    final TodoCubit todoCubit = BlocProvider.of(context);
    return Scaffold(
      body: BlocBuilder<TodoCubit, TodoState>(
        builder: (context, state) {
          if (state is TodoLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is TodoReadyState) {
            return ListView.builder(
              itemCount: state.todos.length,
              itemBuilder: (context, i) => TodoItem(
                todo: state.todos[i],
                onToggle: () => todoCubit.toggleTodo(state.todos[i].id),
                onDelete: () => todoCubit.removeTodo(state.todos[i].id),
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
