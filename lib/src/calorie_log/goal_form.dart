import 'package:contacal/src/calorie_log/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GoalForm extends StatefulWidget {
  final Function? onSubmit;
  final int currentValue;
  const GoalForm({super.key, this.onSubmit, required this.currentValue});

  @override
  GoalFormState createState() {
    return GoalFormState();
  }
}

class GoalFormState extends State<GoalForm> {
  final _formKey = GlobalKey<FormState>();
  int _dailyGoal = 0;

  @override
  void initState() {
    _dailyGoal = widget.currentValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  child: TextFormField(
                    initialValue: _dailyGoal.toString(),
                    onSaved: (value) {
                      _dailyGoal = int.parse(value!);
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
                ),

                // Name input field
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: FloatingActionButton(
                    backgroundColor: Style.buttonColor,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        widget.onSubmit!.call(_dailyGoal);
                      }
                    },
                    child: const Icon(Icons.add),
                  ),
                ),
              ]),
        ));
  }
}
