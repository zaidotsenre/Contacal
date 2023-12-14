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

  showNewEntryForm() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Wrap(
          children: [
            EntryForm(
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

  updateView() async {
    final data = await DBHelper.getAllEntries();
    setState(() {
      _entries = data;
    });
  }

  @override
  void initState() {
    updateView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
                          const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "500",
                                style: TextStyle(fontSize: 40),
                              ),
                              Text(
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
                  child: Center(
                      child:
                          Text(DateUtils.dateOnly(DateTime.now()).toString())))
            ],
          ),
        ),
      ),
    );
  }
}
