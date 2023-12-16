import 'package:contacal/src/calorie_log/style.dart';
import 'package:flutter/material.dart';

class EntryListTile extends StatelessWidget {
  final Map<String, dynamic> entry;
  final Function? onDelete;

  const EntryListTile({super.key, required this.entry, this.onDelete});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(entry['calories'].toString()),
        subtitle: Text(entry['name'] ?? ''),
        trailing: FloatingActionButton.small(
          backgroundColor: Style.buttonColor,
          onPressed: () {
            onDelete!.call(entry['id']);
          },
          child: const Icon(Icons.delete),
        ));
  }
}
