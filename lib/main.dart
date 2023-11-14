import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ptsd_free/firebase_options.dart';
import 'package:ptsd_free/router/router.dart';
import 'package:ptsd_free/notifications/notifications_service.dart';
import 'package:ptsd_free/widgets/custom_colored_text.dart';

Future<void> main() async {
  await initializeNotification();
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
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
    Timer(const Duration(seconds: 3), () {
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
  const StartInformation({super.key});

  @override
  State<StartInformation> createState() => _StartInformationState();
}

class _StartInformationState extends State<StartInformation> {
  bool showinfo2 = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          (showinfo2)
              ? " 3 Keys to Live PTSD Free"
              : "Stress Stopper Breathwork",
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        child: (showinfo2 == false)
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
                          setState(() {
                            showinfo2 = true;
                          });
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
            : GestureDetector(
                onTap: () {
                  // Navigator.of(context).pop();
                  context.go("/home");
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 32),
                      CustomColoredText(
                        text: "1. Stopper Tab",
                        hexColor: "#F73C00",
                        size: 18,
                        weight: 500,
                      ),
                      CustomColoredText(
                        text:
                            "Will help you learn how to stop your stress reactions. Use it every time you become stressed.",
                        hexColor: "#2C3351",
                        size: 18,
                        weight: 500,
                      ),
                      const SizedBox(height: 16),
                      CustomColoredText(
                        text: "2. Resolve Tab",
                        hexColor: "#00B73A",
                        size: 18,
                        weight: 500,
                      ),
                      CustomColoredText(
                        text:
                            "Will help you heal the traumatic memories fueling your stress reactions. Use it weekly.",
                        hexColor: "#2C3351",
                        size: 18,
                        weight: 500,
                      ),
                      const SizedBox(height: 16),
                      CustomColoredText(
                        text: "3. My Meds",
                        hexColor: "#0057B8",
                        size: 18,
                        weight: 500,
                      ),
                      CustomColoredText(
                        text:
                            "Will help you structure a meditation practice. Meditate atleast once a day for 20 minutes.",
                        hexColor: "#2C3351",
                        size: 18,
                        weight: 500,
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
