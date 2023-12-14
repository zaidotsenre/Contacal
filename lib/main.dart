import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'src/app.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';

createDB() async {
  final dbPath =
      join((await getApplicationDocumentsDirectory()).path, 'contacal.db');
  final dbExists = await databaseExists(dbPath);

  if (!dbExists) {
    try {
      Directory(dirname(dbPath)).create(recursive: true);
    } catch (_) {}

    await openDatabase(dbPath, onCreate: (db, version) {
      db.execute(
        """CREATE TABLE "entries" (
          "id"	INTEGER NOT NULL UNIQUE,
          "name"	TEXT,
          "calories"	INTEGER NOT NULL,
          "date"	TEXT NOT NULL,
          PRIMARY KEY("id" AUTOINCREMENT)
        );
        """,
      );
    }, version: 1);
  }
}

void main() async {
  // DB set up
  WidgetsFlutterBinding.ensureInitialized();
  createDB();

  // Set up the SettingsController, which will glue user settings to multiple
  // Flutter Widgets.
  final settingsController = SettingsController(SettingsService());

  // Load the user's preferred theme while the splash screen is displayed.
  // This prevents a sudden theme change when the app is first displayed.
  await settingsController.loadSettings();

  // Run the app and pass in the SettingsController. The app listens to the
  // SettingsController for changes, then passes it further down to the
  // SettingsView.
  runApp(MyApp(settingsController: settingsController));
}
