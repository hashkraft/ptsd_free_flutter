import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ptsd_free/notifications/notifications_service.dart';
import 'package:ptsd_free/notifications/ptsdNotificationFunctions.dart';
import 'package:ptsd_free/repo/database_helpers.dart';
import 'package:ptsd_free/ui/home_screen.dart';
import 'package:ptsd_free/widgets/custom_colored_text.dart';
import 'package:ptsd_free/widgets/custom_dropdown.dart';
import 'package:ptsd_free/widgets/custom_text.dart';
import 'package:ptsd_free/widgets/day_box.dart';
import 'dart:developer' as developer;
import 'package:uuid/uuid.dart';
import 'package:ptsd_free/utils/functions.dart' as functions;

class AddReminder extends StatefulWidget {
  final String trigger;
  const AddReminder({super.key, required this.trigger});

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
  bool day1 = false;
  bool day2 = false;
  bool day3 = false;
  bool day4 = false;
  bool day5 = false;
  bool day6 = false;
  bool day7 = false;
  String selectedDay = 'Monday';
  List<String> selectedDays = [];
  String selectedTime = 'Morning';
  List<String> reminderWhenOptions = [
    'During the stress',
    '3 minutes before',
    'Both'
  ];
  String selectedReminderWhen = 'During the stress';
  TimeOfDay selectedTime1 = TimeOfDay.now();
  TimeOfDay selectedTime2 = TimeOfDay.now();

  bool isTimeLater(TimeOfDay time1, TimeOfDay time2) {
    if (time1.hour > time2.hour) {
      return true;
    } else if (time1.hour == time2.hour && time1.minute > time2.minute) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> _onSave() async {
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
    if (selectedDays.isEmpty) {
      functions.showSnackbarWithColor(
          context, "Please select day(s)", Colors.red);
    } else if (isTimeLater(selectedTime1, selectedTime2)) {
      functions.showSnackbarWithColor(
          context, "End time should be later than start time", Colors.red);
    } else {
      final String uuid = const Uuid().v4();
      List<int> days = functions.convertDaysToIndices(selectedDays);
      developer.log('Days in indices: $days');
      DatabaseHelper()
          .insertStopper(
        trigger: widget.trigger,
        selectedDays: selectedDays,
        selectedReminderWhen: selectedReminderWhen,
        selectedTime1: selectedTime1,
        selectedTime2: selectedTime2,
        uuid: uuid,
      )
          .then((value) async {
        switch (selectedReminderWhen) {
          case "During the stress":
            for (int day in days) {
              await scheduleWeeklyPTSDNotification(
                title: "Breathe",
                body: 'Tap here to breathe and let go',
                notificationId: value[days.indexOf(day)],
                dayOfWeek: day,
                hourOfTheDay: selectedTime1.hour,
                minOfTheHour: selectedTime1.minute,
                payload: jsonEncode({
                  "type": "breathe",
                }),
              );
            }
            break;
          case "3 minutes before":
            if ((selectedTime1.minute - 3) > 0) {
              TimeOfDay timebefore = TimeOfDay(
                  hour: selectedTime1.hour, minute: selectedTime1.minute - 3);

              for (int day in days) {
                await scheduleWeeklyPTSDNotification(
                  title: "Reminder",
                  body: 'Meditation starts in 3 mins',
                  notificationId: value[days.indexOf(day)],
                  dayOfWeek: day,
                  hourOfTheDay: timebefore.hour,
                  minOfTheHour: timebefore.minute,
                  payload: jsonEncode({
                    "type": "reminder",
                  }),
                );
              }
            } else {
              if (selectedTime1.hour == 0) {
                TimeOfDay timebefore = TimeOfDay(
                    hour: 23, minute: 60 + (selectedTime1.minute - 3));

                final days1 = functions.daysOneDayBefore(days);

                for (int day in days1) {
                  await scheduleWeeklyPTSDNotification(
                    title: "Reminder",
                    body: 'Meditation starts in 3 mins',
                    notificationId: value[days1.indexOf(day)],
                    dayOfWeek: day,
                    hourOfTheDay: timebefore.hour,
                    minOfTheHour: timebefore.minute,
                    payload: jsonEncode({
                      "type": "reminder",
                    }),
                  );
                }
              } else {
                TimeOfDay timebefore = TimeOfDay(
                    hour: selectedTime1.hour - 1,
                    minute: 60 + (selectedTime1.minute - 3));

                for (int day in days) {
                  await scheduleWeeklyPTSDNotification(
                    title: "Reminder",
                    body: 'Meditation starts in 3 mins',
                    notificationId: value[days.indexOf(day)],
                    dayOfWeek: day,
                    hourOfTheDay: timebefore.hour,
                    minOfTheHour: timebefore.minute,
                    payload: jsonEncode({
                      "type": "reminder",
                    }),
                  );
                }
              }
            }
            break;
          case "Both":
            for (int day in days) {
              await scheduleWeeklyPTSDNotification(
                title: "Reminder",
                body: 'Meditation starts in 3 mins',
                notificationId: value[days.indexOf(day)],
                dayOfWeek: day,
                hourOfTheDay: selectedTime1.hour,
                minOfTheHour: selectedTime1.minute,
                payload: jsonEncode({
                  "type": "reminder",
                }),
              );
            }
            if ((selectedTime1.minute - 3) > 0) {
              TimeOfDay timebefore = TimeOfDay(
                  hour: selectedTime1.hour, minute: selectedTime1.minute - 3);
              for (int day in days) {
                await scheduleWeeklyPTSDNotification(
                  title: "Reminder",
                  body: 'Meditation starts in 3 mins',
                  notificationId: value[days.indexOf(day)],
                  dayOfWeek: day,
                  hourOfTheDay: timebefore.hour,
                  minOfTheHour: timebefore.minute,
                  payload: jsonEncode({
                    "type": "reminder",
                  }),
                );
              }
            } else {
              if (selectedTime1.hour == 0) {
                TimeOfDay timebefore = TimeOfDay(
                    hour: 23, minute: 60 + (selectedTime1.minute - 3));
                final days1 = functions.daysOneDayBefore(days);
                for (int day in days1) {
                  await scheduleWeeklyPTSDNotification(
                    title: "Reminder",
                    body: 'Meditation starts in 3 mins',
                    notificationId: value[days1.indexOf(day)],
                    dayOfWeek: day,
                    hourOfTheDay: timebefore.hour,
                    minOfTheHour: timebefore.minute,
                    payload: jsonEncode({
                      "type": "reminder",
                    }),
                  );
                }
              } else {
                TimeOfDay timebefore = TimeOfDay(
                    hour: selectedTime1.hour - 1,
                    minute: 60 + (selectedTime1.minute - 3));
                for (int day in days) {
                  await scheduleWeeklyPTSDNotification(
                    title: "Reminder",
                    body: 'Meditation starts in 3 mins',
                    notificationId: value[days.indexOf(day)],
                    dayOfWeek: day,
                    hourOfTheDay: timebefore.hour,
                    minOfTheHour: timebefore.minute,
                    payload: jsonEncode({
                      "type": "reminder",
                    }),
                  );
                }
              }
            }
            break;
          default:
            // await NotificationsService().scheduleAlarm(
            //   timeofday: selectedTime1,
            //   days: days,
            //   idList: value,
            //   title: "Touch here to breathe and let go.",
            //   // body: "Please relax yourself",
            //   meditate: false,
            //   payload: {
            //     "torandom": "true",
            //   },
            // );
            break;
        }
        // await NotificationsService().scheduleAlarm(
        //   timeofday: selectedTime1,
        //   days: days,
        //   idList: value,
        //   title: "Breathe now!",
        //   body: "Please relax yourself",
        //   meditate: false,
        // );
      });

      developer.log('Selected Days: $selectedDays');
      developer.log('Reminder when: $selectedReminderWhen');
      developer.log('Time 1: $selectedTime1');
      developer.log('Time 2: $selectedTime2');
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => HomeScreen(
                currentIndex: 0,
                extraInfo: 2,
              )));
      // context.go("/home");
    }
  }

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
        // context.go("/home", extra: 2);
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => HomeScreen(
                  currentIndex: 0,
                  extraInfo: 2,
                )));
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.red,
            elevation: 0,
            leadingWidth: 80,
            leading: TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => HomeScreen(
                          currentIndex: 0,
                          extraInfo: 2,
                        )));
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
                  text: 'Add Reminder',
                  hexColor: "#FFFFFF",
                  size: 20,
                  weight: 500),
            ),
          ),
          body: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // const SizedBox(height: 40),
                CustomColoredText(
                    text: "Select the days",
                    hexColor: "#066CD8",
                    size: 16,
                    weight: 400),
                const SizedBox(height: 8),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: daysWidget),
                // Wrap(
                //   children: days.map((day) {
                //     return Row(
                //       mainAxisSize: MainAxisSize.min,
                //       children: <Widget>[
                //         Checkbox(
                //           value: selectedDays.contains(day),
                //           onChanged: (value) {
                //             setState(() {
                //               if (value == true) {
                //                 selectedDays.add(day);
                //               } else {
                //                 selectedDays.remove(day);
                //               }
                //             });
                //           },
                //         ),
                //         CustomText(
                //           text: day,
                //           weight: 400,
                //         ),
                //       ],
                //     );
                //   }).toList(),
                // ),
                const SizedBox(height: 20),

                CustomColoredText(
                    text: 'I want a reminder to breathe',
                    hexColor: "#066CD8",
                    size: 16,
                    weight: 400),
                const SizedBox(height: 8),
                CustomDropDown(
                    items: reminderWhenOptions,
                    value: selectedReminderWhen,
                    onChanged: (val) {
                      setState(() {
                        selectedReminderWhen = val!;
                      });
                    }),

                const SizedBox(height: 20),

                CustomColoredText(
                    text: 'What time does your stress usually start?',
                    hexColor: "#066CD8",
                    size: 16,
                    weight: 400),
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
                      text: selectedTime1.format(context),
                      weight: 400,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                CustomColoredText(
                    text: 'What time does your stress usually end?',
                    hexColor: "#066CD8",
                    size: 16,
                    weight: 400),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: () async {
                    TimeOfDay? pickedTime = await showTimePicker(
                      context: context,
                      initialTime: selectedTime2,
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
                    if (pickedTime != null && pickedTime != selectedTime2) {
                      setState(() {
                        selectedTime2 = pickedTime;
                      });
                    }
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.white,
                        width: 1,
                      ),
                    ),
                    child: CustomText(
                      text: selectedTime2.format(context),
                      weight: 400,
                    ),
                  ),
                ),
                // Center(
                //   child: ElevatedButton(
                //     onPressed: _onSave,
                //     child: const CustomText(text: "Save", weight: 400),
                //   ),
                // ),
              ],
            ),
          )),
    );
  }
}
