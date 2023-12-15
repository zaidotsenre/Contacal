import 'package:contacal/src/entry_form.dart';
import 'package:flutter/material.dart';

import '../db_helper.dart';
import 'entry_list_tile.dart';

/// Displays a list of SampleItems.
class EntryCardView extends StatefulWidget {
  const EntryCardView({super.key});

  static const routeName = '/';

  @override
  State<StatefulWidget> createState() => EntryCardViewState();
}

class EntryCardViewState extends State<EntryCardView> {
  List<Map<String, dynamic>> _entries = [];
  DateTime _selectedDate = DateUtils.dateOnly(DateTime.now());

  /// Displays the form to add and edit entries
  showNewEntryForm() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Wrap(
          children: [
            EntryForm(
              selectedDate: _selectedDate,
              onSubmit: () {
                Navigator.pop(context);
                updateView();
              },
            ),
          ],
        );
      },
    );
  }

  /// Returns a List of tiles with the contents of the current state
  List<EntryListTile> buildListTiles() {
    List<EntryListTile> tiles = [];
    for (var entry in _entries) {
      final tile = EntryListTile(
        entry: entry,
        onDelete: () {
          updateView();
        },
      );
      tiles.add(tile);
    }
    return tiles;
  }

  ///Calculates daily total calories and returns the result as a string
  String dailyTotalCalories() {
    int total = 0;
    for (var entry in _entries) {
      total += entry['calories'] as int;
    }
    return total.toString();
  }

  /// Reads from the database and updates the view
  updateView() async {
    final data = await DBHelper.getEntriesByDate(_selectedDate);
    setState(() {
      _entries = data;
    });
  }

  /// Formats the [date] to be displayed in the bottom bar. Returns a string
  formatDate(DateTime date) {
    final today = DateUtils.dateOnly(DateTime.now());
    date = DateUtils.dateOnly(date);
    final difference = today.difference(date);

    switch (difference.inDays) {
      case 0:
        return 'Today';
      case 1:
        return 'Yesterday';
      default:
        return '${date.toLocal().month}/${date.toLocal().day}/${date.toLocal().year}';
    }
  }

  @override
  void initState() {
    updateView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GestureDetector(
      onPanEnd: (details) {
        // Decrease selected date when user swipes right.
        if (details.velocity.pixelsPerSecond.dx > 1) {
          _selectedDate = _selectedDate.subtract(const Duration(days: 1));
          updateView();
        }
        // Increase selected date when user swipes right.
        if (details.velocity.pixelsPerSecond.dx < 1) {
          // Date should not exceed today's date
          if (DateTime.now().difference(_selectedDate).inDays > 0) {
            _selectedDate = _selectedDate.add(const Duration(days: 1));
            updateView();
          }
        }
      },
      child: Center(
        child: FractionallySizedBox(
          widthFactor: 1,
          heightFactor: 1,
          child: Column(
            children: [
              Container(
                  color: Colors.blueAccent,
                  height: 150,
                  width: double.maxFinite,
                  child: Padding(
                      padding: const EdgeInsets.only(
                        top: 30,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Button to add exercise entry
                              FloatingActionButton(
                                  onPressed: () {
                                    showNewEntryForm();
                                  },
                                  child: const Icon(Icons.directions_run))
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                dailyTotalCalories(),
                                style: const TextStyle(fontSize: 40),
                              ),
                              const Text(
                                "1500",
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Button to add food entry
                              FloatingActionButton(
                                  onPressed: () {
                                    showNewEntryForm();
                                  },
                                  child: const Icon(Icons.fastfood))
                            ],
                          ),
                        ],
                      ))),
              Expanded(
                  child: Container(
                      color: Colors.black12,
                      child: ListView(children: buildListTiles()))),
              Container(
                  //constraints: const BoxConstraints.expand(height: 100),
                  color: Colors.blueAccent,
                  height: 50,
                  width: double.maxFinite,
                  child: Center(child: Text(formatDate(_selectedDate))))
            ],
          ),
        ),
      ),
    ));
  }
}
