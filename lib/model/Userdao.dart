import 'package:todo_list/model/User.dart';
import 'package:todo_list/model/database_helper.dart';

class UserDao {
  Future<List<User>> getAllUsers() async {
    var db = await DatabaseHelper.databaseAccess();

    List<Map<String, dynamic>> maps = await db.rawQuery("SELECT *  FROM user");

    return List.generate(maps.length, (i) {
      var row = maps[i];

      return User(row["user_id"], row["user_name"], row["user_password"]);
    });
  }

  Future<void> addUser(String user_name, String user_password) async {
    var db = await DatabaseHelper.databaseAccess();

    var info = Map<String, dynamic>();
    info["user_name"] = user_name;
    info["user_password"] = user_password;

    await db.insert("user", info);
  }

  Future<void> deleteUser(int user_id) async {
    var db = await DatabaseHelper.databaseAccess();

    await db.delete("user", where: "user_id = ?", whereArgs: [user_id]);
  }
}
