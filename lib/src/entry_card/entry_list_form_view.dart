import 'package:contacal/src/entry_card/entry.dart';
import 'package:flutter/material.dart';

class EntryListView extends StatelessWidget {
  List<Entry>? entries;

  EntryListView(this.entries, {super.key});

  Widget Build (BuildContext context){

  }


  ListView(
                  children: [
                    ListTile(
                      leading: Text("3"),
                      title: Text("Bread"),
                      subtitle: Text("500 cal"),
                      trailing: FloatingActionButton.small(
                        onPressed: null,
                        child: Icon(Icons.delete),
                      ),
                    ),
                    ListTile(
                      leading: Text("3"),
                      title: Text("Bread"),
                      subtitle: Text("500 cal"),
                      trailing: FloatingActionButton.small(
                        onPressed: null,
                        child: Icon(Icons.delete),
                      ),
                    ),
                    ListTile(
                      leading: Text("3"),
                      title: Text("Bread"),
                      subtitle: Text("500 cal"),
                      trailing: FloatingActionButton.small(
                        onPressed: null,
                        child: Icon(Icons.delete),
                      ),
                    ),
                    ListTile(
                      leading: Text("3"),
                      title: Text("Bread"),
                      subtitle: Text("500 cal"),
                      trailing: FloatingActionButton.small(
                        onPressed: null,
                        child: Icon(Icons.delete),
                      ),
                    )
                  ],
                )
}
