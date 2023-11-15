import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ptsd_free/ui/add_meditation.dart';
import 'package:ptsd_free/ui/after_meditation.dart';
import 'package:ptsd_free/ui/auth/login.dart';
import 'package:ptsd_free/ui/auth/registration.dart';
import 'package:ptsd_free/ui/home_screen.dart';
import 'package:ptsd_free/main.dart';
import 'package:ptsd_free/ui/add_reminder.dart';
import 'package:ptsd_free/ui/timer_screen.dart';
import 'package:ptsd_free/ui/zipcode.dart';

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
          path: 'startinfo',
          builder: (BuildContext context, GoRouterState state) {
            return const StartInformation();
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
            return const TimerScreen();
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
          path: 'aftermeditation',
          builder: (BuildContext context, GoRouterState state) {
            return const AfterMeditation();
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
