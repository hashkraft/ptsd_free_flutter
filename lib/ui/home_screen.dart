// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer' as developer;

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ptsd_free/models/settings.dart';
import 'package:ptsd_free/models/user.dart';

import 'package:ptsd_free/repo/database_helpers.dart';
import 'package:ptsd_free/ui/bottom_tabs/more.dart';
import 'package:ptsd_free/ui/bottom_tabs/resolve.dart';
import 'package:ptsd_free/ui/bottom_tabs/settings.dart';
import 'package:ptsd_free/utils/functions.dart';
import 'package:ptsd_free/widgets/custom_colored_text.dart';
import 'package:ptsd_free/widgets/custom_dropdown.dart';
import 'package:ptsd_free/widgets/custom_text.dart';

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
  bool randomPTSD = SettingVariables().randomPTSD;
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

  Future<void> changeRandomPTSD() async {}

  @override
  void initState() {
    SettingVariables().getRandomPTSD().then((value) {
      randomPTSD = value;
    });
    if (UserAdd.zipcode.isEmpty) {
      Future.delayed(const Duration(seconds: 1), () async {
        String deviceId = (await getId()) ?? "";
        developer.log(deviceId);
        FirebaseFirestore.instance
            .collection("users-data")
            .where("deviceId", isEqualTo: deviceId)
            .get()
            .then((value) {
          if (value.docs.isEmpty) {
            context.go("/registration");
            Fluttertoast.showToast(
              msg: "Please register first!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              fontSize: 16.0,
            );
          } else {
            for (var docSnapshot in value.docs) {
              developer.log(
                  'Data found : ${docSnapshot.id} => ${docSnapshot.data()}');
              UserAdd.setValues(
                user: docSnapshot.data()['username'],
                pass: docSnapshot.data()['password'],
                zip: docSnapshot.data()['zipcode'],
                deviceId: deviceId,
              );

              developer.log("Logged in!");
              Fluttertoast.showToast(
                msg: "Logged in!",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.black,
                textColor: Colors.white,
                fontSize: 16.0,
              );
            }
          }
        });
      });
    }
    super.initState();
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
        headerImage = 'assets/images/stopper_screen_head_bg.png';
        if (routine) {
          setState(() {
            question = false;
          });
          appbarTitle = "Stop routine PTSD";
          switch (currentStep) {
            case 0:
              stepBody = CustomColoredText(
                text:
                    '''Answer a few questions to identify when your stress is most likely triggered. \n
The app helps stop the stress by automatically sending you mini-meditations when your reactions are frequent.
The more thought you'll put into your answers the more stress you'll stop. \n
Set-up one PTSD trigger at a time.''',
                hexColor: "#2C3351",
                size: 16,
                weight: 400,
              );
              break;
            case 1:
              stepBody = Column(
                children: [
                  const CustomText(
                      text:
                          "What is the one thing that triggers your stress most often?",
                      weight: 400),
                  const SizedBox(height: 16),
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
                  CustomText(
                      text:
                          'What time of the day or days of the week does this stress triggered by $triggerType most often occurred?',
                      weight: 400),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          context.go("/addreminder");
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.add_rounded,
                              color: HexColor("#056AD6"),
                            ),
                            const SizedBox(width: 5),
                            CustomColoredText(
                                text: "Add Days & Time",
                                hexColor: "#056AD6",
                                size: 14,
                                weight: 500),
                            // BLUE
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: CustomColoredText(
                            text: "Edit",
                            hexColor: "#056AD6",
                            size: 14,
                            weight: 500), // BLUE
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
              stepBody = const CustomText(
                text:
                    'Great job! \n\nNow remember to breathe along with mini-meditations that automatically appear on your phone to stop routine PTSD reactions.',
                weight: 400,
              );
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
                "${(((currentStep + 1) / 4) * 100).floor()}% Completed",
                style: const TextStyle(color: Colors.blue, fontSize: 16),
              ),
              LinearProgressIndicator(
                color: Colors.blue,
                value: (currentStep + 1) / 4,
              ),
              const SizedBox(height: 10),
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: ElevatedButton(
                    style: ButtonStyle(backgroundColor:
                        MaterialStateProperty.resolveWith<Color?>(
                      (Set<MaterialState> states) {
                        return Colors.red;
                      },
                    )),
                    onPressed: () {
                      SettingVariables().getPush().then((value) {
                        if (currentStep == 2 &&
                            value == true &&
                            widget.currentIndex == 0) {
                          showSnackbarWithColor(
                              context,
                              "Your push notifications are disabled!",
                              Colors.red);
                        }
                      });

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
                    child: CustomColoredText(
                        text: "Continue",
                        hexColor: "#FFFFFF",
                        size: 16,
                        weight: 400),
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
                const SizedBox(height: 10),
                CustomColoredText(
                  text:
                      "One-touch instant stress relief on your Android Screen. Touch the PTSD Free icon every time you feel stressed. Follow along with the breathing exercise to manage your stress in a minute.",
                  hexColor: "#2C3351",
                  size: 16,
                  weight: 400,
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Switch(
                      activeColor: Colors.blue,
                      value: randomPTSD,
                      onChanged: (bool value) async {
                        setState(() {
                          developer.log("{{{{{}}}}}" + value.toString());
                          randomPTSD = value;
                          SettingVariables().setRandomPTSD(value).then((value) {
                            developer.log("{{{{{}}}}}2" +
                                SettingVariables().randomPTSD.toString());
                          });
                        });
                      },
                    ),
                    const SizedBox(width: 15),
                    const CustomText(
                      text: "Switch on to activate",
                      weight: 500,
                    )
                  ],
                ),
              ],
            ),
          );
        }
        if (question) {
          appbarTitle = "PTSD Stopper";
          body = Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  CustomColoredText(
                      text: "PTSD Stopper helps people:",
                      hexColor: "#C81C01",
                      size: 18,
                      weight: 400),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      const SizedBox(width: 15),
                      Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.red,
                        ),
                      ),
                      const SizedBox(width: 10),
                      CustomColoredText(
                          text: "Predict Stress",
                          hexColor: "#000000",
                          size: 16,
                          weight: 400),
                    ],
                  ),
                  Row(
                    children: [
                      const SizedBox(width: 15),
                      Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.red,
                        ),
                      ),
                      const SizedBox(width: 10),
                      CustomColoredText(
                          text: "Stop a reaction",
                          hexColor: "#000000",
                          size: 16,
                          weight: 400),
                    ],
                  ),
                  Row(
                    children: [
                      const SizedBox(width: 15),
                      Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.red,
                        ),
                      ),
                      const SizedBox(width: 10),
                      CustomColoredText(
                          text: "Become Stress smart",
                          hexColor: "#000000",
                          size: 16,
                          weight: 400),
                    ],
                  ),
                  const SizedBox(height: 15),
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
                ],
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: ElevatedButton(
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
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: ElevatedButton(
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
                            developer.log(">>>>" +
                                SettingVariables().randomPTSD.toString());
                          },
                          child: const Text(
                            "Random PTSD",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  CustomColoredText(
                      text: "My Meds helps people:",
                      hexColor: "#005CB8",
                      size: 18,
                      weight: 400),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      const SizedBox(width: 15),
                      Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(width: 10),
                      CustomColoredText(
                          text: "Create a meditation practice",
                          hexColor: "#000000",
                          size: 16,
                          weight: 400),
                    ],
                  ),
                  Row(
                    children: [
                      const SizedBox(width: 15),
                      Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(width: 10),
                      CustomColoredText(
                          text: "Stay consistent with meditations",
                          hexColor: "#000000",
                          size: 16,
                          weight: 400),
                    ],
                  ),
                  Row(
                    children: [
                      const SizedBox(width: 15),
                      Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(width: 10),
                      CustomColoredText(
                          text: "Reduce stress symptoms",
                          hexColor: "#000000",
                          size: 16,
                          weight: 400),
                    ],
                  ),
                  const SizedBox(height: 15),
                  CustomColoredText(
                      text:
                          "Veterans showed a 50% reduction in stress symptoms after 8-weeks of meditation. Military Medicine (Vol. 176, Num. 6)",
                      hexColor: "#000000",
                      size: 16,
                      weight: 400),
                ],
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
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
                            SettingVariables().getPush().then((value) {
                              if (value == true &&
                                  myMedsInfo == false &&
                                  widget.currentIndex == 2) {
                                showSnackbarWithColor(
                                    context,
                                    "Your push notifications are disabled!",
                                    Colors.red);
                              }
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
                  const CustomText(
                    text: "Add the date and time to wish to meditate.",
                    weight: 400,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          context.go("/addmeditation");
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.add_rounded,
                              color: HexColor("#056AD6"),
                            ),
                            const SizedBox(width: 5),
                            CustomColoredText(
                                text: "Add Days & Time",
                                hexColor: "#056AD6",
                                size: 14,
                                weight: 500), // blue
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: CustomColoredText(
                            text: "Edit",
                            hexColor: "#056AD6",
                            size: 14,
                            weight: 500), //blue
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
          (widget.currentIndex == 3 || widget.currentIndex == 4)
              ? Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).viewPadding.top,
                      color: HexColor("#23C4F1"),
                    ),
                    Image.asset(
                      "assets/images/header_bg.png",
                      // scale: 1.5,
                      // height: 150,
                      // width: MediaQuery.of(context).size.width,
                    ),
                  ],
                )
              : Image.asset(
                  headerImage,
                  fit: BoxFit.fitWidth,
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
              : (resolveStep > 0 &&
                      resolveStep < 11 &&
                      widget.currentIndex == 1)
                  ? Positioned(
                      top: 82,
                      left: MediaQuery.of(context).size.width / 10,
                      child: CustomColoredText(
                        text: "Step $resolveStep",
                        hexColor: "#FFFFFF",
                        size: 18,
                        weight: 500,
                      ),
                    )
                  : const SizedBox(),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: (random ||
                    routine ||
                    (widget.currentIndex == 1 && resolveStep > 0))
                ? AppBar(
                    elevation: 0,
                    automaticallyImplyLeading: (question) ? false : true,
                    backgroundColor: Colors.transparent,
                    leading: IconButton(
                      onPressed: () {
                        if (random) {
                          setState(() {
                            question = true;
                            random = false;
                            routine = false;
                          });
                        } else if (routine) {
                          setState(() {
                            if (currentStep > 0) {
                              currentStep--;
                            } else {
                              question = true;
                              random = false;
                              routine = false;
                            }
                          });
                        } else if ((widget.currentIndex == 1 &&
                            resolveStep > 0)) {
                          setState(() {
                            if (resolveStep > 0) {
                              resolveStep--;
                            }
                          });
                        }
                      },
                      icon: const Icon(Icons.arrow_back_ios,
                          color: Colors.white, size: 22),
                    ),
                    title: CustomColoredText(
                        text: appbarTitle,
                        hexColor: "#FFFFFF",
                        size: 22,
                        weight: 400),
                  )
                : (widget.currentIndex == 3 || widget.currentIndex == 4)
                    ? AppBar(
                        elevation: 0,
                        automaticallyImplyLeading: false,
                        // backgroundColor: HexColor("#23C4F1"),
                        backgroundColor: Colors.transparent,
                        title: CustomColoredText(
                            text: appbarTitle,
                            hexColor: "#FFFFFF",
                            size: 22,
                            weight: 400),
                      )
                    : AppBar(
                        elevation: 0,
                        automaticallyImplyLeading: (question) ? false : true,
                        backgroundColor: Colors.transparent,
                        title: CustomColoredText(
                            text: appbarTitle,
                            hexColor: "#FFFFFF",
                            size: 22,
                            weight: 400),
                      ),
            body: Padding(
                padding: (widget.currentIndex == 3 || widget.currentIndex == 4)
                    ? const EdgeInsets.only(top: 0, left: 0, right: 0)
                    : const EdgeInsets.only(top: 100, left: 15, right: 15),
                // color: HexColor("#EFF8FF"),
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
                  items: [
                    BottomNavigationBarItem(
                        icon: const ImageIcon(
                          AssetImage("assets/images/stopper_inactive.png"),
                          color: Colors.grey,
                        ),
                        activeIcon: ImageIcon(
                          const AssetImage(
                              "assets/images/stopper_inactive.png"),
                          color: HexColor("#0FA8ED"),
                        ),
                        label: "Stopper"),
                    BottomNavigationBarItem(
                        icon: const ImageIcon(
                          AssetImage("assets/images/resolve_inactive.png"),
                          color: Colors.grey,
                        ),
                        activeIcon: ImageIcon(
                          const AssetImage(
                              "assets/images/resolve_inactive.png"),
                          color: HexColor("#0FA8ED"),
                        ),
                        label: "Resolve"),
                    BottomNavigationBarItem(
                        icon: const ImageIcon(
                          AssetImage("assets/images/med_inactive.png"),
                          color: Colors.grey,
                        ),
                        activeIcon: ImageIcon(
                          const AssetImage("assets/images/med_inactive.png"),
                          color: HexColor("#0FA8ED"),
                        ),
                        label: "My Meds"),
                    BottomNavigationBarItem(
                        icon: const ImageIcon(
                          AssetImage("assets/images/settings_inactive.png"),
                          color: Colors.grey,
                        ),
                        activeIcon: ImageIcon(
                          const AssetImage(
                              "assets/images/settings_inactive.png"),
                          color: HexColor("#0FA8ED"),
                        ),
                        label: "Settings"),
                    BottomNavigationBarItem(
                        icon: const ImageIcon(
                          AssetImage("assets/images/three_dots_inactive.png"),
                          color: Colors.grey,
                        ),
                        activeIcon: ImageIcon(
                          const AssetImage(
                              "assets/images/three_dots_inactive.png"),
                          color: HexColor("#0FA8ED"),
                        ),
                        label: "More"),
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}
