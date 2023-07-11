import 'package:flutter/material.dart';
import 'package:todo_list/model/Task.dart';
import 'package:todo_list/model/Taskdao.dart';

class TaskView extends StatefulWidget {
  const TaskView({super.key});

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  Future<List<Task>> getNotes() async {
    var tasks = await TaskDao().getAllTasks();

    return tasks;
  }

  void refreshOnDelete() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Task>>(
      future: getNotes(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        List<Task> tasks = snapshot.data!;
        return ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (context, index) => TaskItem(
            taskItem: tasks[index],
            refreshWidget: refreshOnDelete,
          ),
        );
      },
    );
  }
}

class TaskItem extends StatefulWidget {
  const TaskItem(
      {super.key, required this.taskItem, required this.refreshWidget});

  final Task taskItem;
  final refreshWidget;

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  Future<void> taskChanged() async {
    widget.taskItem.task_isdone = 1 - widget.taskItem.task_isdone!;

    await TaskDao().taskUpdate(widget.taskItem);

    setState(() {});
  }

  Future<void> deleteItem() async {
    await TaskDao().taskDelete(widget.taskItem.task_id);

    widget.refreshWidget();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {
          taskChanged();
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        tileColor: Colors.white,
        leading: Icon(
          (widget.taskItem.task_isdone! == 1)
              ? Icons.check_box
              : Icons.check_box_outline_blank,
          color: Colors.blue,
        ),
        title: Text(
          widget.taskItem.task_name,
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
            decoration: (widget.taskItem.task_isdone! == 1)
                ? TextDecoration.lineThrough
                : null,
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
