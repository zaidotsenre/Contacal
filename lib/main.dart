import 'package:contacal/src/date_only.dart';
import 'package:contacal/src/calorie_log/calorie_log_controller.dart';
import 'package:flutter/material.dart';

import 'src/app.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final settingsController = SettingsController(SettingsService());
  final calorieLogController = CalorieLogController(DateOnly(DateTime.now()));

  await settingsController.loadSettings();
  await calorieLogController.loadData();

  runApp(MyApp(
    settingsController: settingsController,
    calorieLogController: calorieLogController,
  ));
}
