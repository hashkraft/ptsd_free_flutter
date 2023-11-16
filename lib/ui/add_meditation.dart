import 'package:flutter/material.dart';
import 'package:ptsd_free/notifications/notifications_service.dart';
import 'dart:developer' as developer;
import 'package:ptsd_free/utils/functions.dart' as functions;
import 'package:go_router/go_router.dart';
import 'package:ptsd_free/repo/database_helpers.dart';
import 'package:uuid/uuid.dart';

class AddMeditation extends StatefulWidget {
  const AddMeditation({super.key});

  @override
  State<AddMeditation> createState() => _AddMeditationState();
}

class _AddMeditationState extends State<AddMeditation> {
  List<String> days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];
  List<String> sounds = [
    "Silence",
    "I'm Okay",
  ];
  String selectedDay = 'Monday';
  List<String> selectedDays = [];
  TimeOfDay selectedTime1 = TimeOfDay(hour: 00, minute: 00);
  // String duration = "";
  double durationDouble = 1;
  double reminderBeforeDouble = 0;
  double volume = 30;
  // List<String> durations = ["05", "10", "15", "20", "30"];
  // List<String> reminderBefores = ["0", "5", "15", "30", "1"];
  // String reminderBefore = "0";
  String sound = "Silence";
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
              leading: IconButton(
                  onPressed: () {
                    context.go("/home");
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  )),
              title: const Text(
                'Add Meditation',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
              ),
            ),
            body: SingleChildScrollView(
              child: Container(
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
                    const SizedBox(height: 10),
                    const Text(
                      'Time',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 10),
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
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),

                    Text(
                      'Duration:  ${(durationDouble * 5).toInt()} mins',
                      style: TextStyle(fontSize: 16),
                    ),
                    Slider(
                        divisions: 5,
                        min: 1,
                        max: 6,
                        value: durationDouble,
                        onChanged: (val) {
                          setState(() {
                            durationDouble = val;
                          });
                        }),
                    // Wrap(
                    //   children: durations.map((dur) {
                    //     return RadioItem(
                    //         value: dur,
                    //         groupValue: duration,
                    //         label: "$dur mins");
                    //   }).toList(),
                    // ),
                    const SizedBox(height: 10),

                    Text(
                      (reminderBeforeDouble == 0)
                          ? 'Reminder before meditation: None'
                          : 'Reminder before meditation: ${(reminderBeforeDouble * 5).toInt()} mins',
                      style: const TextStyle(fontSize: 16),
                    ),
                    Slider(
                        divisions: 6,
                        min: 0,
                        max: 6,
                        value: reminderBeforeDouble,
                        onChanged: (val) {
                          setState(() {
                            reminderBeforeDouble = val;
                          });
                        }),
                    // Wrap(
                    //   children: reminderBefores.map((dur) {
                    //     if (dur == "0") {
                    //       return RadioItem(
                    //           value: dur, groupValue: duration, label: "None");
                    //     } else if (dur == "1") {
                    //       return RadioItem(
                    //           value: dur,
                    //           groupValue: duration,
                    //           label: "$dur hour");
                    //     } else {
                    //       return RadioItem(
                    //           value: dur,
                    //           groupValue: duration,
                    //           label: "$dur mins");
                    //     }
                    //   }).toList(),
                    // ),
                    const SizedBox(height: 10),
                    const Text(
                      'Sound:',
                      style: TextStyle(fontSize: 16),
                    ),
                    DropdownButton<String>(
                      value: sound,
                      onChanged: (String? newValue) {
                        setState(() {
                          sound = newValue!;
                        });
                      },
                      items:
                          sounds.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Volume:  ${volume.toInt()}%',
                      style: const TextStyle(fontSize: 16),
                    ),
                    Slider(
                        divisions: 100,
                        min: 0,
                        max: 100,
                        value: volume,
                        onChanged: (val) {
                          setState(() {
                            volume = val;
                          });
                        }),
                    const SizedBox(height: 20),
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
          ),
        ],
      ),
    );
  }

  void _onSave() {
    developer.log(selectedDays.toString());
    developer.log(selectedTime1.toString());
    developer.log((durationDouble.toInt() * 5).toString());
    developer.log((reminderBeforeDouble.toInt() * 5).toString());
    developer.log(sound);
    developer.log(volume.toInt().toString());
    context.go("/home", extra: 2);
    List<int> days = functions.convertDaysToIndices(selectedDays);
    DatabaseHelper()
        .insertMeditation(
      selectedDays: selectedDays,
      selectedTime1: selectedTime1,
      duration: (durationDouble.toInt() * 5),
      reminderBefore: (reminderBeforeDouble.toInt() * 5),
      sound: sound,
      volume: volume.toInt(),
      uuid: const Uuid().v4(),
    )
        .then((value) {
      NotificationsService().scheduleAlarm(
        timeofday: selectedTime1,
        days: days,
        idList: value,
        meditate: true,
        title: "Meditate now!",
        body: "Close your eyes",
        payload: {
          "navigate": "true",
        },
      );
      if (reminderBeforeDouble.toInt() > 0) {
        final minutes = reminderBeforeDouble.toInt() * 5;
        if ((selectedTime1.minute - minutes) > 0) {
          TimeOfDay timebefore = TimeOfDay(
              hour: selectedTime1.hour, minute: selectedTime1.minute - minutes);
          NotificationsService().scheduleAlarm(
            timeofday: timebefore,
            days: days,
            idList: value,
            meditate: true,
            title: "Reminder before meditation",
            body: "Start in $minutes mins later",
          );
        } else {
          TimeOfDay timebefore = TimeOfDay(
              hour: 23, minute: 60 + (selectedTime1.minute - minutes));
          final days1 = functions.daysOneDayBefore(days);
          NotificationsService().scheduleAlarm(
            timeofday: timebefore,
            days: days1,
            meditate: true,
            idList: value,
            title: "Reminder before meditation",
            body: "Start in $minutes mins later",
          );
        }
      }
    });
  }
}
