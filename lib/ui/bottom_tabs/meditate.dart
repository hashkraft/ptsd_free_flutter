import 'package:flutter/material.dart';
import 'package:ptsd_free/ui/bottom_tabs/breathe.dart';

class Meditate extends StatefulWidget {
  const Meditate({super.key});

  @override
  State<Meditate> createState() => _MeditateState();
}

class _MeditateState extends State<Meditate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text("Meditate"),
          ElevatedButton(onPressed: () {}, child: Text("Go to page 1"))
        ],
      ),
    );
  }
}
