import 'package:flutter/material.dart';

// Convert TimeOfDay to String
String timeToString(TimeOfDay time) {
  String hour = time.hour.toString().padLeft(2, '0');
  String minute = time.minute.toString().padLeft(2, '0');
  return '$hour:$minute';
}

// Convert String to TimeOfDay
TimeOfDay stringToTime(String str) {
  List<String> parts = str.split(':');
  int hour = int.parse(parts[0]);
  int minute = int.parse(parts[1]);
  return TimeOfDay(hour: hour, minute: minute);
}
