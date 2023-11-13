import 'package:flutter/material.dart';

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
