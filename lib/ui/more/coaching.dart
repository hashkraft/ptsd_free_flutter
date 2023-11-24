import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ptsd_free/models/user.dart';
import 'package:ptsd_free/widgets/custom_colored_text.dart';
import 'package:ptsd_free/widgets/custom_text.dart';
import 'package:ptsd_free/widgets/testimonial_quote.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:developer' as developer;

class Coaching extends StatefulWidget {
  Coaching({super.key});

  @override
  State<Coaching> createState() => _CoachingState();
}

class _CoachingState extends State<Coaching> {
  String number = "9090909090";

  Future<void> _launchEmailUrl() async {
    final Uri url = Uri.parse(
        'mailto:developer@hashkraft.com?subject=News&body=New%20plugin');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> _launchCallUrl() async {
    FirebaseFirestore.instance
        .collection("hotline")
        .where("zipcode", isEqualTo: UserAdd.zipcode)
        .get()
        .then((value) async {
      if (value.docs.isEmpty) {
        var collection = FirebaseFirestore.instance.collection('hotline');
        var docSnapshot = await collection.doc('default').get();
        if (docSnapshot.exists) {
          Map<String, dynamic>? data = docSnapshot.data();
          var value = data?['default-hotline'];
          developer.log(value);

          setState(() {
            number = value;
          });
          final Uri url = Uri.parse('tel:$number');
          if (!await launchUrl(url)) {
            throw Exception('Could not launch $url');
          }
        }
      } else {
        for (var docSnapshot in value.docs) {
          number = docSnapshot.data()['hotline'];
          final Uri url = Uri.parse('tel:$number');
          if (!await launchUrl(url)) {
            throw Exception('Could not launch $url');
          }
        }
      }
    });
    // await loadFirebaseData().then((value) async {

    // });
  }

  Future<void> _launchSupportUrl() async {
    final Uri url = Uri.parse('https://flutter.dev');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor("#23C4F1"),
        leading: IconButton(
            onPressed: () {
              context.go("/home", extra: 4);
            },
            icon: const Icon(
              Icons.arrow_back_ios_sharp,
              color: Colors.white,
            )),
        title: CustomColoredText(
          text: "Live Coaching",
          hexColor: "#FFFFFF",
          size: 22,
          weight: 400,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomColoredText(
                text: "PTSD Free",
                hexColor: "#23C4F1",
                size: 18,
                weight: 500,
              ),
              const SizedBox(height: 16),
              const CustomText(
                text:
                    "Offers coaching over the phone. Contact us today to melt the stress away.",
                weight: 400,
              ),
              const SizedBox(height: 8),
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: const Divider(thickness: 0.8),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: _launchEmailUrl,
                    child: Image.asset(
                      "assets/images/coaching_email_icon.png",
                      width: MediaQuery.of(context).size.width * 0.2,
                    ),
                  ),
                  GestureDetector(
                    onTap: _launchCallUrl,
                    child: Image.asset(
                      "assets/images/coaching_call_icon.png",
                      width: MediaQuery.of(context).size.width * 0.2,
                    ),
                  ),
                  GestureDetector(
                    onTap: _launchSupportUrl,
                    child: Image.asset(
                      "assets/images/coaching_support_icon.png",
                      width: MediaQuery.of(context).size.width * 0.2,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: const Divider(thickness: 0.8),
                ),
              ),
              const SizedBox(height: 8),
              CustomColoredText(
                text: "Testimonials",
                hexColor: "#23C4F1",
                size: 18,
                weight: 500,
              ),
              const SizedBox(height: 16),
              const TestimonialQuote(
                  quote: "bla bla",
                  name: "Shubham Kunal",
                  desig1: "Desig1",
                  desig2: "Desig2"),
              const TestimonialQuote(
                  quote: "bla2 bla2",
                  name: "Shubham Kunal2",
                  desig1: "Desig1",
                  desig2: "Desig2"),
            ],
          ),
        ),
      ),
    );
  }
}
