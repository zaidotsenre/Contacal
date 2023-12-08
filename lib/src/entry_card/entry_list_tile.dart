import 'package:contacal/src/entry_card/entry.dart';
import 'package:flutter/material.dart';

class EntryListTile extends StatelessWidget {
  final Entry? entry;

  const EntryListTile({super.key, this.entry});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: Text(entry?.calories.toString() ?? ''),
        title: Text(entry?.name ?? ''),
        trailing: FloatingActionButton.small(
          onPressed: null,
          child: Icon(Icons.delete),
        ));
  }
}
