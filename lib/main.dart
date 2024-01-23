// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ptsd_free/firebase_options.dart';
import 'package:ptsd_free/models/settings.dart';
import 'package:ptsd_free/notifications/ptsdNotificationFunctions.dart';
import 'package:ptsd_free/ui/home_screen.dart';
import 'package:ptsd_free/ui/splash_screen.dart';
import 'package:ptsd_free/ui/start_information.dart';
import 'package:ptsd_free/ui/timer_screen.dart';
import 'package:ptsd_free/utils/functions.dart';
import 'dart:developer' as developer;
import 'dart:developer';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

const String portName = 'notification_send_port';

String? payloadAfterRelaunch;
dynamic payloadJson;

/// A notification action which triggers a url launch event
const String urlLaunchActionId = 'id_1';

/// A notification action which triggers a App navigation event
const String navigationActionId = 'id_3';

/// Defines a iOS/MacOS notification category for text input actions.
const String darwinNotificationCategoryText = 'textCategory';

/// Defines a iOS/MacOS notification category for plain actions.
const String darwinNotificationCategoryPlain = 'plainCategory';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  // ignore: avoid_print
  print('notification(${notificationResponse.id}) action tapped: '
      '${notificationResponse.actionId} with'
      ' payload: ${notificationResponse.payload}');
  if (notificationResponse.input?.isNotEmpty ?? false) {
    // ignore: avoid_print
    print(
        'notification action tapped with input: ${notificationResponse.input}');
  }
}

Future<void> _configureLocalTimeZone() async {
  if (kIsWeb || Platform.isLinux) {
    return;
  }
  tz.initializeTimeZones();
  final String? timeZoneName = await FlutterTimezone.getLocalTimezone();
  tz.setLocalLocation(tz.getLocation(timeZoneName!));
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializationPTSDNotifications();
  await _configureLocalTimeZone();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final NotificationAppLaunchDetails? notificationAppLaunchDetails = !kIsWeb &&
          Platform.isLinux
      ? null
      : await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  String initialRoute = SplashScreen.route;
  if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
    payloadAfterRelaunch =
        notificationAppLaunchDetails!.notificationResponse?.payload;

    if (payloadAfterRelaunch != null) {
      payloadJson = jsonDecode(payloadAfterRelaunch ?? "{}");
      // set conflict value
      if (payloadJson['type'] == "meditate") {
        initialRoute = TimerScreen.route;
      } else if (payloadJson['type'] == "breathe") {
        initialRoute = StartInfo1.route;
      } else {
        initialRoute = SplashScreen.route;
      }
    } else {
      initialRoute = HomeScreen.route;
    }
  }

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    navigatorKey: navigatorKey,
    theme: ThemeData(scaffoldBackgroundColor: HexColor("#EFF8FF")),
    initialRoute: initialRoute,
    routes: <String, WidgetBuilder>{
      SplashScreen.route: (_) => const SplashScreen(),
      HomeScreen.route: (_) => HomeScreen(currentIndex: 0),
      TimerScreen.route: (_) => TimerScreen(
            mins: (payloadJson != null)
                ? int.tryParse(payloadJson['duration']) ?? 10
                : 10,
            sound: (payloadJson != null)
                ? payloadJson['sound'] ?? "Silence"
                : "Silence",
          ),
      StartInfo1.route: (_) => const StartInfo1(),
    },
  ));
}
