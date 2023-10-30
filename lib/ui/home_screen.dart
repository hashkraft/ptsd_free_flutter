// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer' as developer;

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hexcolor/hexcolor.dart';

import 'package:ptsd_free/repo/database_helpers.dart';
import 'package:ptsd_free/widgets/custom_colored_text.dart';
import 'package:ptsd_free/widgets/custom_dropdown.dart';
import 'package:ptsd_free/widgets/list_tile_more.dart';
import 'package:ptsd_free/widgets/list_tile_settings.dart';

class HomeScreen extends StatefulWidget {
  int currentIndex = 0;
  HomeScreen({
    super.key,
    required this.currentIndex,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String appbarTitle = "Stress is gone";
  bool routine = false;
  final db = DatabaseHelper();
  bool random = false;
  bool question = true;
  bool myMedsInfo = true;
  int currentStep = 0;
  Widget body = Container();
  Widget stepBody = Container();
  String triggerType = "Places";
  final List<String> _businessTypes = [
    'Places',
    'Sounds',
    'Smells',
    'People',
    'Family',
    'Siblings'
  ];
  List<String> dateTimeList = [];
  bool _switchValue = false;

  Future<void> removeNotifications(String uuid) async {
    final alarmIDs = await db.alarmIdsByUUID(uuid);
    for (int id in alarmIDs) {
      developer.log("Deleting notification of id: $id");
      await AwesomeNotifications().cancel(id);
    }
  }

  @override
  Widget build(BuildContext context) {
    void _onItemTapped(int index) {
      setState(() {
        widget.currentIndex = index;
      });
    }

    switch (widget.currentIndex) {
      case 0:
        if (routine) {
          appbarTitle = "Stop routine PTSD";
          switch (currentStep) {
            case 0:
              stepBody = const Text('static text 1');
              break;
            case 1:
              stepBody = Column(
                children: [
                  const Text(
                      "What is the one thing that triggers your stress most often?"),
                  CustomDropDown(
                    items: _businessTypes,
                    value: triggerType,
                    onChanged: (value) {
                      setState(() {
                        triggerType = value!;
                      });
                    },
                  ),
                ],
              );
              break;
            case 2:
              stepBody = Column(
                children: [
                  Text(
                      'What time of day and days of the week does this stress triggered by $triggerType occurs most often?'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          context.go("/addreminder");
                        },
                        child: const Row(
                          children: [
                            Icon(Icons.add_rounded),
                            SizedBox(width: 5),
                            Text('Add Date Time'),
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text("Edit"),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  FutureBuilder(
                      future: db.getReminders(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                final reminder = snapshot.data![index];
                                developer.log(reminder.toString());
                                return Dismissible(
                                  key: Key(reminder['id'].toString()),
                                  direction: DismissDirection.startToEnd,
                                  onDismissed: (DismissDirection dd) {
                                    // deleteAlarmById(reminder['id']);
                                    db.deleteReminder(reminder['id']).then(
                                        (value) =>
                                            developer.log(value.toString()));
                                    removeNotifications(reminder['uuid']);
                                  },
                                  child: ListTile(
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(reminder['trigger']),
                                        Text(reminder['stress_start_time'])
                                      ],
                                    ),
                                    subtitle: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Days: ${reminder['days']}"),
                                        Text(reminder['stress_end_time'])
                                      ],
                                    ),
                                  ),
                                );
                              });
                        } else {
                          return Container();
                        }
                      })
                ],
              );
              break;
            case 3:
              stepBody = const Text('static text 2');
              break;
            default:
              stepBody = const Text('ABCDEG');
          }
          body = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  children: [stepBody],
                ),
              ),
              Text(
                "Progress: ${(((currentStep + 1) / 4) * 100).floor()}%",
                style: const TextStyle(color: Colors.blue, fontSize: 16),
              ),
              LinearProgressIndicator(
                color: Colors.blue,
                value: (currentStep + 1) / 4,
              ),
              const SizedBox(height: 10),
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: ElevatedButton(
                    style: ButtonStyle(backgroundColor:
                        MaterialStateProperty.resolveWith<Color?>(
                      (Set<MaterialState> states) {
                        return Colors.red;
                      },
                    )),
                    onPressed: () {
                      setState(() {
                        if (currentStep < 3) {
                          currentStep++;
                        } else {
                          currentStep = 0;
                          question = true;
                          routine = random = false;
                        }
                      });
                    },
                    child: const Text(
                      "Continue",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              )
            ],
          );
        }

        if (random) {
          appbarTitle = "Breathe Button";
          body = Center(
            child: Column(
              children: [
                const SizedBox(height: 150),
                const Text("random text"),
                Switch(
                  value: _switchValue,
                  onChanged: (bool value) {
                    setState(() {
                      _switchValue = value;
                    });
                  },
                ),
              ],
            ),
          );
        }
        if (question) {
          appbarTitle = "PTSD Stopper";
          body = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              CustomColoredText(
                  text: "PTSD Stopper helps people:",
                  hexColor: "#C81C01",
                  size: 18,
                  weight: 400),
              const SizedBox(height: 25),
              Row(
                children: [
                  const SizedBox(width: 25),
                  Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(width: 15),
                  CustomColoredText(
                      text: "Predict Stress",
                      hexColor: "#000000",
                      size: 16,
                      weight: 400),
                ],
              ),
              Row(
                children: [
                  const SizedBox(width: 25),
                  Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(width: 15),
                  CustomColoredText(
                      text: "Stop a reaction",
                      hexColor: "#000000",
                      size: 16,
                      weight: 400),
                ],
              ),
              Row(
                children: [
                  const SizedBox(width: 25),
                  Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(width: 15),
                  CustomColoredText(
                      text: "Become Stress smart",
                      hexColor: "#000000",
                      size: 16,
                      weight: 400),
                ],
              ),
              const SizedBox(height: 25),
              CustomColoredText(
                  text:
                      "Touch the Routine PTSD button to stop your most frequent stress reactions ",
                  hexColor: "#000000",
                  size: 16,
                  weight: 400),
              CustomColoredText(
                  text:
                      "Touch the Random PTSD button to stop unpredictable stress reactions ",
                  hexColor: "#000000",
                  size: 16,
                  weight: 400),
              const SizedBox(height: 70),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(backgroundColor:
                        MaterialStateProperty.resolveWith<Color?>(
                      (Set<MaterialState> states) {
                        return Colors.red;
                      },
                    )),
                    onPressed: () {
                      setState(() {
                        routine = true;
                        random = false;
                        question = false;
                      });
                    },
                    child: const Text(
                      "Routine PTSD",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(backgroundColor:
                        MaterialStateProperty.resolveWith<Color?>(
                      (Set<MaterialState> states) {
                        return Colors.red;
                      },
                    )),
                    onPressed: () {
                      setState(() {
                        random = true;
                        routine = false;
                        question = false;
                      });
                    },
                    child: const Text(
                      "Random PTSD",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          );
        }

        break;
      case 1:
        appbarTitle = "Resolve";
        body = const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("CONTENT FOR RESOLVE"),
          ],
        );
        break;
      case 2:
        if (myMedsInfo) {
          appbarTitle = "My Meds";
          body = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("CONTENT FOR MY MEDS"),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(),
                      ElevatedButton(
                        style: ButtonStyle(backgroundColor:
                            MaterialStateProperty.resolveWith<Color?>(
                          (Set<MaterialState> states) {
                            return Colors.red;
                          },
                        )),
                        onPressed: () {
                          setState(() {
                            myMedsInfo = false;
                          });
                        },
                        child: const Text(
                          "Continue",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(),
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ],
          );
        } else {
          appbarTitle = "Meditation times";
          body = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const Text('Add the date and time to wish to meditate.'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          context.go("/addmeditation");
                        },
                        child: const Row(
                          children: [
                            Icon(Icons.add_rounded),
                            SizedBox(width: 5),
                            Text('Add Date Time'),
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text("Edit"),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  FutureBuilder(
                      future: db.getReminders(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                final reminder = snapshot.data![index];
                                developer.log(reminder.toString());
                                return Dismissible(
                                  key: Key(reminder['id'].toString()),
                                  direction: DismissDirection.startToEnd,
                                  onDismissed: (DismissDirection dd) {
                                    // deleteAlarmById(reminder['id']);
                                    db.deleteReminder(reminder['id']).then(
                                        (value) =>
                                            developer.log(value.toString()));
                                    removeNotifications(reminder['uuid']);
                                  },
                                  child: ListTile(
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(reminder['trigger']),
                                        Text(reminder['stress_start_time'])
                                      ],
                                    ),
                                    subtitle: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Days: ${reminder['days']}"),
                                        Text(reminder['stress_end_time'])
                                      ],
                                    ),
                                  ),
                                );
                              });
                        } else {
                          return Container();
                        }
                      })
                ],
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(),
                      ElevatedButton(
                        style: ButtonStyle(backgroundColor:
                            MaterialStateProperty.resolveWith<Color?>(
                          (Set<MaterialState> states) {
                            return Colors.red;
                          },
                        )),
                        onPressed: () {
                          setState(() {
                            myMedsInfo = true;
                          });
                        },
                        child: const Text(
                          "Setup Another Meditation",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                      ElevatedButton(
                        style: ButtonStyle(backgroundColor:
                            MaterialStateProperty.resolveWith<Color?>(
                          (Set<MaterialState> states) {
                            return Colors.red;
                          },
                        )),
                        onPressed: () {
                          setState(() {
                            myMedsInfo = true;
                          });
                        },
                        child: const Text(
                          "Done",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(),
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ],
          );
        }

        break;
      case 3:
        appbarTitle = "Settings";
        body = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text("CONTENT FOR SETTINGS"),
            ListTileSettings(
                text: "Push Notifications",
                onPressed: () {
                  developer.log("Push Notifications clicked!");
                }),
          ],
        );
        break;
      case 4:
        appbarTitle = "More";
        body = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text("CONTENT FOR MORE"),
            ListTileMore(
                text: "Membership",
                icon: Icons.wallet_membership_outlined,
                onPressed: () {
                  developer.log("Membership clicked!");
                })
          ],
        );
        break;
      default:
    }
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Image.asset(
            'assets/images/stopper_screen_head_bg.png',
          ),
          Positioned(
            top: 80,
            right: MediaQuery.of(context).size.width / 2.5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(),
                Image.asset(
                  'assets/images/stress_top_icon_min.png',
                  scale: 1.2,
                  alignment: Alignment.center,
                ),
                const SizedBox(),
              ],
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              elevation: 0,
              automaticallyImplyLeading: (question) ? false : true,
              backgroundColor: Colors.transparent,
              leading: (random)
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          question = true;
                          random = false;
                          routine = false;
                        });
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                    )
                  : (routine)
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              if (currentStep > 0) {
                                currentStep--;
                              } else {
                                question = true;
                                random = false;
                                routine = false;
                              }
                            });
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                          ),
                        )
                      : const SizedBox(),
              title: Text(
                appbarTitle,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w500),
              ),
            ),
            body: Padding(
                padding: const EdgeInsets.only(top: 100, left: 15, right: 15),
                child: body),
            bottomNavigationBar: Theme(
              data: Theme.of(context).copyWith(canvasColor: Colors.white),
              child: BottomNavigationBar(
                  selectedItemColor: Colors.blue,
                  unselectedItemColor: HexColor("#A3A7B7"),
                  onTap: _onItemTapped,
                  showUnselectedLabels: true,
                  currentIndex: widget.currentIndex,
                  elevation: 10.0,
                  items: const [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.stop_circle), label: "Stopper"),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.hearing_outlined), label: "Resolve"),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.mediation_outlined), label: "My Meds"),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.settings), label: "Settings"),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.more), label: "More"),
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}
