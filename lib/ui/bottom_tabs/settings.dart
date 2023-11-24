import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ptsd_free/models/settings.dart';
import 'package:ptsd_free/widgets/custom_colored_text.dart';
import 'package:ptsd_free/widgets/list_tile_settings.dart';
import 'dart:developer' as developer;

import 'package:url_launcher/url_launcher.dart';

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
          CustomColoredText(
              text: "  App", hexColor: "#95999C", size: 16, weight: 400),
          const SizedBox(height: 8),
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
              SettingVariables().getPush().then((value) {
                context.go("/pushnotifications", extra: value);
              });

              developer.log("Push Notifications clicked!");
            },
          ),
          ListTileSettings(
            text: "Stopper Breathe Button",
            onPressed: () {
              developer.log("Stopper Breathe Button clicked!");
              context.go("/home", extra: 0);
            },
          ),
          ListTileSettings(
            text: "Stopper Mini Meds",
            onPressed: () {
              developer.log("Stopper Mini Meds clicked!");
              context.go("/home", extra: 0);
            },
          ),
          ListTileSettings(
            text: "My Meds",
            onPressed: () {
              developer.log("My Meds clicked!");
              context.go("/home", extra: 2);
            },
          ),
          const SizedBox(height: 20),
          CustomColoredText(
              text: "  Support", hexColor: "#95999C", size: 16, weight: 400),
          const SizedBox(height: 8),
          ListTileSettings(
            text: "Website - Link",
            onPressed: () async {
              developer.log("Website - Link clicked!");
              final Uri url = Uri.parse('https://flutter.dev');
              if (!await launchUrl(url)) {
                throw Exception('Could not launch $url');
              }
            },
          ),
          ListTileSettings(
            text: "Report a Problem - Email",
            onPressed: () async {
              developer.log("Report a Problem - Email clicked!");
              final Uri url = Uri.parse(
                  'mailto:developer@hashkraft.com?subject=News&body=New%20plugin');
              if (!await launchUrl(url)) {
                throw Exception('Could not launch $url');
              }
            },
          ),
          const SizedBox(height: 20),
          CustomColoredText(
              text: "  Privacy", hexColor: "#95999C", size: 16, weight: 400),
          const SizedBox(height: 8),
          ListTileSettings(
            text: "Privacy Policy",
            onPressed: () {
              developer.log("Privacy Policy clicked!");
              context.go("/privacypolicy");
            },
          ),
        ],
      ),
    );
  }
}
