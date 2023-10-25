import 'dart:async';
import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:ptsd_free/router/router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await Alarm.init(showDebugLogs: true);
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
        image: AssetImage('assets/images/splash_screen.jpg'),
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
      body: Container(
        child: (showinfo2 == false)
            ? Column(
                children: [
                  const SizedBox(height: 150),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              showinfo2 = true;
                            });
                          },
                          child: const Text("I'm Okay"),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text("Help me"),
                        ),
                      ],
                    ),
                  )
                ],
              )
            : GestureDetector(
                onTap: () {
                  // Navigator.of(context).pop();
                  context.go("/home");
                },
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Text 1"),
                      Text("Text 2"),
                      Text("Text 3"),
                      Text("Text 4"),
                      Text("Text 5"),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
