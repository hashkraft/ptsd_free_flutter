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

import 'package:restart_app/restart_app.dart';

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
      key: navigatorKey,
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    // AwesomeNotifications().setListeners(
    //     onActionReceivedMethod: (receivedNotification) async {
    //   if (receivedNotification.buttonKeyInput == 'view_screen') {
    //     // Handle the action to navigate to a specific screen
    //     router.go("/timer", extra: [10, "Silence"]);
    //   }
    // });
    SettingVariables().getRandomPTSD().then((val) {
      developer.log(SettingVariables().randomPTSD.toString());
      if (val) {
        Timer(const Duration(seconds: 1), () async {
          context.go("/startinfo1");
        });
      } else {
        Timer(const Duration(seconds: 1), () async {
          context.go("/startinfo2");
        });
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        developer.log("RESUMED");
        break;
      case AppLifecycleState.inactive:
        developer.log("INACTIVE");
        break;
      case AppLifecycleState.paused:
        developer.log("PAUSED");
        break;
      case AppLifecycleState.detached:
        developer.log("DETACHED");
        break;
      case AppLifecycleState.hidden:
        developer.log("HIDDEN");
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        SettingVariables().getRandomPTSD().then((val) {
          developer.log(SettingVariables().randomPTSD.toString());
          if (val) {
            context.go("/startinfo1");
          } else {
            context.go("/startinfo2");
          }
        });
      },
      child: const Image(
        image: AssetImage('assets/images/splash_bg.jpg'),
      ),
    );
    ;
  }
}
