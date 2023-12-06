import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:ptsd_free/models/settings.dart';
import 'dart:developer';

import 'package:ptsd_free/ui/start_information.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static String route = "/";
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with WidgetsBindingObserver {
  bool notificationsEnabled = false;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  @override
  void initState() {
    super.initState();
    _isAndroidPermissionGranted();
    _requestPermissions();

    // Future.delayed(const Duration(seconds: 2), () async {
    //   Navigator.push(
    //       context, MaterialPageRoute(builder: (context) => const StartInfo2()));
    // });

    // SettingVariables().getRandomPTSD().then((val) {
    //   if (val) {
    //     Future.delayed(const Duration(seconds: 2), () async {
    //       Navigator.push(context,
    //           MaterialPageRoute(builder: (context) => const StartInfo1()));
    //     });
    //   } else {
    //     Future.delayed(const Duration(seconds: 2), () async {
    //       Navigator.push(context,
    //           MaterialPageRoute(builder: (context) => const StartInfo2()));
    //     });
    //   }
    // });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _isAndroidPermissionGranted() async {
    if (Platform.isAndroid) {
      final bool granted = await flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<
                  AndroidFlutterLocalNotificationsPlugin>()
              ?.areNotificationsEnabled() ??
          false;

      setState(() {
        notificationsEnabled = granted;
      });
    }
  }

  Future<void> _requestPermissions() async {
    if (Platform.isIOS || Platform.isMacOS) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              MacOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
    } else if (Platform.isAndroid) {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
          flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();

      final bool? grantedNotificationPermission =
          await androidImplementation?.requestPermission();

      setState(() {
        notificationsEnabled = grantedNotificationPermission ?? false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const StartInfo2()));
        // SettingVariables().getRandomPTSD().then((val) {
        //   log(SettingVariables().randomPTSD.toString());
        //   if (val) {
        //     // context.go("/startinfo1");
        //     Navigator.push(context,
        //         MaterialPageRoute(builder: (context) => const StartInfo1()));
        //   } else {
        //     // context.go("/startinfo2");
        //     Navigator.push(context,
        //         MaterialPageRoute(builder: (context) => const StartInfo2()));
        //   }
        // });
      },
      child: const Image(
        image: AssetImage('assets/images/splash_bg.jpg'),
      ),
    );
    ;
  }
}
