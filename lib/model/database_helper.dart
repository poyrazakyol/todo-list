import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final String ToDo = "todo.sqlite";

  static Future<Database> databaseAccess() async {
    String databasePath = join(await getDatabasesPath(), ToDo);

    if (await databaseExists(databasePath)) {
      print("Already have a database");
    } else {
      ByteData data = await rootBundle.load("database/$ToDo");
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(databasePath).writeAsBytes(bytes, flush: true);
      print("Database Copied");
    }

    return openDatabase(databasePath);
  }
}
