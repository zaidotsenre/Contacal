import 'package:contacal/src/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Define a custom Form widget.
class CalorieGoalForm extends StatefulWidget {
  final Function? onSubmit;
  final int dailyCalorieGoal;
  const CalorieGoalForm(
      {super.key, this.onSubmit, required this.dailyCalorieGoal});

  @override
  CalorieGoalFormState createState() {
    return CalorieGoalFormState();
  }
}

class CalorieGoalFormState extends State<CalorieGoalForm> {
  final _formKey = GlobalKey<FormState>();
  int _dailyCalorieGoal = 0;

  @override
  void initState() {
    _dailyCalorieGoal = widget.dailyCalorieGoal;
    super.initState();
  }

  /// Updates the database with the new daily calorie goal
  submit() {
    Map<String, dynamic> newSetting = {
      'key': 'dailyCalorieGoal',
      'value': _dailyCalorieGoal
    };
    DBHelper.saveSetting(newSetting);
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
                    initialValue: _dailyCalorieGoal.toString(),
                    onSaved: (value) {
                      _dailyCalorieGoal = int.parse(value!);
                    },
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: const InputDecoration(hintText: "Daily Goal"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your daily goal.';
                      }
                      return null;
                    },
                  ),
                  // Name input field
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
