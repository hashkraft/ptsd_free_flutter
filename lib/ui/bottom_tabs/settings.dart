import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ptsd_free/widgets/list_tile_settings.dart';
import 'dart:developer' as developer;

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsState();
}

class _SettingsState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          const Text("App"),
          ListTileSettings(
            text: "Registration",
            onPressed: () {
              context.go("/registration");
            },
          ),
          ListTileSettings(
            text: "Login",
            onPressed: () {
              context.go("/login");
            },
          ),
          ListTileSettings(
            text: "Zipcode",
            onPressed: () {
              context.go("/zipcode");
            },
          ),
          ListTileSettings(
            text: "Hotline number",
            onPressed: () {
              context.go("/hotline");
            },
          ),
          ListTileSettings(
            text: "Push Notifications",
            onPressed: () {
              developer.log("Push Notifications clicked!");
            },
          ),
          ListTileSettings(
            text: "Stopper Breathe Button",
            onPressed: () {
              developer.log("Stopper Breathe Button clicked!");
            },
          ),
          ListTileSettings(
            text: "Stopper Mini Meds",
            onPressed: () {
              developer.log("Stopper Mini Meds clicked!");
            },
          ),
          ListTileSettings(
            text: "My Meds",
            onPressed: () {
              developer.log("My Meds clicked!");
            },
          ),
          const SizedBox(height: 16),
          const Text("Support"),
          ListTileSettings(
            text: "Website - Link",
            onPressed: () {
              developer.log("Website - Link clicked!");
            },
          ),
          ListTileSettings(
            text: "Report a Problem - Email",
            onPressed: () {
              developer.log("Report a Problem - Email clicked!");
            },
          ),
          const SizedBox(height: 16),
          const Text("Privacy"),
          ListTileSettings(
            text: "Privacy Policy",
            onPressed: () {
              developer.log("Privacy Policy clicked!");
            },
          ),
        ],
      ),
    );
  }
}
