import 'package:contacal/src/date_only.dart';
import 'package:contacal/src/calorie_log/calorie_log_controller.dart';
import 'package:flutter/material.dart';

import 'src/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final calorieLogController = CalorieLogController(DateOnly(DateTime.now()));

  await calorieLogController.loadData();

  runApp(MyApp(
    calorieLogController: calorieLogController,
  ));
}
