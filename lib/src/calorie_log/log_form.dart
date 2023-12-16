import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Define a custom Form widget.
class LogForm extends StatefulWidget {
  final Function? onSubmit;
  final Map<String, dynamic>? entry;
  final bool exercise;
  const LogForm({super.key, this.onSubmit, this.entry, this.exercise = false});

  @override
  LogFormState createState() {
    return LogFormState();
  }
}

class LogFormState extends State<LogForm> {
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

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Form(
          key: _formKey,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
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
                      _calories = widget.exercise ? _calories! * -1 : _calories;
                      widget.onSubmit!.call(_calories, _name);
                    }
                  },
                  child: const Text('Submit'),
                ),
              ]),
        ));
  }
}
