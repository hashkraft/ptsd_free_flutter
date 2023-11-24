import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ptsd_free/widgets/custom_colored_text.dart';
import 'package:ptsd_free/widgets/text_form_field.dart';
import 'package:ptsd_free/utils/functions.dart';
import 'dart:developer' as developer;

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController zipcodeController = TextEditingController();

  Future<void> signIn() async {
    String deviceId = (await getId()) ?? "";
    developer.log(deviceId);
    if (usernameController.text.isEmpty || zipcodeController.text.isEmpty) {
      developer.log("Enter all fields");
    } else if (deviceId.isNotEmpty) {
    } else {
      developer.log("Device ID cannot be found");
    }
    try {
      UserCredential user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: usernameController.text, password: deviceId);
      developer.log("User Signed in!");
      developer.log(user.user?.email ?? "");
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
            text: "Login", hexColor: "#FFFFFF", size: 22, weight: 500),
      ),
      body: Center(
        child: Container(
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
                      await signIn();
                      usernameController.clear();
                      zipcodeController.clear();
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
    );
  }
}
