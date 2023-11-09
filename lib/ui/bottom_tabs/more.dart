import 'package:flutter/material.dart';
import 'package:ptsd_free/widgets/list_tile_more.dart';
import 'dart:developer' as developer;

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
          icon: Icons.wallet_membership_outlined,
          onPressed: () {
            developer.log("Membership clicked!");
          },
        ),
        ListTileMore(
          text: "Coaching",
          icon: Icons.people,
          onPressed: () {
            developer.log("Coaching clicked!");
          },
        ),
        ListTileMore(
          text: "Feedback",
          icon: Icons.message_sharp,
          onPressed: () {
            developer.log("Feedback clicked!");
          },
        ),
        ListTileMore(
          text: "Website",
          icon: Icons.web_stories_outlined,
          onPressed: () {
            developer.log("Website clicked!");
          },
        ),
        ListTileMore(
          text: "Free E-Book",
          icon: Icons.book_rounded,
          onPressed: () {
            developer.log("Free E-Book  clicked!");
          },
        ),
        ListTileMore(
          text: "About",
          icon: Icons.info,
          onPressed: () {
            developer.log("About clicked!");
          },
        ),
      ],
    );
  }
}
