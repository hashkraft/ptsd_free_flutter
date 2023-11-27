import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ptsd_free/notifications/notifications_service.dart';
import 'package:ptsd_free/repo/database_helpers.dart';
import 'package:ptsd_free/widgets/custom_colored_text.dart';
import 'package:ptsd_free/widgets/custom_dropdown.dart';
import 'package:ptsd_free/widgets/custom_text.dart';
import 'package:ptsd_free/widgets/day_box.dart';
import 'dart:developer' as developer;
import 'package:uuid/uuid.dart';
import 'package:ptsd_free/utils/functions.dart' as functions;

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
  TimeOfDay selectedTime1 = TimeOfDay(hour: 00, minute: 00);
  TimeOfDay selectedTime2 = TimeOfDay(hour: 00, minute: 00);

  Future<void> _onSave() async {
    if (selectedDays.isEmpty) {
      functions.showSnackbarWithColor(
          context, "Please select day(s)", Colors.red);
    } else {
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
      final String uuid = const Uuid().v4();
      List<int> days = functions.convertDaysToIndices(selectedDays);
      developer.log('Days in indices: $days');
      DatabaseHelper()
          .insertStopper(
        selectedDays: selectedDays,
        selectedReminderWhen: selectedReminderWhen,
        selectedTime1: selectedTime1,
        selectedTime2: selectedTime2,
        uuid: uuid,
      )
          .then((value) async {
        switch (selectedReminderWhen) {
          case "During the stress":
            await NotificationsService().scheduleAlarm(
              timeofday: selectedTime1,
              days: days,
              idList: value,
              title: "Breathe now!",
              body: "Please relax yourself",
              meditate: false,
            );

            break;
          case "3 minutes before":
            if ((selectedTime1.minute - 3) > 0) {
              TimeOfDay timebefore = TimeOfDay(
                  hour: selectedTime1.hour, minute: selectedTime1.minute - 3);

              await NotificationsService().scheduleAlarm(
                timeofday: timebefore,
                days: days,
                idList: value,
                title: "Breathe now!",
                body: "Please relax yourself",
                meditate: false,
              );
            } else {
              TimeOfDay timebefore =
                  TimeOfDay(hour: 23, minute: 60 + (selectedTime1.minute - 3));
              final days1 = functions.daysOneDayBefore(days);

              await NotificationsService().scheduleAlarm(
                timeofday: timebefore,
                days: days1,
                idList: value,
                title: "Breathe now!",
                body: "Please relax yourself",
                meditate: false,
              );
            }
            break;
          case "Both":
            await NotificationsService().scheduleAlarm(
              timeofday: selectedTime1,
              days: days,
              idList: value,
              title: "Breathe now!",
              body: "Please relax yourself",
              meditate: false,
            );
            if ((selectedTime1.minute - 3) > 0) {
              TimeOfDay timebefore = TimeOfDay(
                  hour: selectedTime1.hour, minute: selectedTime1.minute - 3);

              await NotificationsService().scheduleAlarm(
                timeofday: timebefore,
                days: days,
                idList: value,
                title: "Breathe now!",
                body: "Please relax yourself",
                meditate: false,
              );
            } else {
              TimeOfDay timebefore =
                  TimeOfDay(hour: 23, minute: 60 + (selectedTime1.minute - 3));
              final days1 = functions.daysOneDayBefore(days);

              await NotificationsService().scheduleAlarm(
                timeofday: timebefore,
                days: days1,
                idList: value,
                title: "Breathe now!",
                body: "Please relax yourself",
                meditate: false,
              );
            }
            break;
          default:
            await NotificationsService().scheduleAlarm(
              timeofday: selectedTime1,
              days: days,
              idList: value,
              title: "Breathe now!",
              body: "Please relax yourself",
              meditate: false,
            );
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
      context.go("/home");
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> daysWidget = days.map((day) {
      return DayBox(
        text: day.substring(0, 3),
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
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          elevation: 0,
          leadingWidth: 80,
          leading: TextButton(
            onPressed: () {
              context.go("/home");
            },
            child: CustomColoredText(
                text: "Cancel", hexColor: "#FFFFFF", size: 16, weight: 400),
          ),
          actions: [
            TextButton(
              onPressed: _onSave,
              child: CustomColoredText(
                  text: "Save", hexColor: "#FFFFFF", size: 16, weight: 400),
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
        ));
  }
}
