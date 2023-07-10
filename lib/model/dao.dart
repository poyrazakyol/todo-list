import 'package:todo_list/model/database_helper.dart';
import 'package:todo_list/model/todo.dart';

class ToDoDao {
  Future<List<ToDo>> getAll() async {
    var db = await DatabaseHelper.databaseAccess();

    List<Map<String, dynamic>> notes = await db.rawQuery("SELECT * FROM ToDo");

    return List.generate(notes.length, (i) {
      var note = notes[i];

      return ToDo(
          id: note["id"],
          accountid: note["account"],
          todoText: note["task"],
          isDone: note["isDone"]);
    });
  }

  Future<void> addNote(String account, String task, int isDone) async {
    var db = await DatabaseHelper.databaseAccess();

    Map<String, dynamic> note = {};
    note["account"] = account;
    note["task"] = task;
    note["isDone"] = isDone;

    await db.insert("ToDo", note);
  }

  /*Future<List<FoodNote>> getCategory(String category) async {
    var db = await DatabaseHelper.databaseAccess();

    //List<Map<String, dynamic>> foods = await db.rawQuery("SELECT * FROM Foods WHERE category = $category");
    List<Map<String, dynamic>> foods =
        await db.query("Foods", where: "category = ?", whereArgs: [category]);

    return List.generate(foods.length, (i) {
      var food = foods[i];

      return FoodNote(food["id"], food["category"], food["foodName"],
          food["restName"], food["rating"], food["restAddr"]);
    });
  }*/

  Future<void> noteUpdate(ToDo todo) async {
    var db = await DatabaseHelper.databaseAccess();

    Map<String, dynamic> info = {};
    info["account"] = todo.accountid!;
    info["task"] = todo.todoText!;
    info["isDone"] = todo.isDone!;
    //info["id"] = todo.id!;


    try {
      await db.update("ToDo", info, where: "id = ?", whereArgs: [todo.id]);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> noteDelete(int id) async {
    var db = await DatabaseHelper.databaseAccess();

    await db.delete("ToDo", where: "id = ?", whereArgs: [id]);
  }

  Future<void> deleteDB() async {
    var db = await DatabaseHelper.databaseAccess();

    db.delete("ToDo");
  }
}
