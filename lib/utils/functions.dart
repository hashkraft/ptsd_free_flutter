import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:uuid/uuid.dart';

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
      duration: const Duration(seconds: 2),
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
