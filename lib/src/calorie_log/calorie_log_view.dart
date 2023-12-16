import 'package:contacal/src/calorie_log/goal_form.dart';
import 'package:contacal/src/calorie_log/calorie_log_controller.dart';
import 'package:contacal/src/calorie_log/log_form.dart';
import 'package:contacal/src/calorie_log/style.dart';
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
      isScrollControlled: true,
      backgroundColor: Style.secondaryColor,
      context: context,
      builder: (context) {
        return LogForm(
          exercise: exercise,
          onSubmit: (calories, name) {
            widget.controller.logCalories(calories, name).then((value) {
              Navigator.pop(context);
              setState(() {});
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
              setState(() {});
            },
          );
        },
      );
      tiles.add(tile);
    }
    return tiles;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Style.primaryColor,
        resizeToAvoidBottomInset: true,
        body: GestureDetector(
          onPanEnd: (details) {
            // Decrease selected date when user swipes right.
            if (details.velocity.pixelsPerSecond.dx > 1) {
              widget.controller.previousDay().then((value) {
                setState(() {});
              });
            }
            // Increase selected date when user swipes right.
            if (details.velocity.pixelsPerSecond.dx < 1) {
              widget.controller.nextDay().then((value) {
                setState(() {});
              });
            }
          },
          child: Center(
            child: FractionallySizedBox(
              widthFactor: 1,
              heightFactor: 1,
              child: Column(
                children: [
                  Container(
                      color: Style.secondaryColor,
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
                                      backgroundColor: Style.buttonColor,
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
                                          isScrollControlled: true,
                                          backgroundColor: Style.secondaryColor,
                                          context: context,
                                          builder: (context) {
                                            return GoalForm(
                                              currentValue:
                                                  widget.controller.dailyGoal,
                                              onSubmit: (value) {
                                                widget.controller.dailyGoal =
                                                    value;
                                                Navigator.pop(context);
                                                setState(() {});
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
                                      backgroundColor: Style.buttonColor,
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
                      color: Style.secondaryColor,
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
