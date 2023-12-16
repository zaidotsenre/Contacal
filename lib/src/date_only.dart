import 'package:flutter/material.dart';

class DateOnly {
  DateOnly(date) : _value = DateUtils.dateOnly(date);

  final DateTime _value;

  DateTime get value => _value;
  String get formattedString {
    final today = DateOnly(DateTime.now());
    final difference = today.value.difference(_value);

    switch (difference.inDays) {
      case 0:
        return 'Today';
      case 1:
        return 'Yesterday';
      default:
        return '${_value.month}/${_value.day}/${_value.year}';
    }
  }
}
