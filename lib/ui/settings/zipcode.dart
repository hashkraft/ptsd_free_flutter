import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ptsd_free/models/user.dart';
import 'package:ptsd_free/utils/functions.dart';
import 'package:ptsd_free/widgets/custom_colored_text.dart';
import 'package:ptsd_free/widgets/text_form_field.dart';
import 'dart:developer' as developer;

class ZipCode extends StatefulWidget {
  const ZipCode({super.key});

  @override
  State<ZipCode> createState() => _ZipcodeState();
}

class _ZipcodeState extends State<ZipCode> {
  TextEditingController tec = TextEditingController();

  Future<void> changeZipCode(String zipNew) async {
    String deviceId = (await getId()) ?? "";
    await FirebaseFirestore.instance
        .collection("users-data")
        .where("deviceId", isEqualTo: deviceId)
        .get()
        .then((value) {
      print("Successfully completed");
      for (var docSnapshot in value.docs) {
        developer.log('OLD: ${docSnapshot.id} => ${docSnapshot.data()}');
        FirebaseFirestore.instance
            .collection('users-data')
            .doc(docSnapshot.id)
            .update({
          'zipcode': zipNew,
        });
        // docSnapshot.data(). update("zipcode", (value) => zipNew);
        // developer.log('NEW: ${docSnapshot.id} => ${docSnapshot.data()}');
      }
    });
    setState(() {
      UserAdd.zipcode = zipNew;
    });
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
              text: "Zipcode", hexColor: "#FFFFFF", size: 22, weight: 500),
        ),
        body: (UserAdd.zipcode.isEmpty)
            ? const Center(child: Text("Please register or login to continue"))
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomColoredText(
                          text: "Your current zipcode : ${UserAdd.zipcode}",
                          hexColor: "#2C3351",
                          size: 16,
                          weight: 700,
                        ),
                        const SizedBox(height: 16),
                        CustomColoredText(
                          text:
                              "Kindly update your zipcode if you have permanently relocated to ensure connection to the appropriate hotline number for help.",
                          hexColor: "#2C3351",
                          size: 16,
                          weight: 500,
                        ),
                        const SizedBox(height: 16),
                        CustomTextFormField(
                          controller: tec,
                          hintText: "Zipcode",
                          obscureText: false,
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: ElevatedButton(
                                style: ButtonStyle(backgroundColor:
                                    MaterialStateProperty.resolveWith<Color?>(
                                  (Set<MaterialState> states) {
                                    return Colors.blue;
                                  },
                                )),
                                onPressed: () {
                                  print(tec.text);
                                  changeZipCode(tec.text);
                                },
                                child: CustomColoredText(
                                  text: "Update Zipcode",
                                  hexColor: "#FFFFFF",
                                  size: 16,
                                  weight: 500,
                                ),
                              ),
                            ),
                            const SizedBox(),
                          ],
                        ),
                        const SizedBox(height: 8)
                      ],
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
