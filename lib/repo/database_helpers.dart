import 'package:flutter/material.dart';
import 'package:ptsd_free/models/reminder.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:developer' as developer;
import 'package:ptsd_free/utils/values.dart' as values;
import 'package:ptsd_free/utils/functions.dart' as functions;

class DatabaseHelper {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, values.dbName);
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE ${values.tableName} (id INTEGER PRIMARY KEY, days TEXT, trigger TEXT, stress_start_time TEXT, stress_end_time TEXT, uuid TEXT)
        ''');
        db.execute('''
         CREATE TABLE ${values.mapperTableName} (id INTEGER PRIMARY KEY, uuid TEXT, alarmIDs TEXT)
        ''');
      },
    );
  }

  Future<List<int>> saveToDatabase({
    required final List<String> selectedDays,
    required final String selectedReminderWhen,
    required final TimeOfDay selectedTime1,
    required final TimeOfDay selectedTime2,
    required final String uuid,
  }) async {
    List<int> alarmIds = [];
    for (String day in selectedDays) {
      alarmIds.add(functions.randomUniqueNumber());
    }
    String alarmIdsInString = functions.convertIntArrayToString(alarmIds);
    developer.log(alarmIdsInString);
    final db = await database;
    developer.log(uuid);
    db.insert(values.tableName, {
      "days": selectedDays.join(', '),
      "trigger": selectedReminderWhen,
      "stress_start_time": functions.timeToString(selectedTime1),
      "stress_end_time": functions.timeToString(selectedTime2),
      "uuid": uuid,
    });
    db.insert(values.mapperTableName, {
      "uuid": uuid,
      "alarmIDs": alarmIdsInString,
    });
    return alarmIds;
  }

  Future getReminders() async {
    final db = await database;
    return db.query(values.tableName);
  }

  Future<int> insertReminder(Reminder reminder) async {
    final db = await database;
    developer.log(reminder.toMap().toString());
    return await db.insert(values.dbName, reminder.toMap());
  }

  Future<int> deleteReminder(int id) async {
    final db = await database;
    return await db.delete(
      values.tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteReminderByTime(String dateTime) async {
    final db = await database;
    return await db.delete(
      values.dbName,
      where: 'dateTime = ?',
      whereArgs: [dateTime],
    );
  }

  // Future<List<Reminder>> getReminders() async {
  //   final db = await database;
  //   final List<Map<String, dynamic>> maps = await db.query(values.dbName);
  //   return List.generate(maps.length, (i) {
  //     return Reminder.fromMap(maps[i]);
  //   });
  // }

  Future<int> getReminderID(DateTime datetime) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      values.dbName,
      where: 'dateTime = ?',
      whereArgs: [datetime.toIso8601String()],
    );
    return maps[0]['id'];
  }

  Future alarmIdsByUUID(String uuid) async {
    final db = await database;
    final numberString = (await db.query(values.mapperTableName,
            where: 'uuid = ?', whereArgs: [uuid]))
        .first['alarmIDs'];
    List alarmIDs = functions.convertStringToIntArray(numberString.toString());
    developer.log(alarmIDs.toString());
    return alarmIDs;
  }

  // Future<int> deleteReminder(int id) async {
  //   var databasesPath = await getDatabasesPath();
  //   String path = join(databasesPath, values.dbName);

  //   Database database = await openDatabase(path, version: 1,
  //       onCreate: (Database db, int version) async {
  //     await db.execute(
  //         'CREATE TABLE ${values.tableName} (id INTEGER PRIMARY KEY, days TEXT, trigger TEXT, stress_start_time TEXT, stress_end_time TEXT)');
  //   });

  //   return await database.delete(
  //     values.tableName,
  //     where: 'id = ?',
  //     whereArgs: [id],
  //   );
  // }
}
