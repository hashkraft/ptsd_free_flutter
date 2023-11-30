import 'package:flutter/material.dart';

class Heal extends StatefulWidget {
  const Heal({super.key});

  @override
  State<Heal> createState() => _HealState();
}

class _HealState extends State<Heal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("Heal"),
    );
  }
}
