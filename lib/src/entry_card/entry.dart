import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class Entry {
  int? id;
  int calories;
  DateTime date;
  String? name;

  Entry({this.id, required this.calories, required this.date, this.name});

  Entry.fromMap(Map<String, dynamic> entries)
      : id = entries['id'],
        calories = entries['calories'],
        date = DateTime.parse(entries['date']),
        name = entries['name'];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'calories': calories,
      'date': date.toString(),
      'name': name
    };
  }

  @override
  String toString() {
    return 'Entry: {id: $id, calories: $calories, date: $date, name: $name}';
  }

  /* Database methods */
  Future<void> save() async {
    final dbPath =
        join((await getApplicationDocumentsDirectory()).path, 'contacal.db');
    final db = await openDatabase(dbPath);
    db.insert('entries', toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    db.close();
  }

  void delete() async {
    final dbPath =
        join((await getApplicationDocumentsDirectory()).path, 'contacal.db');
    final db = await openDatabase(dbPath);
    db.delete('entries', where: 'id=?', whereArgs: [id]);
    db.close();
  }

  /// Returns all of the entries in the database or an empty list if none are found.
  static Future<List<Entry>> getAll() async {
    final dbPath =
        join((await getApplicationDocumentsDirectory()).path, 'contacal.db');
    final db = await openDatabase(dbPath);
    db.query('entries');
    List<Entry> allEntries = [];
    for (var row in (await db.query('entries'))) {
      allEntries.add(Entry.fromMap(row));
    }
    return allEntries;
  }
}
