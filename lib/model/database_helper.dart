import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const String databaseName = "todo.sqlite";

  static Future<Database> databaseAccess() async {
    String databasePath = p.join(await getDatabasesPath(), databaseName);

    Database database = await openDatabase(databasePath, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE Todo (id INTEGER PRIMARY KEY, account TEXT, task TEXT, isDone INTEGER)');
    });

    return database;
  }
}
