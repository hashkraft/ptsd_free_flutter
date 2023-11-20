import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              context.go("/home", extra: 3);
            },
            icon: const Icon(Icons.arrow_back_ios_new_sharp)),
        title: const Text("Zipcode"),
      ),
      body: (UserAdd.zipcode.isEmpty)
          ? const Center(child: Text("Please register or login to continue"))
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomColoredText(
                    text:
                        "If you wish to update your zipcode enter the new one here:",
                    hexColor: "#2C3351",
                    size: 16,
                    weight: 500,
                  ),
                  const SizedBox(height: 8),
                  CustomColoredText(
                    text: "Your current zipcode : ${UserAdd.zipcode}",
                    hexColor: "#2C3351",
                    size: 16,
                    weight: 500,
                  ),
                  const SizedBox(height: 8),
                  CustomTextFormField(
                    controller: tec,
                    hintText: "Zipcode",
                    obscureText: false,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(),
                      ElevatedButton(
                        onPressed: () {
                          print(tec.text);
                          changeZipCode(tec.text);
                        },
                        child: Text("Submit"),
                      ),
                      const SizedBox(),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
