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
    print(notes);

    return notes;
  }

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
          itemBuilder: (context, index) => Text(notes[index].todoText!),
        );
      },
    );
  }
}
