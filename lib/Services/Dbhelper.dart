import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

class Dbhelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute('''CREATE TABLE notes(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        title TEXT,
        description TEXT,
        color INTEGER,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      ''');
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'notes.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  static Future<int> create(String title, String? descrption, int color) async {
    final db = await Dbhelper.db();
    final data = {'title': title, 'description': descrption, 'color': color};
    final id = await db.insert('notes', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getall() async {
    final db = await Dbhelper.db();
    return db.query('notes', orderBy: "id");
  }

  static Future<List<Map<String, dynamic>>> getbyid(int id) async {
    final db = await Dbhelper.db();
    return db.query('notes', where: "id = ?", whereArgs: [id], limit: 1);
  }

  static Future<int> update(
      int id, String title, String? descrption, int color) async {
    final db = await Dbhelper.db();
    final data = {
      'title': title,
      'description': descrption,
      'color': color,
      'createdAt': DateTime.now().toString()
    };
    final result =
        await db.update('notes', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  static Future<void> delete(int id) async {
    final db = await Dbhelper.db();
    try {
      await db.delete("notes", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
}
