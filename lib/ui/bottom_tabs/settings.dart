import 'package:flutter/material.dart';
import 'package:ptsd_free/widgets/list_tile_settings.dart';
import 'dart:developer' as developer;

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        const Text("CONTENT FOR SETTINGS"),
        ListTileSettings(
            text: "Push Notifications",
            onPressed: () {
              developer.log("Push Notifications clicked!");
            }),
      ],
    );
  }
}
