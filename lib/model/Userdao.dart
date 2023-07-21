import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list/model/User.dart';
import 'package:todo_list/model/database_helper.dart';

class UserDao {
  static const String user_Id = "user_id";
  Future<List<User>> getAllUsers() async {
    var db = await DatabaseHelper.databaseAccess();

    List<Map<String, dynamic>> maps = await db.rawQuery("SELECT *  FROM user");

    return List.generate(maps.length, (i) {
      var row = maps[i];

      return User(row["user_id"], row["user_name"], row["user_password"],
          row["isAdmin"]);
    });
  }

  Future<User> addUser(
      String user_name, String user_password, int isAdmin) async {
    var db = await DatabaseHelper.databaseAccess();

    var info = Map<String, dynamic>();
    info["user_name"] = user_name;
    info["user_password"] = user_password;
    info["isAdmin"] = isAdmin;

    int id = await db.insert("user", info);

    await saveUserId(id);

    return User(id, user_name, user_password, isAdmin);
  }

  Future<void> saveUserId(int userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(user_Id, userId);
  }

  Future<int?> getSavedUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(user_Id);
  }

  Future<void> _saveUserId(int userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(user_Id, userId);
  }

  Future<int?> _getSavedUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(user_Id);
  }

  Future<void> deleteUser(int user_id) async {
    var db = await DatabaseHelper.databaseAccess();

    await db.delete("user", where: "user_id = ?", whereArgs: [user_id]);
  }

  Future<bool> controlUser(String username, String password) async {
    var db = await DatabaseHelper.databaseAccess();

    List<Map<String, dynamic>> maps =
        await db.query("user", where: "user_name = ?", whereArgs: [username]);

    if (maps.isNotEmpty) {
      int userId = maps[0]["user_id"];
      saveUserId(userId);
      return true;
    } else
      return false;
  }

  Future<void> assignAdmin(int userId) async {
    var db = await DatabaseHelper.databaseAccess();

    await db.update(
      "user",
      {"isAdmin": 1},
      where: "user_id = ?",
      whereArgs: [userId],
    );
  }

  Future<int?> getUserId() async {
    int? savedUserId = await _getSavedUserId();

    if (savedUserId == null) {
      var db = await DatabaseHelper.databaseAccess();

      List<Map<String, dynamic>> maps = await db.query("user");

      if (maps.isNotEmpty) {
        int userId = maps[0]["user_id"];
        await _saveUserId(userId);

        return userId;
      }
    }
    return savedUserId;
  }

  Future<bool> checkAdmin(String username, String password) async {
    var db = await DatabaseHelper.databaseAccess();

    List<Map<String, dynamic>> maps = await db.query(
      "user",
      where: "user_name = ? AND user_password = ?",
      whereArgs: [username, password],
    );

    if (maps.isNotEmpty) {
      int isAdmin = maps[0]["isAdmin"];
      return isAdmin == 1;
    } else {
      return false;
    }
  }
}
