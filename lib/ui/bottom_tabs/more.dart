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
        const SizedBox(height: 20),
        const Text("CONTENT FOR MORE"),
        ListTileMore(
            text: "Membership",
            icon: Icons.wallet_membership_outlined,
            onPressed: () {
              developer.log("Membership clicked!");
            })
      ],
    );
  }
}
