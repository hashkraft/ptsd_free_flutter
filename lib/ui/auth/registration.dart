import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ptsd_free/models/user.dart';
import 'package:ptsd_free/utils/functions.dart';
import 'package:ptsd_free/widgets/custom_colored_text.dart';
import 'package:ptsd_free/widgets/text_form_field.dart';
import 'dart:developer' as developer;

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cPasswordController = TextEditingController();
  TextEditingController zipcodeController = TextEditingController();

  Future<void> createAccount() async {
    String deviceId = (await getId()) ?? "";
    developer.log(deviceId);
    if (usernameController.text.isEmpty || zipcodeController.text.isEmpty) {
      developer.log("Enter all fields");
    } else if (deviceId.isNotEmpty) {
    } else {
      developer.log("Device ID cannot be found");
    }
    try {
      UserCredential user =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: usernameController.text,
        password: deviceId,
      );
      developer.log("User Created!");
    } on FirebaseAuthException catch (ex) {
      developer.log(ex.toString());
    }
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
            text: "Registration", hexColor: "#FFFFFF", size: 22, weight: 500),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: (UserAdd.zipcode.isNotEmpty)
              ? const Text("You're already registered!")
              : Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomColoredText(
                        text: "Username: ",
                        hexColor: "#2C3351",
                        size: 16,
                        weight: 500,
                      ),
                      const SizedBox(height: 8),
                      CustomTextFormField(
                        controller: usernameController,
                        hintText: "Username",
                        obscureText: false,
                      ),
                      const SizedBox(height: 16),
                      CustomColoredText(
                        text: "Password: ",
                        hexColor: "#2C3351",
                        size: 16,
                        weight: 500,
                      ),
                      const SizedBox(height: 8),
                      CustomTextFormField(
                        controller: passwordController,
                        hintText: "Password",
                        obscureText: true,
                      ),
                      const SizedBox(height: 16),
                      CustomColoredText(
                        text: "Confirm Password: ",
                        hexColor: "#2C3351",
                        size: 16,
                        weight: 500,
                      ),
                      const SizedBox(height: 8),
                      CustomTextFormField(
                        controller: cPasswordController,
                        hintText: "Confirm Password",
                        obscureText: true,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(),
                          ElevatedButton(
                            onPressed: () async {
                              developer.log(usernameController.text);
                              developer.log(zipcodeController.text);

                              if (passwordController.text !=
                                  cPasswordController.text) {
                                showSnackbarWithColor(
                                    context,
                                    "Passwords do not match!",
                                    Colors.redAccent);
                              } else if (usernameController.text.isEmpty ||
                                  passwordController.text.isEmpty ||
                                  cPasswordController.text.isEmpty ||
                                  zipcodeController.text.isEmpty) {
                                showSnackbarWithColor(context,
                                    "Please fill fields!", Colors.redAccent);
                              } else {
                                String username = usernameController.text;
                                String password = passwordController.text;
                                String zipcode = zipcodeController.text;
                                String deviceId = (await getId()) ?? "";
                                // await createAccount();
                                UserAdd.setValues(
                                  user: username,
                                  pass: password,
                                  zip: zipcode,
                                  deviceId: deviceId,
                                );
                                developer.log("Values Set!");
                                await FirebaseFirestore.instance
                                    .collection('users-data')
                                    .add({
                                  "username": username,
                                  "password": password,
                                  "zipcode": zipcode,
                                  "deviceId": deviceId,
                                }).whenComplete(() {
                                  showSnackbarWithColor(
                                      context, "User Added!", Colors.green);
                                  developer.log("Row Added!");
                                  usernameController.clear();
                                  passwordController.clear();
                                  cPasswordController.clear();
                                  zipcodeController.clear();
                                  Future.delayed(const Duration(seconds: 1),
                                      () {
                                    context.go("/home");
                                  });
                                });
                              }
                            },
                            child: const Text("Submit"),
                          ),
                          const SizedBox(),
                        ],
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
