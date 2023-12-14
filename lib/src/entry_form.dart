import 'package:contacal/src/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Define a custom Form widget.
class EntryForm extends StatefulWidget {
  final Function? onSubmit;
  final Map<String, dynamic>? entry;
  const EntryForm({super.key, this.onSubmit, this.entry});

  @override
  EntryFormState createState() {
    return EntryFormState();
  }
}

class EntryFormState extends State<EntryForm> {
  final _formKey = GlobalKey<FormState>();
  String? _name;
  int? _calories;

  @override
  void initState() {
    if (widget.entry != null) {
      _name = widget.entry!['name'];
      _calories = widget.entry!['calories'];
    }
    super.initState();
  }

  /// Returns empty string if [number] is null. Returns a the value as a String
  /// ohterwise.
  String nullCheck(int? number) {
    return number == null ? '' : number.toString();
  }

  /// Creates a new row in the entries database using the form's current state.
  /// Calls onSubmit
  submit() {
    final date = widget.entry != null
        ? widget.entry!['date']
        : DateTime.now().toString();

    Map<String, dynamic> newEntry = {
      'calories': _calories,
      'name': _name,
      'date': date
    };
    DBHelper.saveEntry(newEntry);
    widget.onSubmit!.call();
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          SizedBox(
            width: double.maxFinite,
            height: 500,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Calories input field
                  TextFormField(
                    initialValue: nullCheck(_calories),
                    onSaved: (value) {
                      _calories = int.parse(value!);
                    },
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: const InputDecoration(hintText: "Calories"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the number of calories';
                      }
                      return null;
                    },
                  ),
                  // Name input field
                  TextFormField(
                    initialValue: _name ?? '',
                    onSaved: (value) {
                      _name = value;
                    },
                    decoration: const InputDecoration(hintText: "Description"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        submit();
                      }
                    },
                    child: const Text('Submit'),
                  ),
                ]),
          )
        ],
      ),
    );
  }
}
