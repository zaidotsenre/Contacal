import 'package:contacal/src/calorie_log/goal_form.dart';
import 'package:contacal/src/date_only.dart';
import 'package:contacal/src/calorie_log/calorie_log_controller.dart';
import 'package:contacal/src/calorie_log/log_form.dart';
import 'package:flutter/material.dart';

import 'entry_list_tile.dart';

/// Displays a list of SampleItems.
class CalorieLogView extends StatefulWidget {
  const CalorieLogView({super.key, required this.controller});

  static const routeName = '/';
  final CalorieLogController controller;

  @override
  State<StatefulWidget> createState() => CalorieLogViewState();
}

class CalorieLogViewState extends State<CalorieLogView> {
  /// Displays the form to add and edit entries
  showNewEntryForm({bool exercise = false}) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return LogForm(
          exercise: exercise,
          onSubmit: (calories, name) {
            widget.controller.logCalories(calories, name).then((value) {
              Navigator.pop(context);
              updateView();
            });
          },
        );
      },
    );
  }

  /// Returns a List of tiles with the contents of the current state
  List<EntryListTile> buildListTiles() {
    List<EntryListTile> tiles = [];
    for (var entry in widget.controller.entries) {
      final tile = EntryListTile(
        entry: entry,
        onDelete: (id) {
          widget.controller.deleteLog(id).then(
            (value) {
              updateView();
            },
          );
        },
      );
      tiles.add(tile);
    }
    return tiles;
  }

  /// Reads from the database and updates the view
  updateView() {
    setState(() {});
    print("LOG: Updated view.");
  }

  @override
  void initState() {
    updateView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: GestureDetector(
          onPanEnd: (details) {
            // Decrease selected date when user swipes right.
            if (details.velocity.pixelsPerSecond.dx > 1) {
              widget.controller.previousDay();
              updateView();
            }
            // Increase selected date when user swipes right.
            if (details.velocity.pixelsPerSecond.dx < 1) {
              widget.controller.nextDay();
              updateView();
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
                                        showNewEntryForm(exercise: true);
                                      },
                                      child: const Icon(Icons.directions_run))
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    widget.controller.dailyTotal.toString(),
                                    style: const TextStyle(fontSize: 40),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      showModalBottomSheet(
                                          context: context,
                                          builder: (context) {
                                            return GoalForm(
                                              currentValue:
                                                  widget.controller.dailyGoal,
                                              onSubmit: (value) {
                                                widget.controller.dailyGoal =
                                                    value;
                                                Navigator.pop(context);
                                                updateView();
                                              },
                                            );
                                          });
                                    },
                                    child: Text(
                                      widget.controller.dailyGoal.toString(),
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                  )
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
                      child: Center(
                          child: Text(widget.controller.date.formattedString)))
                ],
              ),
            ),
          ),
        ));
  }
}
