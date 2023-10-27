import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'package:ptsd_free/utils/values.dart' as values;

String timeToString(TimeOfDay time) {
  String hour = time.hour.toString().padLeft(2, '0');
  String minute = time.minute.toString().padLeft(2, '0');
  return '$hour:$minute';
}

TimeOfDay stringToTime(String str) {
  List<String> parts = str.split(':');
  int hour = int.parse(parts[0]);
  int minute = int.parse(parts[1]);
  return TimeOfDay(hour: hour, minute: minute);
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

Future<void> scheduleNotification({
  required final String title,
  required final String body,
  required final TimeOfDay timeOfDay,
  required final int id,
  required final String channelKey,
  required int weekday,
  final String? summary,
  final Map<String, String>? payload,
  final ActionType actionType = ActionType.Default,
  final NotificationLayout notificationLayout = NotificationLayout.Default,
  final NotificationCategory? category,
  final String? bigPicture,
  final List<NotificationActionButton>? actionButtons,
}) async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: id,
      channelKey: channelKey,
      title: title,
      body: body,
      actionType: actionType,
      notificationLayout: notificationLayout,
      summary: summary,
      category: category,
      payload: payload,
      bigPicture: bigPicture,
    ),
    actionButtons: actionButtons,
    schedule: NotificationCalendar(
      weekday: weekday,
      hour: timeOfDay.hour,
      minute: timeOfDay.minute,
      second: 0,
      repeats: true,
      allowWhileIdle: true,
    ),
  );
}

Future<void> saveToDatabase({
  required final List<String> selectedDays,
  required final String selectedReminderWhen,
  required final TimeOfDay selectedTime1,
  required final TimeOfDay selectedTime2,
  required final String uuid,
}) async {
  var databasesPath = await getDatabasesPath();
  String path = join(databasesPath, values.dbName);

  Database database = await openDatabase(path, version: 1,
      onCreate: (Database db, int version) async {
    await db.execute(
        'CREATE TABLE ${values.tableName} (id INTEGER PRIMARY KEY, days TEXT, trigger TEXT, stress_start_time TEXT, stress_end_time TEXT, uuid TEXT)');
  });

  await database.transaction((txn) async {
    await txn.rawInsert(
        'INSERT INTO ${values.tableName}(days, trigger, stress_start_time, stress_end_time) VALUES("${selectedDays.join(', ')}", "$selectedReminderWhen", "${timeToString(selectedTime1)}", "${timeToString(selectedTime2)}","$uuid")');
  });

  await database.close();
}
