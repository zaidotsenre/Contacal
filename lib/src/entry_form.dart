import 'package:flutter/material.dart';

Form EntryForm() {






  return Form(
    key: _formKey,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextFormField(
          decoration: const InputDecoration(
            hintText: 'Enter your email',
          ),
          validator: (String? value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: ElevatedButton(
            onPressed: () {
              // Validate will return true if the form is valid, or false if
              // the form is invalid.
              if (_formKey.currentState!.validate()) {
                // Process data.
              }
            },
            child: const Text('Submit'),
          ),
        ),
      ],
    ),
  );
}

class EntryForm {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Enter your email',
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                // Validate will return true if the form is valid, or false if
                // the form is invalid.
                if (_formKey.currentState!.validate()) {
                  // Process data.
                }
              },
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}




import 'package:flutter/material.dart';

/// Flutter code sample for [PopupRoute].

void main() => runApp(const PopupRouteApp());

class PopupRouteApp extends StatelessWidget {
  const PopupRouteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: PopupRouteExample(),
    );
  }
}

class PopupRouteExample extends StatelessWidget {
  const PopupRouteExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: OutlinedButton(
          onPressed: () {
            // This shows a dismissible dialog.
            Navigator.of(context).push(DismissibleDialog<void>());
          },
          child: const Text('Open DismissibleDialog'),
        ),
      ),
    );
  }
}

class DismissibleDialog<T> extends PopupRoute<T> {
  @override
  Color? get barrierColor => Colors.black.withAlpha(0x50);

  // This allows the popup to be dismissed by tapping the scrim or by pressing
  // the escape key on the keyboard.
  @override
  bool get barrierDismissible => true;

  @override
  String? get barrierLabel => 'Dismissible Dialog';

  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return Center(
      // Provide DefaultTextStyle to ensure that the dialog's text style
      // matches the rest of the text in the app.
      child: DefaultTextStyle(
        style: Theme.of(context).textTheme.bodyMedium!,
        // UnconstrainedBox is used to make the dialog size itself
        // to fit to the size of the content.
        child: UnconstrainedBox(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Column(
              children: <Widget>[
                Text('Dismissible Dialog',
                    style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(height: 20),
                const Text('Tap in the scrim or press escape key to dismiss.'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
