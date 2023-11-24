// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer' as developer;

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hexcolor/hexcolor.dart';

import 'package:ptsd_free/models/settings.dart';
import 'package:ptsd_free/models/user.dart';
import 'package:ptsd_free/notifications/notifications_service.dart';
import 'package:ptsd_free/utils/functions.dart';
import 'package:ptsd_free/widgets/custom_colored_text.dart';

class PushNotifications extends StatefulWidget {
  final bool push;

  const PushNotifications({
    super.key,
    required this.push,
  });

  @override
  State<PushNotifications> createState() => _PushNotificationsState();
}

class _PushNotificationsState extends State<PushNotifications> {
  bool push = false;
  @override
  void initState() {
    push = widget.push;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor("#23C4F1"),
        leading: IconButton(
            onPressed: () {
              context.go("/home", extra: 3);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_sharp,
              color: Colors.white,
            )),
        title: CustomColoredText(
            text: "Push Notifications",
            hexColor: "#FFFFFF",
            size: 22,
            weight: 500),
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomColoredText(
                  text: "Enable Push Notifications",
                  hexColor: "#2C3351",
                  size: 16,
                  weight: 500,
                ),
                Switch(
                  activeColor: Colors.blue,
                  value: push,
                  onChanged: (bool value) {
                    setState(() {
                      push = value;

                      SettingVariables().setPush(value);
                    });
                    developer.log(push.toString());
                    if (value == true) {
                      AwesomeNotifications()
                          .listScheduledNotifications()
                          .then((value) {
                        developer.log(value.toString());
                        developer.log(value.length.toString());
                      });
                    } else {}
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
