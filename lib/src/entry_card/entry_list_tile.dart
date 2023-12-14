import 'package:flutter/material.dart';
import '../db_helper.dart';

class EntryListTile extends StatelessWidget {
  final Map<String, dynamic> entry;
  final Function? onDelete;

  const EntryListTile({super.key, required this.entry, this.onDelete});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: Text(entry['calories'].toString()),
        title: Text(entry['name'] ?? ''),
        trailing: FloatingActionButton.small(
          onPressed: () {
            DBHelper.deleteEntry(entry['id']);
            onDelete!.call();
          },
          child: const Icon(Icons.delete),
        ));
  }
}
