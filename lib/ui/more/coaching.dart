import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ptsd_free/models/user.dart';
import 'package:ptsd_free/ui/home_screen.dart';
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
  String number = "+18338673529";

  Future<void> _launchEmailUrl() async {
    final Uri url = Uri.parse(
        'mailto:brett@stressisgone.com?subject=Request%20for%20coaching&body=%20'); // TODO: Request for Coaching from PTSD Keys App
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
    final Uri url = Uri.parse('https://www.stressisgone.com/breakthrough-coaching-sessions');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (canpop) {
        // context.go("/home", extra: 4);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HomeScreen(currentIndex: 4)));
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: HexColor("#23C4F1"),
          leading: IconButton(
              onPressed: () {
                // context.go("/home", extra: 4);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomeScreen(currentIndex: 4)));
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
                  text: "PTSD Keys",
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
                  quote:
                      "The PTSD Keys mobile app has helped me manage my PTSD symptoms and reminds me to meditate daily. The app guides me through the techniques that are easy to practice anywhere, at anytime. My overall stress level is much less and I am able to handle high stress situations more clearly. I recommend the app and the coaching program to anyone suffering from PTSD.",
                  name:
                      "Kyle\nVeteran Operation Enduring Freedom\nIT professional\nSouthbury Connecticut",
                ),
                const TestimonialQuote(
                  quote:
                      "As a Doctor of 14 years, prior service member, and Director for a Civilian Navy SEAL Training Program, I understand stress. Stress Is Gone uses unique and innovative ways to help those seeking to manage emotional stressors. I have found their approach to be helpful with my patients overall sense of wellness and use the Stress Is Gone Program daily in my practice.",
                  name: "Dr. Stephen M. Erle",
                ),
                const TestimonialQuote(
                  quote:
                      "I did a 30-minute Stress Is Gone Coaching Session over the phone because I was having serious anxiety attacks on the job. I have not had one since.",
                  name: "Alex B., New York Law Enforcement Officer \n NY",
                ),
                const TestimonialQuote(
                  quote:
                      "The stress Hurricane Sandy caused drove me to attend a group meeting on stress relief. I truly believe that the practice of meditation which was initiated in this class has greatly reduced my stress level. I&#39;ve come to realize that the same way we have a weak or strong internal immune system, we have a weak or strong internal stress coping system. Since attending this class my ability to cope with stress and my decision making ability has improved dramatically.",
                  name: "Vicky Sabato, Belle Harbor \n Rockaway, Queens",
                ),
                const TestimonialQuote(
                  quote:
                      "The Stress Is Gone Class offered to our blinded veterans was very helpful, and our group enjoyed the format. The technique we learned helps us relax fast. I like the tool because I can use it whenever I’m stressed, want to relax, or go to sleep at night. This helps me regain control when life gets extra stressful.",
                  name:
                      "Irwin Baumel, Asst. Director \n Florida Regional Group, Blinded Veterans Association",
                ),
                const TestimonialQuote(
                  quote:
                      "Stress Is Gone has helped our multiply traumatized teens in the foster care system understand how their past trauma affects their current reactions and behaviors in a way that is age-appropriate. A safe, non-judgmental, and empowering experience is delivered in 1on1 and group formats. The tools reduce stress and develop positive coping skills. This has changed the thought and behavior patterns of even the most jaded of our clients from destructive to a more positive nature. Everyone who has experienced this work is truly in a better place.",
                  name:
                      "Monique Trucchio MSW, Program Supervisor \n Project Independence-Nassau County\n Family and Children Association, NY",
                ),
                const TestimonialQuote(
                  quote:
                      "Stress Is Gone uses easy steps to help readers work through Post Traumatic Stress (PTS) with a proven technique and user friendly program. If you’re trying to learn how to manage your stress, the PTSD Keys mobile app is a great addition to your relaxation and meditation program. I would absolutely recommend using Stress Is Gone to help manage your PTS symptoms.",
                  name:
                      "Juliet Madsen, US Army Retired \n Founder, www.strokeofluckquilting.com",
                ),
                const TestimonialQuote(
                  quote:
                      "I wanted to familiarize myself with practical skills for coping with stress, particularly during times of crises and the aftermath of Hurricane Sandy. The facilitators provided extremely useful tips when dealing with everyday stressful situations. The techniques can be applied anywhere and at anytime and are not difficult to learn. The objective is to make stress relief as natural as breathing itself and result in a mind over matter experience that quickly calms the body and mind.",
                  name: "Dympna, Rockaway Beach, Queens",
                ),
                const TestimonialQuote(
                  quote:
                      "After Hurricane Sandy, I&quot;ve been struggling with overwhelming feelings of anxiety and being out of control. Attending the Stress Relief Classes has taught me proactive skills I need to take better care of myself. I&quot;ve learned how to reduce my stress levels, and those feelings are no longer unmanageable. Most of all, breaking through the sense of isolation I&quot;ve felt has been priceless.",
                  name: "Angela Fogarty, Rockaway, Queens",
                ),
                const TestimonialQuote(
                  quote:
                      "In the midst of major life changes regarding my residence, a significant relationship and my financial situation, I was under heavy stress. With a series of sessions the stress began lifting and I got my life back.",
                  name: "Debra Gillen Fee \n Call Center Manager, NJ",
                ),
                const TestimonialQuote(
                  quote:
                      "In my sessions, Brett provided an ultra safe and non-judgmental space for me to express and be myself. He has a very clean, clear, positive and healthy energy that inspires and easily engages. Brett has done his own work and thus is able to guide clients through their emotional and spiritual work. I am grateful for my connection with him.",
                  name: "Joseph M. Psychotherapist",
                ),
                const TestimonialQuote(
                  quote:
                      "I originally contacted Stress Is Gone because I was feeling an excessive amount of stress and anxiety in various parts of my life. The facilitator worked with me through a process that is quite unique. I am pleased to say that the stress and anxiety is no longer present. I control it and it no longer controls me. These sessions helped me get my personal life and inner feelings from the past in check. This changed my entire life for the better. I highly recommend the coaching sessions and opening to the potential life has to offer you. You deserve it.",
                  name: "Ed Koch, Sales Manager, NYC",
                ),
                const TestimonialQuote(
                  quote:
                      "Brett Cotter’s chapter on mediation is a must read for any person experiencing stress, anxiety and tension. This is especially true for those individuals who are experiencing the effects of PTSD such as frequently reliving and reimagining a traumatic experience. The methods he recommends to help calm the body and mind are based upon sound principals of mediation and mindfulness and, if followed, will definitely help those who are troubled and in need. The Exercise on Tailoring Meditation, provides clear instructions for dealing with specific situations that trigger stress. I highly recommend Brett’s book to anyone who wants to lower their stress, anxiety and tension.",
                  name:
                      "James C. Petersen, Ph.D \n CEO & Founder,\n Stressmaster International, www.stressmaster.com",
                ),
                const TestimonialQuote(
                  quote:
                      "This guide is a unique and comprehensive approach to what is clearly an epidemic amongst our military heroes. With step-by-step logic and a hands-on approach, this important work provides a practical blueprint for veterans to use to overcome this often debilitating disease. Bravo!",
                  name: "JR Rodrigues, Founder, JoblessWarrior.org",
                ),
                const TestimonialQuote(
                  quote:
                      "This is an outstanding resource for Veterans that have been diagnosed with PTSD. This book includes a free mobile app and online membership. The meditations, exercises, and measurements are comprehensive and easy to apply. They have helped me personally on my path to recovery from prolonged stress as a recruiter in the United States Army. I recommend the book to other veterans!",
                  name: "James Corona, SFC \n US Army, USAREC",
                ),
                const TestimonialQuote(
                  quote:
                      "I highly recommend this book to veterans and their families suffering with PTSD. This resource provides practical advice, step-by-step strategies and key tools for veterans, or anyone looking to better manage their PTSD symptoms. Cotter’s section on meditation is excellent!",
                  name:
                      "Aaron F. Glover, U.S. Air Force Veteran \n Speaker, Veteran Advocate",
                ),
                const TestimonialQuote(
                  quote:
                      "I really like how this book is written, in simple terms. Anyone dealing with PTSD symptoms can pick it up on the fly and reduce their stress. You don&#39;t have to be a social worker or clinician to use the tools and techniques.",
                  name:
                      "Paul Sangalli, Ret. Air Force \n Veterans Outreach Program Specialist,\n NYS Dept. of Labor",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
