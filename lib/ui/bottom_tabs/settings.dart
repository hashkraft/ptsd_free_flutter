import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ptsd_free/models/settings.dart';
import 'package:ptsd_free/ui/home_screen.dart';
import 'package:ptsd_free/ui/settings/hotline.dart';
import 'package:ptsd_free/ui/settings/privacy_policy.dart';
import 'package:ptsd_free/ui/settings/zipcode.dart';
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
          // ListTileSettings(
          //   text: "Registration",
          //   onPressed: () {
          //     context.go("/registration");
          //   },
          // ),
          // ListTileSettings(
          //   text: "Login",
          //   onPressed: () {
          //     context.go("/login");
          //   },
          // ),
          ListTileSettings(
            text: "Zipcode",
            onPressed: () {
              // context.go("/zipcode");
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const ZipCode()));
            },
          ),
          ListTileSettings(
            text: "Hotline Number",
            onPressed: () {
              // context.go("/hotline");
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Hotline()));
            },
          ),
          // ListTileSettings(
          //   text: "Push Notifications",
          //   onPressed: () {
          //     SettingVariables().getPush().then((value) {
          //       context.go("/pushnotifications", extra: value);
          //     });

          //     developer.log("Push Notifications clicked!");
          //   },
          // ),
          ListTileSettings(
            text: "Stopper Breathe Button",
            onPressed: () {
              developer.log("Stopper Breathe Button clicked!");
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => HomeScreen(
                        currentIndex: 0,
                        extraInfo: -1,
                      )));
            },
          ),
          ListTileSettings(
            text: "Stopper Mini Meds",
            onPressed: () {
              developer.log("Stopper Mini Meds clicked!");
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => HomeScreen(
                        currentIndex: 0,
                        extraInfo: 2,
                      )));
            },
          ),
          ListTileSettings(
            text: "Meditate",
            onPressed: () {
              developer.log("My Meds clicked!");
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => HomeScreen(
                        currentIndex: 2,
                        extraInfo: 1,
                      )));
            },
          ),
          const SizedBox(height: 20),
          CustomColoredText(
              text: "  Support", hexColor: "#95999C", size: 16, weight: 400),
          const SizedBox(height: 8),
          ListTileSettings(
            text: "Website",
            onPressed: () async {
              developer.log("Website - Link clicked!");
              final Uri url = Uri.parse('https://www.stressisgone.com/');
              if (!await launchUrl(url)) {
                throw Exception('Could not launch $url');
              }
            },
          ),
          ListTileSettings(
            text: "Report a Problem",
            onPressed: () async {
              developer.log("Report a Problem - Email clicked!");
              final Uri url = Uri.parse(
                  'mailto:info@stressisgone.com?subject=News&body=New%20plugin');
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
              // context.go("/privacypolicy");
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PrivacyPolicy()));
            },
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
