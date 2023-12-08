import 'package:contacal/src/entry_card/entry.dart';
import 'package:contacal/src/entry_card/entry_list_tile.dart';
import 'package:flutter/material.dart';

class EntryListView extends StatelessWidget {
  final List<Entry>? entries;
  const EntryListView({super.key, this.entries});

  buildListTiles() {
    final tiles = [];
    for (var entry in entries ?? []) {
      tiles.add(EntryListTile(
        entry: entry,
      ));
    }
    return tiles;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: List<Widget>.from(buildListTiles()),
    );
  }
}
