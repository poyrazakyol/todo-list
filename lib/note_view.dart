import 'package:flutter/material.dart';
import 'package:todo_list/model/dao.dart';
import 'package:todo_list/model/todo.dart';

class NotesView extends StatefulWidget {
  const NotesView({super.key});

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  Future<List<ToDo>> getNotes() async {
    var notes = await ToDoDao().getAll();

    return notes;
  }

  void refreshOnDelete() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ToDo>>(
      future: getNotes(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        List<ToDo> notes = snapshot.data!;
        return ListView.builder(
          itemCount: notes.length,
          itemBuilder: (context, index) => TodoItem(todoItem: notes[index], refreshWidget: refreshOnDelete,),
        );
      },
    );
  }
}


class TodoItem extends StatefulWidget {
  const TodoItem({super.key, required this.todoItem, required this.refreshWidget});

  final ToDo todoItem;
  final refreshWidget;

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {

  Future<void> toDoChanged() async {

    widget.todoItem.isDone = 1 - widget.todoItem.isDone!;

    await ToDoDao().noteUpdate(widget.todoItem);
    
    setState(() {});
  }

  Future<void> deleteItem() async {

    await ToDoDao().noteDelete(widget.todoItem.id!);
    
    widget.refreshWidget();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {
          toDoChanged();
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        tileColor: Colors.white,
        leading: Icon(
          (widget.todoItem.isDone! == 1) ? Icons.check_box : Icons.check_box_outline_blank,
          color: Colors.blue,
        ),
        title: Text(
          widget.todoItem.todoText!,
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
            decoration: (widget.todoItem.isDone! == 1) ? TextDecoration.lineThrough : null,
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
              deleteItem();
            },
          ),
        ),
      ),
    );
  }
}
