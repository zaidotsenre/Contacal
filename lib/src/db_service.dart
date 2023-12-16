import 'dart:io';

import 'package:contacal/src/date_only.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBService {
  /// Opens or creates the database
  static Future<Database> openDB() async {
    final dbPath =
        join((await getApplicationDocumentsDirectory()).path, 'contacal.db');

    Directory(dirname(dbPath)).create(recursive: true);
    return openDatabase(dbPath, onCreate: (db, version) async {
      await db.execute(
        """CREATE TABLE entries (
          "id"	INTEGER NOT NULL UNIQUE,
          "name"	TEXT,
          "calories"	INTEGER NOT NULL,
          "date"	TEXT NOT NULL,
          PRIMARY KEY("id" AUTOINCREMENT)
        );
        """,
      );
      await db.execute(
        """CREATE TABLE settings (
          "key"	TEXT NOT NULL UNIQUE,
          "value"	INTEGER NOT NULL,
          PRIMARY KEY("key")
        );
        """,
      );
      await db.insert('settings', {'key': 'dailyGoal', 'value': 2000},
          conflictAlgorithm: ConflictAlgorithm.replace);
    }, version: 1);
  }

  /// Updates the value of daily goal in the database
  static Future<void> setDailyGoal(int value) async {
    final db = await openDB();
    db.insert('settings', {'key': 'dailyGoal', 'value': value},
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  /// Returnsthe current value of daily goal in the database
  static Future<dynamic> getDailyGoal() async {
    final db = await openDB();
    final data =
        await db.query('settings', where: 'key=?', whereArgs: ['dailyGoal']);
    return data[0]['value'];
  }

  /// Returns all the rows in the entries table
  static Future<List<Map<String, dynamic>>> getAllEntries() async {
    final db = await openDB();
    return db.query('entries', orderBy: 'date');
  }

  /// Returns all the rows in the entries table that match [date]
  static Future<List<Map<String, dynamic>>> getEntriesByDate(
      DateOnly date) async {
    final db = await openDB();
    return db
        .query('entries', where: 'date=?', whereArgs: [date.value.toString()]);
  }

  /// Inserts [entry] into the database or updates it if it already exists
  static Future<void> saveEntry(Map<String, dynamic> entry) async {
    final db = await openDB();
    entry['date'] = entry['date'].value.toString();
    db.insert('entries', entry, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  /// Deletes rows fromt he entries table that match [id]
  static Future<void> deleteEntry(int id) async {
    final db = await openDB();
    db.delete('entries', where: 'id=?', whereArgs: [id]);
  }
}
