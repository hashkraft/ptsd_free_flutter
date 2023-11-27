import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ptsd_free/ui/add_meditation.dart';
import 'package:ptsd_free/ui/after_meditation.dart';
import 'package:ptsd_free/ui/auth/login.dart';
import 'package:ptsd_free/ui/auth/registration.dart';
import 'package:ptsd_free/ui/home_screen.dart';
import 'package:ptsd_free/main.dart';
import 'package:ptsd_free/ui/add_reminder.dart';
import 'package:ptsd_free/ui/more/coaching.dart';
import 'package:ptsd_free/ui/more/membership.dart';
import 'package:ptsd_free/ui/settings/hotline.dart';
import 'package:ptsd_free/ui/settings/privacy_policy.dart';
import 'package:ptsd_free/ui/settings/push_notifications.dart';
import 'package:ptsd_free/ui/start_information.dart';
import 'package:ptsd_free/ui/timer_screen.dart';
import 'package:ptsd_free/ui/settings/zipcode.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const SplashScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'home',
          builder: (BuildContext context, GoRouterState state) {
            var index = 0;
            switch (state.extra) {
              case 0:
                index = 0;
                break;
              case 1:
                index = 1;
                break;
              case 2:
                index = 2;
                break;
              case 3:
                index = 3;
                break;
              case 4:
                index = 4;
                break;
              default:
                index = 0;
            }
            return HomeScreen(
              currentIndex: index,
            );
          },
        ),
        GoRoute(
          path: 'startinfo1',
          builder: (BuildContext context, GoRouterState state) {
            return const StartInfo1();
          },
        ),
        GoRoute(
          path: 'startinfo2',
          builder: (BuildContext context, GoRouterState state) {
            return const StartInfo2();
          },
        ),
        GoRoute(
          path: 'pushnotifications',
          builder: (BuildContext context, GoRouterState state) {
            return PushNotifications(
              push: state.extra as bool,
            );
          },
        ),
        GoRoute(
          path: 'addreminder',
          builder: (BuildContext context, GoRouterState state) {
            return const AddReminder();
          },
        ),
        GoRoute(
          path: 'addmeditation',
          builder: (BuildContext context, GoRouterState state) {
            return const AddMeditation();
          },
        ),
        GoRoute(
          path: 'timer',
          builder: (BuildContext context, GoRouterState state) {
            var val = state.extra as List;
            if (val.length == 3) {
              return TimerScreen(
                mins: val[0],
                sound: val[1],
                imageText: val[2],
              );
            } else {
              return TimerScreen(
                mins: val[0],
                sound: val[1],
              );
            }
          },
        ),
        GoRoute(
          path: 'membership',
          builder: (BuildContext context, GoRouterState state) {
            return const Membership();
          },
        ),
        GoRoute(
          path: 'coaching',
          builder: (BuildContext context, GoRouterState state) {
            return Coaching();
          },
        ),
        GoRoute(
          path: 'privacypolicy',
          builder: (BuildContext context, GoRouterState state) {
            return const PrivacyPolicy();
          },
        ),
        GoRoute(
          path: 'login',
          builder: (BuildContext context, GoRouterState state) {
            return const Login();
          },
        ),
        GoRoute(
          path: 'registration',
          builder: (BuildContext context, GoRouterState state) {
            return const Registration();
          },
        ),
        GoRoute(
          path: 'hotline',
          builder: (BuildContext context, GoRouterState state) {
            return const Hotline();
          },
        ),
        GoRoute(
          path: 'aftermeditation',
          builder: (BuildContext context, GoRouterState state) {
            if (state.extra == null) {
              return AfterMeditation();
            } else {
              return AfterMeditation(
                imageText: state.extra as String,
              );
            }
          },
        ),
        GoRoute(
          path: 'zipcode',
          builder: (BuildContext context, GoRouterState state) {
            return const ZipCode();
          },
        ),
      ],
    ),
  ],
);
