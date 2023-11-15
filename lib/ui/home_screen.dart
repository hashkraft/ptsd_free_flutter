// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer' as developer;

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ptsd_free/models/user.dart';

import 'package:ptsd_free/repo/database_helpers.dart';
import 'package:ptsd_free/ui/bottom_tabs/more.dart';
import 'package:ptsd_free/ui/bottom_tabs/resolve.dart';
import 'package:ptsd_free/ui/bottom_tabs/settings.dart';
import 'package:ptsd_free/utils/functions.dart';
import 'package:ptsd_free/widgets/custom_colored_text.dart';
import 'package:ptsd_free/widgets/custom_dropdown.dart';

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
  int resolveStep = 0;
  int currentStep = 0;
  Widget body = Container();
  Widget stepBody = Container();
  String triggerType = "Places";
  String headerImage = 'assets/images/stopper_screen_head_bg.png';

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
  bool myMedsInfo = true;
  String topImage = "";
  double topImageScale = 1.2;
  Future<void> removeMeditation(String uuid) async {
    final alarmIDs = await db.alarmIdsByUUID2(uuid);
    for (int id in alarmIDs) {
      developer.log("Deleting notification of id: $id");
      await AwesomeNotifications().cancel(id);
    }
  }

  Future<void> removeStoppers(String uuid) async {
    final alarmIDs = await db.alarmIdsByUUID(uuid);
    for (int id in alarmIDs) {
      developer.log("Deleting notification of id: $id");
      await AwesomeNotifications().cancel(id);
    }
  }

  // @override
  // void initState() async {
  //   // TODO: implement initState

  //   String deviceId = (await getId()) ?? "";
  //   developer.log(deviceId);
  //   FirebaseFirestore.instance
  //       .collection("users-data")
  //       .where("deviceId", isEqualTo: deviceId)
  //       .get()
  //       .then((value) {
  //     developer.log("Successfully completed");
  //     for (var docSnapshot in value.docs) {
  //       if (docSnapshot.data().isNotEmpty) {
  //         developer
  //             .log('Data found : ${docSnapshot.id} => ${docSnapshot.data()}');
  //         UserAdd.setValues(
  //           user: docSnapshot.data()['username'],
  //           pass: docSnapshot.data()['password'],
  //           zip: docSnapshot.data()['zipcode'],
  //           deviceId: deviceId,
  //         );
  //         developer.log("Logged in!");
  //       }

  //       // docSnapshot.data(). update("zipcode", (value) => zipNew);
  //       // developer.log('NEW: ${docSnapshot.id} => ${docSnapshot.data()}');
  //     }
  //   });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    void _onItemTapped(int index) {
      setState(() {
        widget.currentIndex = index;
      });
    }

    switch (widget.currentIndex) {
      case 0:
        headerImage = 'assets/images/stopper_screen_head_bg.png';
        if (routine) {
          setState(() {
            question = false;
          });
          appbarTitle = "Stop routine PTSD";
          switch (currentStep) {
            case 0:
              stepBody = const Text(
                  '''Answer a few questions to identify when your stress is most likely triggered. \n
The app helps stop the stress by automatically sending you mini-meditations when your reactions are frequent.
The more thought you'll put into your answers the more stress you'll stop. \n
Set-up one PTSD trigger at a time.''');
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
                      'What time of the day or days of the week does this stress triggered by $triggerType most often occurred?'),
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
                                    db.deleteStopper(reminder['id']).then(
                                        (value) =>
                                            developer.log(value.toString()));
                                    removeStoppers(reminder['uuid']);
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
              stepBody = const Text(
                  'Great job! \n\nNow remember to breathe along with mini-meditations that automatically appear on your phone to stop routine PTSD reactions.');
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
              ),
              const SizedBox(height: 10),
            ],
          );
        }

        if (random) {
          question = false;
          appbarTitle = "Breathe Button";
          body = Center(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                CustomColoredText(
                  text:
                      "One-touch instant stress relief on your Android Screen. Touch the PTSD Free icon every time you feel stressed. Follow along with the breathing exercise to manage your stress in a minute.",
                  hexColor: "#2C3351",
                  size: 16,
                  weight: 400,
                ),
                const SizedBox(height: 10),
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
        headerImage = 'assets/images/resolve_header_bg.png';
        if (resolveStep <= 10 && resolveStep > 1) {
          appbarTitle = "Step ${resolveStep - 1}";
        } else {
          appbarTitle = "Resolve";
        }
        body = Resolve(
          step: resolveStep,
          onValueChanged: (newValue) {
            developer.log(newValue.toString());
            setState(() {
              resolveStep = newValue;
            });
          },
        );
        break;
      case 2:
        headerImage = 'assets/images/my_meds_header_bg.png';
        if (myMedsInfo) {
          appbarTitle = "My Meds";
          body = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomColoredText(
                text: '''My Meds helps people:\n
- Create a meditation practice
- Stay consistent with meditations
- Reduce stress symptoms\n
Veterans showed a 50% reduction in stress symptoms after 8-weeks of meditation. Military Medicine (Vol. 176, Num. 6) ''',
                hexColor: "#2C3351",
                size: 16,
                weight: 400,
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(),
                      SizedBox(
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
                              myMedsInfo = false;
                            });
                          },
                          child: const Text(
                            "Continue",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
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
                      future: db.getMeditations(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                final meditation = snapshot.data![index];
                                developer.log(meditation.toString());
                                return Dismissible(
                                  key: Key(meditation['id'].toString()),
                                  direction: DismissDirection.startToEnd,
                                  onDismissed: (DismissDirection dd) {
                                    db.deleteMeditation(meditation['id']).then(
                                        (value) =>
                                            developer.log(value.toString()));
                                    removeMeditation(meditation['uuid']);
                                  },
                                  child: ListTile(
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(meditation['days']),
                                        Text(meditation['time'].toString())
                                      ],
                                    ),
                                    subtitle: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                            "Duration: ${meditation['duration'].toString()} mins"),
                                        (meditation['reminderbefore'] == 0)
                                            ? const Text("Don't remind")
                                            : Text(
                                                "Remind before: ${meditation['reminderbefore'].toString()} mins")
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
                          context.go("/addmeditation");
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
        // question = false;
        // headerImage = "";
        appbarTitle = "Settings";
        body = const SettingsScreen();

        break;
      case 4:
        // question = false;
        // headerImage = "";
        appbarTitle = "More";
        body = const More();
        break;
      default:
    }

    if (question && widget.currentIndex == 0) {
      topImage = 'assets/images/stress_top_icon_min.png';
      topImageScale = 1.2;
    } else if (widget.currentIndex == 2 && myMedsInfo == true) {
      topImage = 'assets/images/meds_top_icon_min.png';
      topImageScale = 1.5;
    } else if (widget.currentIndex == 1 && resolveStep == 0) {
      topImage = 'assets/images/resolve_top_icon_min.png';
      topImageScale = 1.2;
    } else {
      topImage = '';
      topImageScale = 1.2;
    }

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Image.asset(
            headerImage,
          ),
          (topImage.isNotEmpty)
              ? Positioned(
                  top: 82,
                  right: MediaQuery.of(context).size.width / 2.5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(),
                      Image.asset(
                        topImage,
                        scale: topImageScale,
                        alignment: Alignment.center,
                      ),
                      const SizedBox(),
                    ],
                  ),
                )
              : const SizedBox(),
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
                      : (widget.currentIndex == 1)
                          ? IconButton(
                              onPressed: () {
                                setState(() {
                                  if (resolveStep > 0) {
                                    resolveStep--;
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
                        icon: Icon(Icons.stop), label: "Stopper"),
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
