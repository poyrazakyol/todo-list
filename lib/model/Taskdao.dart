import 'package:todo_list/model/Task.dart';
import 'package:todo_list/model/database_helper.dart';

class TaskDao {
  Future<List<Task>> getAllTasks() async {
    var db = await DatabaseHelper.databaseAccess();

    List<Map<String, dynamic>> maps = await db.rawQuery("SELECT *  FROM task");

    return List.generate(maps.length, (i) {
      var row = maps[i];

      return Task(
          row["task_id"], row["task_name"], row["task_isdone"], row["user_id"]);
    });
  }

  Future<void> addTask(String task_name, int user_id) async {
    var db = await DatabaseHelper.databaseAccess();

    var info = Map<String, dynamic>();
    info["task_name"] = task_name;
    info["task_isdone"] = false;
    info["user_id"] = user_id;

    await db.insert("task", info);
  }

  Future<void> taskUpdate(Task task) async {
    var db = await DatabaseHelper.databaseAccess();

    Map<String, dynamic> info = {};
    info["task_name"] = task.task_name;
    info["task_isdone"] = task.task_isdone!;
    //info["id"] = todo.id!;

    try {
      await db.update("Task", info,
          where: "task_id = ?", whereArgs: [task.task_id]);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> taskDelete(int task_id) async {
    var db = await DatabaseHelper.databaseAccess();

    await db.delete("task", where: "task_id = ?", whereArgs: [task_id]);
  }
}
