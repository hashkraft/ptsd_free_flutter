import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ptsd_free/models/user.dart';
import 'package:ptsd_free/ui/home_screen.dart';
import 'package:ptsd_free/utils/functions.dart';
import 'package:ptsd_free/widgets/custom_colored_text.dart';
import 'package:ptsd_free/widgets/custom_dropdown.dart';
import 'package:ptsd_free/widgets/text_form_field.dart';
import 'dart:developer' as developer;

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  TextEditingController emailController = TextEditingController();
  // TextEditingController passwordController = TextEditingController();
  // TextEditingController cPasswordController = TextEditingController();
  TextEditingController zipcodeController = TextEditingController();
  String profession = "Military Veteran";
  List<String> professions = [
    "Military Veteran",
    "Active-Duty Military",
    "First Responder",
    "Healthcare Worker",
    "Caregiver",
  ];

  Future<void> createAccount() async {
    String deviceId = (await getId()) ?? "";
    developer.log(deviceId);
    if (emailController.text.isEmpty || zipcodeController.text.isEmpty) {
      showSnackbarWithColor(context, "Enter all fields", Colors.red);
      // developer.log("Enter all fields");
    } else if (isEmail(emailController.text) == false) {
      showSnackbarWithColor(context, "Email is invalid", Colors.red);
    } else if (isNumeric(zipcodeController.text) == false) {
      showSnackbarWithColor(context, "Zipcode is invalid", Colors.red);
    } else if (deviceId.isNotEmpty) {
      try {
        UserCredential user =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: deviceId,
        );
        developer.log("User Created!");
        // context.go("/home");
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HomeScreen(currentIndex: 0)));
      } on FirebaseAuthException catch (ex) {
        developer.log(ex.toString());
      }
    } else {
      developer.log("Device ID cannot be found");
    }
  }

  bool isEmail(String email) {
    RegExp emailRegex = RegExp(
      r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$',
      caseSensitive: false,
      multiLine: false,
    );

    return emailRegex.hasMatch(email);
  }

  bool isNumeric(String input) {
    try {
      double.parse(input);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor("#23C4F1"),
        automaticallyImplyLeading: false,
        title: CustomColoredText(
            text: "Register to PTSD Keys App",
            hexColor: "#FFFFFF",
            size: 22,
            weight: 500),
      ),
      body: (UserAdd.zipcode.isNotEmpty)
          ? const Center(child: Text("You're already registered!"))
          : SingleChildScrollView(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomColoredText(
                          text:
                              "To ensure you receive prompt and personalized assistance, please fill in the information below to see which free local support services we have in your area.",
                          hexColor: "#2C3351",
                          size: 18,
                          weight: 500,
                        ),
                        const SizedBox(height: 8),
                        CustomColoredText(
                          text:
                              "Your privacy is our priority. We respect and protect all your information.",
                          hexColor: "#2C3351",
                          size: 18,
                          weight: 500,
                        ),
                        const SizedBox(height: 32),
                        CustomColoredText(
                          text: "Email: ",
                          hexColor: "#2C3351",
                          size: 16,
                          weight: 500,
                        ),
                        const SizedBox(height: 8),
                        CustomTextFormField(
                          controller: emailController,
                          hintText: "Email",
                          obscureText: false,
                        ),
                        const SizedBox(height: 16),
                        CustomColoredText(
                          text: "Zip Code: ",
                          hexColor: "#2C3351",
                          size: 16,
                          weight: 500,
                        ),
                        const SizedBox(height: 8),
                        CustomTextFormField(
                          controller: zipcodeController,
                          hintText: "Zip Code",
                          obscureText: false,
                        ),
                        const SizedBox(height: 16),
                        CustomColoredText(
                          text: "Profession: ",
                          hexColor: "#2C3351",
                          size: 16,
                          weight: 500,
                        ),
                        const SizedBox(height: 8),
                        CustomDropDown(
                            items: professions,
                            value: profession,
                            onChanged: (value) {
                              setState(() {
                                profession = value!;
                              });
                            }),
                      ],
                    ),
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
                              onPressed: () async {
                                developer.log(emailController.text);
                                developer.log(zipcodeController.text);

                                if (emailController.text.isEmpty ||
                                    zipcodeController.text.isEmpty) {
                                  showSnackbarWithColor(context,
                                      "Please fill fields!", Colors.redAccent);
                                } else if (isEmail(emailController.text) ==
                                    false) {
                                  showSnackbarWithColor(context,
                                      "Email is invalid", Colors.redAccent);
                                } else if (isNumeric(zipcodeController.text) ==
                                    false) {
                                  showSnackbarWithColor(context,
                                      "Zipcode is invalid", Colors.redAccent);
                                } else {
                                  String username = emailController.text;
                                  String zipcode = zipcodeController.text;
                                  String deviceId = (await getId()) ?? "";
                                  // await createAccount();
                                  UserAdd.setValues(
                                    user: username,
                                    // pass: password,
                                    zip: zipcode,
                                    deviceId: deviceId,
                                  );

                                  developer.log("Values Set!");
                                  await FirebaseFirestore.instance
                                      .collection('users-data')
                                      .add({
                                    "username": username,
                                    // "password": password,
                                    "zipcode": zipcode,
                                    "profession": profession,
                                    "deviceId": deviceId,
                                  }).whenComplete(() {
                                    showSnackbarWithColor(
                                        context,
                                        "User Successfully Registered",
                                        Colors.green);
                                    developer.log("Row Added!");
                                    emailController.clear();
                                    // passwordController.clear();
                                    // cPasswordController.clear();
                                    zipcodeController.clear();
                                    Future.delayed(const Duration(seconds: 1),
                                        () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => HomeScreen(
                                            currentIndex: 0,
                                          ),
                                        ),
                                      );
                                    });
                                  });
                                }
                              },
                              child: CustomColoredText(
                                text: "Register",
                                hexColor: "#FFFFFF",
                                size: 16,
                                weight: 500,
                              ),
                            ),
                          ),
                          const SizedBox(),
                        ],
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
