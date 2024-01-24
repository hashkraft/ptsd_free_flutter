import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ptsd_free/main.dart';
import 'package:ptsd_free/notifications/notifications_service.dart';
import 'package:ptsd_free/notifications/ptsdNotificationFunctions.dart';
import 'package:ptsd_free/ui/home_screen.dart';
import 'dart:developer' as developer;
import 'package:ptsd_free/utils/functions.dart' as functions;
import 'package:go_router/go_router.dart';
import 'package:ptsd_free/repo/database_helpers.dart';
import 'package:ptsd_free/widgets/custom_colored_text.dart';
import 'package:ptsd_free/widgets/custom_dropdown.dart';
import 'package:ptsd_free/widgets/custom_text.dart';
import 'package:ptsd_free/widgets/day_box.dart';
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
  bool day1 = false;
  bool day2 = false;
  bool day3 = false;
  bool day4 = false;
  bool day5 = false;
  bool day6 = false;
  bool day7 = false;
  List<String> selectedDays = [];
  TimeOfDay selectedTime1 = TimeOfDay.now();
  double durationDouble = 1;
  double reminderBeforeDouble = 0;
  double volume = 30;
  String sound = "Silence";
  @override
  Widget build(BuildContext context) {
    List<Widget> daysWidget = days.map((day) {
      return DayBox(
        text: day.substring(0, 2),
        whenTapped: (val) {
          if (days.indexOf(day) == 0) {
            setState(() {
              day1 = val;
            });
          } else if (days.indexOf(day) == 1) {
            setState(() {
              day2 = val;
            });
          } else if (days.indexOf(day) == 2) {
            setState(() {
              day3 = val;
            });
          } else if (days.indexOf(day) == 3) {
            setState(() {
              day4 = val;
            });
          } else if (days.indexOf(day) == 4) {
            setState(() {
              day5 = val;
            });
          } else if (days.indexOf(day) == 5) {
            setState(() {
              day6 = val;
            });
          } else if (days.indexOf(day) == 6) {
            setState(() {
              day7 = val;
            });
          }
        },
      );
    }).toList();
    return PopScope(
      canPop: false,
      onPopInvoked: (canPop) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => HomeScreen(
              currentIndex: 2,
              extraInfo: 1,
            ),
          ),
        );
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[400],
          elevation: 0,
          leadingWidth: 80,
          leading: TextButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => HomeScreen(
                    currentIndex: 2,
                    extraInfo: 1,
                  ),
                ),
              );
            },
            child: CustomColoredText(
                text: "Cancel", hexColor: "#FFFFFF", size: 14, weight: 400),
          ),
          actions: [
            TextButton(
              onPressed: _onSave,
              child: CustomColoredText(
                  text: "Save", hexColor: "#FFFFFF", size: 14, weight: 400),
            )
          ],
          title: Center(
            child: CustomColoredText(
                text: 'Add Meditation',
                hexColor: "#FFFFFF",
                size: 20,
                weight: 500),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomColoredText(
                    text: "Days", hexColor: "#066CD8", size: 16, weight: 400),
                const SizedBox(height: 8),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: daysWidget),
                const SizedBox(height: 16),
                CustomColoredText(
                    text: "Time", hexColor: "#066CD8", size: 16, weight: 400),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: () async {
                    TimeOfDay? pickedTime = await showTimePicker(
                      context: context,
                      initialTime: selectedTime1,
                      builder: (context, child) {
                        return Theme(
                          data: ThemeData.light().copyWith(
                            colorScheme: const ColorScheme.light(
                              primary: Colors.blue,
                              tertiary: Colors.blue,
                              // onSurface: Colors.blue,
                            ),
                            buttonTheme: const ButtonThemeData(
                              colorScheme: ColorScheme.light(
                                primary: Colors.blue,
                              ),
                            ),
                          ),
                          child: child!,
                        );
                      },
                    );
                    if (pickedTime != null && pickedTime != selectedTime1) {
                      setState(() {
                        selectedTime1 = pickedTime;
                      });
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.white,
                        width: 1,
                      ),
                    ),
                    child: CustomText(
                        text: selectedTime1.format(context), weight: 400),
                  ),
                ),
                const SizedBox(height: 16),
                CustomColoredText(
                    text: 'Duration:  ${(durationDouble * 5).toInt()} mins',
                    hexColor: "#066CD8",
                    size: 16,
                    weight: 400),
                Slider(
                    divisions: 5,
                    min: 1,
                    max: 6,
                    activeColor: Colors.blue,
                    value: durationDouble,
                    onChanged: (val) {
                      setState(() {
                        durationDouble = val;
                      });
                    }),
                const SizedBox(height: 10),
                CustomColoredText(
                    text: (reminderBeforeDouble == 0)
                        ? 'Reminder before meditation: None'
                        : 'Reminder before meditation: ${(reminderBeforeDouble * 5).toInt()} mins',
                    hexColor: "#066CD8",
                    size: 16,
                    weight: 400),
                Slider(
                    divisions: 6,
                    min: 0,
                    max: 6,
                    activeColor: Colors.blue,
                    value: reminderBeforeDouble,
                    onChanged: (val) {
                      setState(() {
                        reminderBeforeDouble = val;
                      });
                    }),
                const SizedBox(height: 16),
                CustomColoredText(
                    text: "Sound", hexColor: "#066CD8", size: 16, weight: 400),
                const SizedBox(height: 8),
                CustomDropDown(
                    items: sounds,
                    value: sound,
                    onChanged: (val) {
                      setState(() {
                        sound = val!;
                      });
                    }),
                const SizedBox(height: 16),
                CustomColoredText(
                    text: 'Volume:  ${volume.toInt()}%',
                    hexColor: "#066CD8",
                    size: 16,
                    weight: 400),
                const SizedBox(height: 8),
                Slider(
                    divisions: 100,
                    min: 0,
                    max: 100,
                    activeColor: Colors.blue,
                    value: volume,
                    onChanged: (val) {
                      setState(() {
                        volume = val;
                      });
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onSave() {
    if (day1) {
      selectedDays.add("Monday");
    }
    if (day2) {
      selectedDays.add("Tuesday");
    }
    if (day3) {
      selectedDays.add("Wednesday");
    }
    if (day4) {
      selectedDays.add("Thursday");
    }
    if (day5) {
      selectedDays.add("Friday");
    }
    if (day6) {
      selectedDays.add("Saturday");
    }
    if (day7) {
      selectedDays.add("Sunday");
    }
    developer.log(selectedDays.toString());
    if (selectedDays.isEmpty) {
      functions.showSnackbarWithColor(
          context, "Please select day(s)", Colors.red);
    } else {
      developer.log(selectedDays.toString());
      developer.log(selectedTime1.toString());
      developer.log((durationDouble.toInt() * 5).toString());
      developer.log((reminderBeforeDouble.toInt() * 5).toString());
      developer.log(sound);
      developer.log(volume.toInt().toString());
      List<int> days = functions.convertDaysToIndices(selectedDays);
      developer.log('Days in indices: $days');
      DatabaseHelper()
          .insertMeditation(
        selectedDays: selectedDays,
        selectedTime1: selectedTime1,
        duration: (durationDouble.toInt() * 5),
        reminderBefore: (reminderBeforeDouble.toInt() * 5),
        sound: sound,
        volume: volume.toString(),
        uuid: const Uuid().v4(),
      )
          .then((value) async {
        for (int day in days) {
          await scheduleWeeklyPTSDNotification(
            title: "Meditate",
            body: "Tap here to start meditation",
            notificationId: value[days.indexOf(day)],
            dayOfWeek: day,
            hourOfTheDay: selectedTime1.hour,
            minOfTheHour: selectedTime1.minute,
            payload: jsonEncode({
              "type": "meditate",
              "sound": sound,
              "duration": "${durationDouble.toInt() * 5}"
            }),
          );
          developer.log(
              "Notification set on day $day, at ${selectedTime1.hour}:${selectedTime1.minute}");
        }

        if (reminderBeforeDouble.toInt() > 0) {
          final minutes = reminderBeforeDouble.toInt() * 5;
          if ((selectedTime1.minute - minutes) > 0) {
            for (int day in days) {
              await scheduleWeeklyPTSDNotification(
                title: "Reminder",
                body: 'Meditation starts in $minutes mins',
                notificationId: value[days.length + days.indexOf(day)],
                dayOfWeek: day,
                hourOfTheDay: selectedTime1.hour,
                minOfTheHour: selectedTime1.minute - minutes,
                payload: jsonEncode({
                  "type": "reminder",
                }),
              );
              developer.log(
                  "Notification set on day $day, at ${selectedTime1.hour}:${selectedTime1.minute - minutes}");
            }
          } else {
            if (selectedTime1.hour == 0) {
              final days1 = functions.daysOneDayBefore(days);
              for (int day in days1) {
                await scheduleWeeklyPTSDNotification(
                  title: "Reminder",
                  body: 'Meditation starts in $minutes mins',
                  notificationId: value[days.length + days1.indexOf(day)],
                  dayOfWeek: day,
                  hourOfTheDay: 23,
                  minOfTheHour: 60 + (selectedTime1.minute - minutes),
                  payload: jsonEncode({
                    "type": "reminder",
                  }),
                );
                developer.log(
                    "Notification set on day $day, at 23:${60 + (selectedTime1.minute - minutes)}");
              }
            } else {
              for (int day in days) {
                await scheduleWeeklyPTSDNotification(
                  title: "Reminder",
                  body: 'Meditation starts in $minutes mins',
                  notificationId: value[days.length + days.indexOf(day)],
                  dayOfWeek: day,
                  hourOfTheDay: selectedTime1.hour - 1,
                  minOfTheHour: 60 + (selectedTime1.minute - minutes),
                  payload: jsonEncode({
                    "type": "reminder",
                  }),
                );
                developer.log(
                    "Notification set on day $day, at ${selectedTime1.hour - 1}:${60 + (selectedTime1.minute - minutes)}");
              }
            }
          }
        }
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => HomeScreen(
              currentIndex: 2,
              extraInfo: 1,
            ),
          ),
        );
      });
    }
  }
}
