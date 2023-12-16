import 'package:contacal/src/date_only.dart';
import 'package:contacal/src/db_service.dart';

class CalorieLogController {
  CalorieLogController(this._date);

  // Private members
  late List<Map<String, dynamic>> _entries;
  late int _dailyGoal;
  DateOnly _date;

  // Getters
  List<Map<String, dynamic>> get entries => _entries;
  int get dailyGoal => _dailyGoal;
  DateOnly get date => _date;
  int get dailyTotal {
    int total = 0;
    for (var entry in _entries) {
      total += entry['calories'] as int;
    }
    return total;
  }

  // Setters
  set date(DateOnly value) {
    _date = value;
    loadData();
  }

  set dailyGoal(int value) {
    _dailyGoal = value;
    DBService.setDailyGoal(value);
  }

  /// Changes selected date to the one day after the currently selecte day
  Future<void> nextDay() async {
    if (DateTime.now().difference(_date.value).inDays > 0) {
      _date = DateOnly(_date.value.add(const Duration(days: 1)));
    }
    await loadData();
  }

  /// Changes selected date to the one before after the currently selecte day
  Future<void> previousDay() async {
    _date = DateOnly(_date.value.subtract(const Duration(days: 1)));
    await loadData();
  }

  /// Loads data from DB Service
  Future<void> loadData() async {
    _entries = await DBService.getEntriesByDate(_date);
    _dailyGoal = await DBService.getDailyGoal();
    print("LOG: Loaded data.");
  }

  Future<void> logCalories(calories, name) async {
    Map<String, dynamic> newEntry = {
      'calories': calories,
      'name': name,
      'date': date
    };
    DBService.saveEntry(newEntry);
    await loadData();
  }

  Future<void> deleteLog(id) async {
    await DBService.deleteEntry(id);
    await loadData();
  }
}
