import 'package:flutter/material.dart';

import 'model/Task.dart';

class todoItem extends StatelessWidget {
  final Task todo;
  final toDoChanged;
  final deleteItem;

  const todoItem(
      {Key? key,
      required this.todo,
      required this.toDoChanged,
      required this.deleteItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {
          toDoChanged(todo);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        tileColor: Colors.white,
        leading: Icon(
          (todo.task_isdone! == 1)
              ? Icons.check_box
              : Icons.check_box_outline_blank,
          color: Colors.blue,
        ),
        title: Text(
          todo.task_name,
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
            decoration:
                (todo.task_isdone! == 1) ? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: Container(
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: IconButton(
            color: Colors.white,
            iconSize: 18,
            icon: Icon(Icons.delete),
            onPressed: () {
              deleteItem(todo.task_id);
            },
          ),
        ),
      ),
    );
  }
}
