import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ptsd_free/ui/more/coaching.dart';
import 'package:ptsd_free/ui/more/membership.dart';
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
            // context.go("/membership");
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Membership()));
          },
        ),
        ListTileMore(
          text: "Coaching",
          icon: "assets/images/coaching_icon.png",
          onPressed: () {
            // context.go("/coaching");
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Coaching()));
            developer.log("Coaching clicked!");
          },
        ),
        ListTileMore(
          text: "Feedback",
          icon: "assets/images/feedback_icon.png",
          onPressed: () async {
            developer.log("Feedback clicked!");
            final Uri url = Uri.parse(
                'https://www.stressisgone.com/ptsd-keys-feedback');
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
            final Uri url = Uri.parse('https://www.stressisgone.com/');
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
            final Uri url = Uri.parse(
                'https://firebasestorage.googleapis.com/v0/b/hk-ptsd-free.appspot.com/o/3-Keys-to-Managing-PTSD-The-Warriors-Guide.pdf?alt=media');
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
            final Uri url = Uri.parse('https://www.stressisgone.com/about');
            if (!await launchUrl(url)) {
              throw Exception('Could not launch $url');
            }
          },
        ),
      ],
    );
  }
}
