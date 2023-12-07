import 'package:flutter/material.dart';

/// Displays a list of SampleItems.
class CardView extends StatelessWidget {
  CardView({
    super.key,
  });

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // To work with lists that may contain a large number of items, it’s best
      // to use the ListView.builder constructor.
      //
      // In contrast to the default ListView constructor, which requires
      // building all Widgets up front, the ListView.builder constructor lazily
      // builds Widgets as they’re scrolled into view.
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.8,
          heightFactor: 0.95,
          child: Column(
            children: [
              Container(
                  color: Colors.blueAccent,
                  height: 100,
                  width: double.maxFinite,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FloatingActionButton(
                              onPressed: null,
                              child: Icon(Icons.directions_run))
                        ],
                      ),
                      Column(
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
                          FloatingActionButton(
                              onPressed: null, child: Icon(Icons.fastfood))
                        ],
                      ),
                    ],
                  )),
              Expanded(
                  child: Container(
                color: Colors.black12,
                child: ListView(
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
                ),
              )),
              Container(
                  //constraints: const BoxConstraints.expand(height: 100),
                  color: Colors.blueAccent,
                  height: 50,
                  width: double.maxFinite,
                  child: const Center(child: Text("12/25/2023")))
            ],
          ),
        ),
      ),
    );
  }
}
