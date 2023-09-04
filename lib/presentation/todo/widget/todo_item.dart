import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture/data/todo/model/todo.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;
  final void Function() onToggle;
  final void Function() onDelete;
  const TodoItem({
    super.key,
    required this.todo,
    required this.onToggle,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onToggle,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            todo.name,
            style: TextStyle(decoration: todo.completed ? TextDecoration.lineThrough : TextDecoration.none),
          ),
          IconButton(
            onPressed: onDelete,
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
          )
        ],
      ),
    );
  }
}
