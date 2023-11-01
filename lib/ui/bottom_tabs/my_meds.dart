import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:developer' as developer;

import 'package:ptsd_free/repo/database_helpers.dart';

class MyMeditation extends StatefulWidget {
  const MyMeditation({super.key});

  @override
  State<MyMeditation> createState() => _MyMeditationState();
}

class _MyMeditationState extends State<MyMeditation> {
  @override
  Widget build(BuildContext context) {
    final db = DatabaseHelper();

    return Container();
  }
}
