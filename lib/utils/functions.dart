import 'package:flutter/material.dart';
import 'dart:math';
import 'package:uuid/uuid.dart';

String timeToString(TimeOfDay time) {
  String hour = time.hour.toString().padLeft(2, '0');
  String minute = time.minute.toString().padLeft(2, '0');
  return '$hour:$minute';
}

String convertIntArrayToString(List<int> intArray) {
  String stringArray = intArray.map((e) => e.toString()).join(",");
  return stringArray;
}

List<int> convertStringToIntArray(String stringArray) {
  List<String> stringList = stringArray.split(",");
  List<int> intList = stringList.map((e) => int.parse(e)).toList();

  return intList;
}

int randomUniqueNumber() {
  String randomUuid = const Uuid().v4();
  int hashCode = randomUuid.hashCode;
  Random random = Random(hashCode);
  return random.nextInt(100000000);
}

TimeOfDay stringToTime(String str) {
  List<String> parts = str.split(':');
  int hour = int.parse(parts[0]);
  int minute = int.parse(parts[1]);
  return TimeOfDay(hour: hour, minute: minute);
}

List<int> daysOneDayBefore(List<int> days) {
  List<int> d = [];
  for (int x in days) {
    if (x == 0) {
      d.add(7);
    } else {
      d.add(x - 1);
    }
  }
  return d;
}

List<int> convertDaysToIndices(List<String> days) {
  final Map<String, int> dayMap = {
    'monday': 1,
    'tuesday': 2,
    'wednesday': 3,
    'thursday': 4,
    'friday': 5,
    'saturday': 6,
    'sunday': 7,
  };

  List<int> indices = [];
  for (var day in days) {
    var lowerCaseDay = day.toLowerCase();
    if (dayMap.containsKey(lowerCaseDay)) {
      indices.add(dayMap[lowerCaseDay]!);
    }
  }
  return indices;
}
