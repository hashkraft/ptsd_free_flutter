import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:ptsd_free/utils/functions.dart' as func;

class AddReminder extends StatefulWidget {
  const AddReminder({super.key});

  @override
  State<AddReminder> createState() => _AddReminderState();
}

class _AddReminderState extends State<AddReminder> {
  List<String> days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];
  String selectedDay = 'Monday';
  List<String> selectedDays = [];
  String selectedTime = 'Morning';
  List<String> reminderWhenOptions = [
    'During the stress',
    '3 minutes before',
    'Both'
  ];
  String selectedReminderWhen = 'During the stress';
  TimeOfDay selectedTime1 = TimeOfDay(hour: 00, minute: 00);
  TimeOfDay selectedTime2 = TimeOfDay(hour: 00, minute: 00);

  Future<void> _saveToDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'reminders1.db');

    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE reminders (id INTEGER PRIMARY KEY, days TEXT, trigger TEXT, stress_start_time TEXT, stress_end_time TEXT)');
    });

    await database.transaction((txn) async {
      await txn.rawInsert(
          'INSERT INTO reminders(days, trigger, stress_start_time, stress_end_time) VALUES("${selectedDays.join(', ')}", "$selectedReminderWhen", "${func.timeToString(selectedTime1)}", "${func.timeToString(selectedTime2)}")');
    });

    await database.close();
  }

  void _onSave() {
    print('Selected Days: $selectedDays');
    print('Reminder when: $selectedReminderWhen');
    print('Time 1: $selectedTime1');
    print('Time 2: $selectedTime2');
    _saveToDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
            child: Image.asset(
              'assets/images/stopper_screen_head_bg.png',
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Text('Add Reminder'),
            ),
            body: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  const Text(
                    'Select Day(s):',
                    style: TextStyle(fontSize: 16),
                  ),
                  Wrap(
                    children: days.map((day) {
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Checkbox(
                            value: selectedDays.contains(day),
                            onChanged: (value) {
                              setState(() {
                                if (value == true) {
                                  selectedDays.add(day);
                                } else {
                                  selectedDays.remove(day);
                                }
                              });
                            },
                          ),
                          Text(day),
                        ],
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'I want a reminder to breathe',
                    style: TextStyle(fontSize: 16),
                  ),
                  DropdownButton<String>(
                    value: selectedReminderWhen,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedReminderWhen = newValue!;
                      });
                    },
                    items: reminderWhenOptions
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'What time does your stress usually start?',
                    style: TextStyle(fontSize: 16),
                  ),
                  GestureDetector(
                    onTap: () async {
                      TimeOfDay? pickedTime = await showTimePicker(
                        context: context,
                        initialTime: selectedTime1,
                      );
                      if (pickedTime != null && pickedTime != selectedTime1) {
                        setState(() {
                          selectedTime1 = pickedTime;
                        });
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white24,
                        border: Border.all(
                          color: Colors.grey,
                          width: 2,
                        ),
                      ),
                      child: Text(
                        selectedTime1.format(context),
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'What time does your stress usually end?',
                    style: TextStyle(fontSize: 16),
                  ),
                  GestureDetector(
                    onTap: () async {
                      TimeOfDay? pickedTime = await showTimePicker(
                        context: context,
                        initialTime: selectedTime2,
                      );
                      if (pickedTime != null && pickedTime != selectedTime2) {
                        setState(() {
                          selectedTime2 = pickedTime;
                        });
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white24,
                        border: Border.all(
                          color: Colors.grey,
                          width: 2,
                        ),
                      ),
                      child: Text(
                        selectedTime2.format(context),
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: _onSave,
                      child: const Text('Save'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}