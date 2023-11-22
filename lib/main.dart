// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:hexcolor/hexcolor.dart';

import 'package:ptsd_free/firebase_options.dart';
import 'package:ptsd_free/models/settings.dart';
import 'package:ptsd_free/models/user.dart';
import 'package:ptsd_free/notifications/notifications_service.dart';
import 'package:ptsd_free/router/router.dart';
import 'package:ptsd_free/utils/functions.dart';
import 'package:ptsd_free/widgets/custom_colored_text.dart';
import 'dart:developer' as developer;

Future<void> main() async {
  await NotificationsService().initializeNotification();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   navigatorKey: navigatorKey,
    // );
    return MaterialApp.router(
      theme: ThemeData(scaffoldBackgroundColor: HexColor("#EFF8FF")),
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    SettingVariables().getRandomPTSD().then((val) {
      developer.log(SettingVariables().randomPTSD.toString());
    });
    Timer(const Duration(seconds: 3), () async {
      context.go("/startinfo");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.go("/home", extra: [0, 1, 2, 3]);
      },
      child: const Image(
        image: AssetImage('assets/images/splash_bg.jpg'),
      ),
    );
  }
}

class StartInformation extends StatefulWidget {
  const StartInformation({
    super.key,
  });

  @override
  State<StartInformation> createState() => _StartInformationState();
}

class _StartInformationState extends State<StartInformation> {
  // @override
  // void initState() {
  //   SettingVariables().getPush().then((val) {
  //     SettingVariables().push = val;
  //     developer.log("Push: ${SettingVariables().push.toString()}");
  //   });
  //   SettingVariables().getRandomPTSD().then((val) {
  //     SettingVariables().randomPTSD = val;
  //     developer.log("Random PTSD: ${SettingVariables().randomPTSD.toString()}");
  //   });

  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: CustomColoredText(
          text: (SettingVariables().randomPTSD)
              ? "Stress Stopper Breathwork"
              : " 3 Keys to Live PTSD Free",
          hexColor: "#FFFFFF",
          size: 22,
          weight: 400,
        ),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        child: (SettingVariables().randomPTSD)
            ? Column(
                children: [
                  const SizedBox(height: 16),
                  CustomColoredText(
                    text: "Take Action During Your Reaction",
                    hexColor: "#F73C00",
                    size: 18,
                    weight: 500,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Image.asset(
                            "assets/images/img_comfortable_eyes.png",
                            width: 250,
                          ),
                          const SizedBox(height: 24),
                          Image.asset(
                            "assets/images/img_breathe_deep_2.png",
                            width: 250,
                          ),
                          const SizedBox(height: 24),
                          Image.asset(
                            "assets/images/img_silent_okay_2.png",
                            width: 250,
                          ),
                        ],
                      ),
                      Image.asset(
                        "assets/images/breathwork_touch_heart.png",
                        width: 100,
                        height: 200,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  CustomColoredText(
                    text: "REPEAT UNTIL YOUR STRESS IS GONE",
                    hexColor: "#0057B8",
                    size: 18,
                    weight: 500,
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: CustomColoredText(
                      text:
                          "Stress Stopper Breathwork quickly activates your body's relaxation response",
                      hexColor: "#2C3351",
                      size: 16,
                      weight: 500,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.resolveWith<Color?>(
                            (Set<MaterialState> states) {
                              return Colors.blue;
                            },
                          ),
                        ),
                        onPressed: () {
                          context.go("/home");
                        },
                        child: CustomColoredText(
                          text: "I'm Okay",
                          hexColor: "#FFFFFF",
                          size: 16,
                          weight: 500,
                        ),
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.resolveWith<Color?>(
                            (Set<MaterialState> states) {
                              return Colors.red;
                            },
                          ),
                        ),
                        onPressed: () {},
                        child: CustomColoredText(
                          text: "Help me",
                          hexColor: "#FFFFFF",
                          size: 16,
                          weight: 500,
                        ),
                      ),
                    ],
                  ),
                  Image.asset(
                    "assets/images/img_certified_american_institute.png",
                    width: 280,
                    height: 100,
                  ),
                ],
              )
            : Container(
                padding: const EdgeInsets.all(16),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 32),
                        Row(
                          children: [
                            ImageIcon(
                              const AssetImage(
                                  "assets/images/stopper_inactive.png"),
                              color: HexColor("#D12438"),
                              size: 26,
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            CustomColoredText(
                              text: "1. Stopper Tab",
                              hexColor: "#D12438",
                              size: 16,
                              weight: 500,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        CustomColoredText(
                          text:
                              "Will help you learn how to stop your stress reactions. Use it every time you become stressed.",
                          hexColor: "#2C3351",
                          size: 16,
                          weight: 500,
                        ),
                        const SizedBox(height: 36),
                        Row(
                          children: [
                            ImageIcon(
                              const AssetImage(
                                  "assets/images/resolve_inactive.png"),
                              color: HexColor("#0B9F4F"),
                              size: 26,
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            CustomColoredText(
                              text: "2. Resolve Tab",
                              hexColor: "#0B9F4F",
                              size: 16,
                              weight: 500,
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        CustomColoredText(
                          text:
                              "Will help you heal the traumatic memories fueling your stress reactions. Use it weekly.",
                          hexColor: "#2C3351",
                          size: 16,
                          weight: 500,
                        ),
                        const SizedBox(height: 36),
                        Row(
                          children: [
                            ImageIcon(
                              const AssetImage(
                                  "assets/images/med_inactive.png"),
                              color: HexColor("#036EB0"),
                              size: 26,
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            CustomColoredText(
                              text: "3. My Meds",
                              hexColor: "#036EB0",
                              size: 16,
                              weight: 500,
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        CustomColoredText(
                          text:
                              "Will help you structure a meditation practice. Meditate atleast once a day for 20 minutes.",
                          hexColor: "#2C3351",
                          size: 16,
                          weight: 500,
                        ),
                        const SizedBox(height: 36),
                      ],
                    ),
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
                            context.go("/home");
                          },
                          child: const Text(
                            "Go to Home Screen",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        )),
                  ],
                ),
              ),
      ),
    );
  }
}
