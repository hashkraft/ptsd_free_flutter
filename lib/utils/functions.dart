import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:uuid/uuid.dart';
import 'dart:developer' as developer;

Future<void> setPincodeRange(int lb, int ub, String num) async {
  for (int pin = lb; pin <= ub; pin++) {
    await FirebaseFirestore.instance
        .collection("hotline")
        .add({"zipcode": pin.toString(), "hotline": num}).then((value) {
      developer.log("$pin Added");
    });
  }
}

Future<void> setSinglePincode(String pin, String num) async {
  await FirebaseFirestore.instance
      .collection("hotline")
      .add({"zipcode": pin, "hotline": num});
}

Future<String?> getId() async {
  var deviceInfo = DeviceInfoPlugin();
  if (Platform.isIOS) {
    var iosDeviceInfo = await deviceInfo.iosInfo;
    return iosDeviceInfo.identifierForVendor; // unique ID on iOS
  } else if (Platform.isAndroid) {
    var androidDeviceInfo = await deviceInfo.androidInfo;
    return androidDeviceInfo.id; // unique ID on Android
  }
}

List<String> separateStrings(String input) {
  List<String> separatedList = input.split(',');
  separatedList = separatedList.map((str) => str.trim()).toList();
  return separatedList;
}

String abbreviateDays(String input) {
  // Define a map of day abbreviations
  final dayAbbreviations = {
    'Monday': 'Mo',
    'Tuesday': 'Tu',
    'Wednesday': 'We',
    'Thursday': 'Th',
    'Friday': 'Fr',
    'Saturday': 'Sa',
    'Sunday': 'Su',
  };

  final days = input.split(',');

  final abbreviatedDays = days.map((day) {
    final trimmedDay = day.trim();
    return dayAbbreviations[trimmedDay] ?? trimmedDay;
  });

  // Join the abbreviated days into a comma-separated string
  final result = abbreviatedDays.join(',');

  return result;
}

void showSnackbar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 2),
    ),
  );
}

void showSnackbarWithColor(
    BuildContext context, String message, Color bgColor) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: bgColor,
      duration: const Duration(seconds: 3),
    ),
  );
}

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

String convertTimeFormat(String inputTime) {
  List<String> timeParts = inputTime.split(':');
  int hours = int.parse(timeParts[0]);
  int minutes = int.parse(timeParts[1]);

  String period = (hours >= 12) ? 'PM' : 'AM';
  hours = (hours > 12) ? (hours - 12) : hours;
  hours = (hours == 0) ? 12 : hours;
  String hoursStr = hours.toString();
  String minutesStr = minutes.toString();
  if (hours < 10) {
    hoursStr = "0$hours";
  }
  if (minutes < 10) {
    minutesStr = "0$minutes";
  }
  String formattedTime = '$hoursStr:$minutesStr $period';

  return formattedTime;
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
