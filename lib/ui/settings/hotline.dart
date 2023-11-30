import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';
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

  Future<void> loadFirebaseData() async {
    FirebaseFirestore.instance
        .collection("hotline")
        .where("zipcode", isEqualTo: UserAdd.zipcode)
        .get()
        .then((value) async {
      if (value.docs.isEmpty) {
        // final document = FirebaseFirestore.instance.doc("hotline/default");
        var collection = FirebaseFirestore.instance.collection('hotline');
        var docSnapshot = await collection.doc('default').get();
        if (docSnapshot.exists) {
          Map<String, dynamic>? data = docSnapshot.data();
          var value = data?['default-hotline'];
          developer.log(value);

          setState(() {
            number = value;
          });
        }
        // number = "9090909090";
        // setState(() {
        //   hotlinePresent = true;
        // });
      } else {
        for (var docSnapshot in value.docs) {
          developer.log(docSnapshot.data().toString());
          setState(() {
            hotlinePresent = true;
          });
          number = docSnapshot.data()['hotline'];
        }
      }
    });
  }

  @override
  void initState() {
    loadFirebaseData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (canpop) {
        context.go("/home", extra: 3);
      },
      child: Scaffold(
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
              text: "Hotline Number",
              hexColor: "#FFFFFF",
              size: 22,
              weight: 500),
        ),
        body: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomColoredText(
                text: "Your current zipcode: ${UserAdd.zipcode}",
                hexColor: "#2C3351",
                size: 16,
                weight: 700,
              ),
              const SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomColoredText(
                    text:
                        "Please contact the hotline number provided below for assistance if needed.",
                    hexColor: "#2C3351",
                    size: 16,
                    weight: 400,
                  ),
                  const SizedBox(height: 16),
                  CustomColoredText(
                    text: "Tap on the number below to initial a direct call.",
                    hexColor: "#2C3351",
                    size: 16,
                    weight: 400,
                  ),
                  const SizedBox(height: 32),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        launchDialer();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: HexColor("#BBBBBB"),
                          ),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.call,
                              color: HexColor("#0E9E50"),
                            ),
                            const SizedBox(width: 16),
                            CustomColoredText(
                              text: number,
                              hexColor: "#0E9E50",
                              size: 18,
                              weight: 500,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
