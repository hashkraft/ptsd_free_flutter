import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ptsd_free/ui/home_screen.dart';
import 'package:ptsd_free/main.dart';
import 'package:ptsd_free/widgets/add_reminder.dart';

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
            return const HomeScreen();
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
      ],
    ),
  ],
);
