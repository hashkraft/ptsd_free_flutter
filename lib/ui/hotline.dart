import 'dart:convert';
import 'package:hexcolor/hexcolor.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:ptsd_free/models/user.dart';
import 'package:ptsd_free/widgets/custom_colored_text.dart';
import 'dart:developer' as developer;

class Hotline extends StatefulWidget {
  const Hotline({super.key});

  @override
  State<Hotline> createState() => _HotlineState();
}

class _HotlineState extends State<Hotline> {
  String number = "";
  bool hotlinePresent = false;
  Map<String, dynamic> _data = {};

  void launchDialer() async {
    final url = 'tel:$number';
    if (await canLaunchUrl(Uri(scheme: 'tel', path: number))) {
      await launchUrl(Uri(scheme: 'tel', path: number));
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> loadData() async {
    String data =
        await DefaultAssetBundle.of(context).loadString('assets/zipcodes.json');
    setState(() {
      _data = json.decode(data);
      developer.log(_data.toString());
      hotlinePresent = _data.containsKey(UserAdd.zipcode);
      developer.log(hotlinePresent.toString());
      if (hotlinePresent) {
        number = _data[UserAdd.zipcode];
      }

      developer.log(number);
    });
  }

  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Hotline number")),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomColoredText(
              text: "Your current zipcode: ${UserAdd.zipcode}",
              hexColor: "#2C3351",
              size: 16,
              weight: 400,
            ),
            const SizedBox(height: 16),
            (hotlinePresent)
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomColoredText(
                        text: "Your hotline number:",
                        hexColor: "#2C3351",
                        size: 16,
                        weight: 400,
                      ),
                      const SizedBox(height: 24),
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            launchDialer();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: HexColor("#848684"),
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.all(16),
                            child: CustomColoredText(
                              text: number,
                              hexColor: "#27A000",
                              size: 18,
                              weight: 500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : CustomColoredText(
                    text: "No hotlines available for your zipcode",
                    hexColor: "#2C3351",
                    size: 16,
                    weight: 400,
                  ),
          ],
        ),
      ),
    );
  }
}
