import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as developer;
import 'package:uuid/uuid.dart';
import 'package:ptsd_free/utils/functions.dart' as functions;
import 'package:ptsd_free/utils/values.dart' as values;

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

  Future<void> scheduleAlarm({
    required final TimeOfDay timeofday,
    required final List<int> days,
    required final String channelKey,
  }) async {
    for (int day in days) {
      functions.scheduleNotification(
        id: days.indexOf(day),
        title: "Remember to breathe",
        body: "This is a gentle reminder",
        timeOfDay: timeofday,
        channelKey: channelKey,
        weekday: day,
      );
    }
  }

  void _onSave() {
    developer.log('Selected Days: $selectedDays');
    developer.log('Reminder when: $selectedReminderWhen');
    developer.log('Time 1: $selectedTime1');
    developer.log('Time 2: $selectedTime2');
    List<int> days = functions.convertDaysToIndices(selectedDays);
    final String uuid = const Uuid().v4();
    functions.saveToDatabase(
      selectedDays: selectedDays,
      selectedReminderWhen: selectedReminderWhen,
      selectedTime1: selectedTime1,
      selectedTime2: selectedTime2,
      uuid: uuid,
    );
    scheduleAlarm(
      timeofday: selectedTime1,
      days: days,
      channelKey: uuid,
    );
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
