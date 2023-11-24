import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ptsd_free/widgets/list_tile_more.dart';
import 'dart:developer' as developer;

import 'package:url_launcher/url_launcher.dart';

class More extends StatefulWidget {
  const More({super.key});

  @override
  State<More> createState() => _MoreState();
}

class _MoreState extends State<More> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 30),
        ListTileMore(
          text: "Membership",
          icon: "assets/images/membership_icon.png",
          onPressed: () {
            developer.log("Membership clicked!");
            context.go("/membership");
          },
        ),
        ListTileMore(
          text: "Coaching",
          icon: "assets/images/coaching_icon.png",
          onPressed: () {
            context.go("/coaching");
            developer.log("Coaching clicked!");
          },
        ),
        ListTileMore(
          text: "Feedback",
          icon: "assets/images/feedback_icon.png",
          onPressed: () async {
            developer.log("Feedback clicked!");
            final Uri url = Uri.parse('https://flutter.dev');
            if (!await launchUrl(url)) {
              throw Exception('Could not launch $url');
            }
          },
        ),
        ListTileMore(
          text: "Website",
          icon: "assets/images/website_icon.png",
          onPressed: () async {
            developer.log("Website clicked!");
            final Uri url = Uri.parse('https://flutter.dev');
            if (!await launchUrl(url)) {
              throw Exception('Could not launch $url');
            }
          },
        ),
        ListTileMore(
          text: "Free E-Book",
          icon: "assets/images/ebook_icon.png",
          onPressed: () async {
            developer.log("Free E-Book  clicked!");
            final Uri url = Uri.parse('https://flutter.dev');
            if (!await launchUrl(url)) {
              throw Exception('Could not launch $url');
            }
          },
        ),
        ListTileMore(
          text: "About",
          icon: "assets/images/about_icon.png",
          onPressed: () async {
            developer.log("About clicked!");
            final Uri url = Uri.parse('https://flutter.dev');
            if (!await launchUrl(url)) {
              throw Exception('Could not launch $url');
            }
          },
        ),
      ],
    );
  }
}
